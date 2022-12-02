const std = @import("std");

const LUT = blk: {
  var arr: [3][3][2]u4 = undefined;
  var a: usize = 0;
  while (a < 3) : (a += 1) {
    var b: usize = 0;
    while (b < 3) : (b += 1) {
      const p1 = 1 + b + (4 + b - a) % 3 * 3;
      const p2 = 1 + (2 + b + a) % 3 + b * 3;
      arr[a][b] = .{ p1, p2 };
    }
  }
  break :blk arr;
};

pub fn solve(alc: std.mem.Allocator) !void {
  const input = try std.fs.cwd().readFileAlloc(alc, ".input/day02", std.math.maxInt(usize));
  defer alc.free(input);

  var part1: u32 = 0;
  var part2: u32 = 0;

  var lines = std.mem.tokenize(u8, input, "\n");
  while (lines.next()) |line| {
    const values = LUT[line[0] - 'A'][line[2] - 'X'];
    part1 += values[0];
    part2 += values[1];
  }

  std.debug.print("day02: {} {}\n", .{ part1, part2 });
}
