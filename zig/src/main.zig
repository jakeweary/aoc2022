const builtin = @import("builtin");
const std = @import("std");

fn solve(alc: std.mem.Allocator) !void {
  try @import("day01/solve.zig").solve(alc);
  try @import("day02/solve.zig").solve(alc);
}

pub fn main() !void {
  if (builtin.mode == .Debug or builtin.link_libc == false) {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    try solve(gpa.allocator());
  }
  else {
    try solve(std.heap.c_allocator);
  }
}

test {
  std.testing.refAllDecls(@This());
}
