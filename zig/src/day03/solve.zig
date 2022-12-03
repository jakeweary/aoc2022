const aoc = @import("root");
const std = @import("std");

fn priority(item: u8) u6 {
  const mod = 'z' - 'A' + 1;
  const shift = 'a' % mod;
  return @truncate(u6, (item - shift) % mod);
}

fn bitset(items: []const u8) u52 {
  var bits: u52 = 0;
  for (items) |item|
    bits |= @as(u52, 1) << priority(item);
  return bits;
}

pub fn solve(ctx: aoc.Context) ![2]u32 {
  var part1: u32 = 0;
  var part2: u32 = 0;

  var group_bits = ~@as(u52, 0);

  var i: usize = 0;
  var lines = std.mem.tokenize(u8, ctx.input, "\n");
  while (lines.next()) |line| : (i += 1) {
    const mid = line.len / 2;
    const line_bits = bitset(line[0..mid]) & bitset(line[mid..]);
    part1 += @ctz(line_bits) + 1;

    group_bits &= bitset(line);
    if (i % 3 == 2) {
      part2 += @ctz(group_bits) + 1;
      group_bits = ~@as(u52, 0);
    }
  }

  return .{ part1, part2 };
}
