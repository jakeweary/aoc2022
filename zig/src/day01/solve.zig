const std = @import("std");

pub fn solve(alc: std.mem.Allocator) !void {
  const input = try std.fs.cwd().readFileAlloc(alc, ".input/day01", std.math.maxInt(usize));
  defer alc.free(input);

  var totals = std.ArrayList(u32).init(alc);
  defer totals.deinit();

  try totals.append(0);

  const trimmed = std.mem.trimRight(u8, input, &std.ascii.whitespace);
  var lines = std.mem.split(u8, trimmed, "\n");
  while (lines.next()) |line| {
    switch (line.len) {
      0 => try totals.append(0),
      else => {
        const n = try std.fmt.parseInt(u32, line, 10);
        totals.items[totals.items.len - 1] += n;
      },
    }
  }

  std.sort.sort(u32, totals.items, {}, std.sort.desc(u32));

  const part1 = totals.items[0];
  const part2 = @reduce(.Add, @as(@Vector(3, u32), totals.items[0..3].*));

  std.debug.print("day01: {} {}\n", .{ part1, part2 });
}
