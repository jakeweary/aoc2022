const std = @import("std");

pub fn build(b: *std.Build) void {
  const target = b.standardTargetOptions(.{});
  const optimize = b.standardOptimizeOption(.{});

  const libc = b.option(bool, "libc", "Link libc");
  const strip = b.option(bool, "strip", "Strip");

  const exe = b.addExecutable(.{
    .name = "aoc",
    .root_source_file = .{ .path = "src/main.zig" },
    .target = target,
    .optimize = optimize,
  });
  if (libc == true) exe.linkLibC();
  exe.strip = strip;
  exe.single_threaded = true;
  exe.install();

  const run_cmd = exe.run();
  run_cmd.step.dependOn(b.getInstallStep());
  run_cmd.addArgs(b.args orelse &.{});

  const run_step = b.step("run", "Run the app");
  run_step.dependOn(&run_cmd.step);

  const exe_tests = b.addTest(.{
    .root_source_file = .{ .path = "src/main.zig" },
    .target = target,
    .optimize = optimize,
  });

  const test_step = b.step("test", "Run unit tests");
  test_step.dependOn(&exe_tests.step);
}
