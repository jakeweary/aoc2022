const aoc = @import("root");
const std = @import("std");

fn priority(item: u8) u8 {
  const mod = 'z' - 'A' + 1;
  const shift = 'a' % mod;
  return (item - shift) % mod;
}

fn bitset(items: []const u8) u52 {
  var bits: u52 = 0;
  for (items) |item|
    bits |= @as(u52, 1) << @truncate(u6, priority(item));
  return bits;
}

fn commonBit(comptime N: usize, bitsets: @Vector(N, u52)) u6 {
  return 52 - @clz(@reduce(.And, bitsets));
}

pub fn solve(ctx: aoc.Context) ![2]u32 {
  var part1: u32 = 0;
  var part2: u32 = 0;

  var group_sets: [3]u52 = undefined;

  var i: usize = 0;
  var lines = std.mem.tokenize(u8, ctx.input, "\n");
  while (lines.next()) |line| : (i = (i + 1) % 3) {
    const mid = line.len / 2;
    const line_sets = .{ bitset(line[0..mid]), bitset(line[mid..]) };
    group_sets[i] = bitset(line);

    part1 += commonBit(2, line_sets);
    if (i == 2)
      part2 += commonBit(3, group_sets);
  }

  return .{ part1, part2 };
}
