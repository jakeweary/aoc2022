const aoc = @import("root");
const std = @import("std");

const LUT = blk: {
  var arr: [3][3][2]u4 = undefined;
  for (arr) |*row, a| {
    for (row) |*ptr, b| {
      const part1 = (4 + b - a) % 3 * 3 + b + 1;
      const part2 = (2 + b + a) % 3 + 3 * b + 1;
      ptr.* = .{ part1, part2 };
    }
  }
  break :blk arr;
};

pub fn solve(ctx: aoc.Context) ![2]u32 {
  var result: @Vector(2, u32) = .{ 0, 0 };
  var lines = std.mem.tokenize(u8, ctx.input, "\n");
  while (lines.next()) |line|
    result += LUT[line[0] - 'A'][line[2] - 'X'];
  return result;
}
