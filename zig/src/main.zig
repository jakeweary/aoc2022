const builtin = @import("builtin");
const std = @import("std");
const days = struct {
  const day01 = @import("day01/solve.zig");
  const day02 = @import("day02/solve.zig");
  const day03 = @import("day03/solve.zig");
  const day12 = @import("day12/solve.zig");
};

pub const Context = struct {
  allocator: std.mem.Allocator,
  stdout: std.fs.File.Writer,
  input: []const u8,
};

pub fn main() !void {
  if (builtin.mode == .Debug or builtin.link_libc == false) {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    try solveAllDays(gpa.allocator());
  }
  else {
    try solveAllDays(std.heap.c_allocator);
  }
}

fn solveAllDays(alc: std.mem.Allocator) !void {
  const stdout = std.io.getStdOut().writer();

  inline for (@typeInfo(days).Struct.decls) |day| {
    const path = ".input/" ++ day.name;
    const input = try std.fs.cwd().readFileAlloc(alc, path, std.math.maxInt(usize));
    defer alc.free(input);

    var timer = try std.time.Timer.start();
    const ctx = .{ .allocator = alc, .stdout = stdout, .input = input };
    const answers = try @field(days, day.name).solve(ctx);
    const time = std.fmt.fmtDuration(timer.read());

    try stdout.print("{s}: ", .{ day.name });
    try printAndFree(ctx, answers[0]);
    try printAndFree(ctx, answers[1]);
    try stdout.print("({})\n", .{ time });
  }
}

fn printAndFree(ctx: Context, answer: anytype) !void {
  switch (@typeInfo(@TypeOf(answer))) {
    .Pointer => {
      try ctx.stdout.print("{s} ", .{ answer });
      ctx.allocator.free(answer);
    },
    else => try ctx.stdout.print("{any} ", .{ answer }),
  }
}

test {
  std.testing.refAllDecls(@This());
}
