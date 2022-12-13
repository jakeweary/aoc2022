const aoc = @import("root");
const std = @import("std");

pub fn Grid(comptime T: type) type {
  return struct {
    const Self = @This();

    size: @Vector(2, usize),
    table: std.ArrayList(T),

    pub fn parsed(alc: std.mem.Allocator, input: []const u8) !Self {
      var table = std.ArrayList(u8).init(alc);
      errdefer table.deinit();

      var lines = std.mem.tokenize(u8, input, "\n");
      while (lines.next()) |line|
        try table.appendSlice(line);

      const w = std.mem.indexOfScalar(u8, input, '\n').?;
      const h = table.items.len / w;
      return Self.init(.{ w, h }, table);
    }

    pub fn filled(alc: std.mem.Allocator, size: @Vector(2, usize), value: T) !Self {
      var table = std.ArrayList(T).init(alc);
      try table.resize(@reduce(.Mul, size));
      std.mem.set(T, table.items, value);

      return Self.init(size, table);
    }

    pub fn init(size: @Vector(2, usize), table: std.ArrayList(T)) !Self {
      return Self{ .size = size, .table = table };
    }

    pub fn deinit(self: *const Self) void {
      self.table.deinit();
    }

    pub fn at(self: *const Self, xy: @Vector(2, usize)) *T {
      return &self.table.items[xy[0] + xy[1] * self.size[0]];
    }

    pub fn findAndReplace(self: *Self, item: T, replace_with: T) ?@Vector(2, usize) {
      const i = std.mem.indexOfScalar(T, self.table.items, item) orelse return null;
      self.table.items[i] = replace_with;
      return .{ i % self.size[0], i / self.size[0] };
    }
  };
}
