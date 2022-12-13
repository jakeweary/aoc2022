const aoc = @import("root");
const std = @import("std");
const Grid = @import("Grid.zig").Grid;

const QueueItem = struct {
  xy: @Vector(2, usize),
  cost: u32,

  pub fn order(_: void, a: QueueItem, b: QueueItem) std.math.Order {
    return std.math.order(a.cost, b.cost);
  }
};

fn shortestPath(
  allocator: std.mem.Allocator,
  height_map: *const Grid(u8),
  sources: []const @Vector(2, usize),
  target: @Vector(2, usize),
) !u32 {
  var cost_map = try Grid(u32).filled(allocator, height_map.size, std.math.maxInt(u32));
  defer cost_map.deinit();

  var queue = std.PriorityQueue(QueueItem, void, QueueItem.order).init(allocator, {});
  defer queue.deinit();

  for (sources) |source| {
    try queue.add(.{ .xy = source, .cost = 0 });
    cost_map.at(source).* = 0;
  }

  while (queue.removeOrNull()) |current| {
    if (@reduce(.And, current.xy == target))
      return current.cost;

    if (current.cost > cost_map.at(current.xy).*)
      continue;

    const next_height_limit = height_map.at(current.xy).* + 1;
    const next_cost = current.cost + 1;

    const directions = [_][2]usize{
      .{ 0, 1 }, .{ 1, 0 }, // left, up
      .{ 2, 1 }, .{ 1, 2 }, // right, down
    };

    const direction_will_not_overflow =
      @as([2]bool,                   current.xy > [_]usize{ 0, 0 }) ++
      @as([2]bool, height_map.size - current.xy > [_]usize{ 1, 1 });

    inline for (directions) |direction, i| {
      if (direction_will_not_overflow[i]) {
        const next_xy = current.xy + direction - [_]usize{ 1, 1 };
        var cost_so_far = cost_map.at(next_xy);
        if (next_cost < cost_so_far.* and height_map.at(next_xy).* <= next_height_limit) {
          try queue.add(.{ .xy = next_xy, .cost = next_cost });
          cost_so_far.* = next_cost;
        }
      }
    }
  }

  unreachable;
}

pub fn solve(ctx: aoc.Context) ![2]u32 {
  var height_map = try Grid(u8).parsed(ctx.allocator, ctx.input);
  defer height_map.deinit();

  const source = height_map.findAndReplace('S', 'a').?;
  const target = height_map.findAndReplace('E', 'z').?;

  var part2_sources = std.ArrayList(@Vector(2, usize)).init(ctx.allocator);
  defer part2_sources.deinit();

  var y: usize = 0;
  while (y < height_map.size[1]) : (y += 1)
    try part2_sources.append(.{ 0, y });

  const part1 = try shortestPath(ctx.allocator, &height_map, &.{ source },        target);
  const part2 = try shortestPath(ctx.allocator, &height_map, part2_sources.items, target);

  return .{ part1, part2 };
}
