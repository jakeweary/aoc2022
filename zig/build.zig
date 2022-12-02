const std = @import("std");

pub fn build(b: *std.build.Builder) void {
  const target = b.standardTargetOptions(.{});
  const mode = b.standardReleaseOptions();
  const libc = b.option(bool, "libc", "Link libc");
  const strip = b.option(bool, "strip", "Strip");

  const exe = b.addExecutable("aoc", "src/main.zig");
  if (libc == true) exe.linkLibC();
  exe.strip = strip;
  exe.single_threaded = true;
  exe.setTarget(target);
  exe.setBuildMode(mode);
  exe.install();

  const run_cmd = exe.run();
  run_cmd.step.dependOn(b.getInstallStep());
  run_cmd.addArgs(b.args orelse &[_][]const u8{});

  const run_step = b.step("run", "Run the app");
  run_step.dependOn(&run_cmd.step);

  const exe_tests = b.addTest("src/main.zig");
  exe_tests.setTarget(target);
  exe_tests.setBuildMode(mode);

  const test_step = b.step("test", "Run unit tests");
  test_step.dependOn(&exe_tests.step);
}
