const std = @import("std");
const print = std.debug.print;

fn test_parse_line(input: []const u8, output: []const i32) !void {
    const allocator = std.testing.allocator;
    var a = std.ArrayList(i32).init(allocator);
    defer a.deinit();
    parse_line(&a, input);
    try std.testing.expect(std.mem.eql(i32, a.items, output));
}
test "parse_line" {
    try test_parse_line("1", &.{1});
    try test_parse_line("123", &.{123});
    try test_parse_line("123 456", &.{ 123, 456 });
    try test_parse_line("123 456 789", &.{ 123, 456, 789 });
}

inline fn in_range(a: i32, b: i32) bool {
    return @abs(a - b) <= 3 and @abs(a - b) >= 1;
}

inline fn same_dir(increasing: bool, prev: i32, next: i32) bool {
    return (increasing and next > prev) or (!increasing and prev > next);
}

inline fn safe(increasing: bool, prev: i32, next: i32) bool {
    return same_dir(increasing, prev, next) and in_range(prev, next);
}

fn check_one(v: []const i32) bool {
    if (v.len <= 1) {
        return true;
    }
    if (@abs(v[1] - v[0]) > 3 or @abs(v[1] - v[0]) < 1) {
        return false;
    }
    const increasing = v[1] > v[0];
    var prev = v[1];
    for (2..v.len) |i| {
        const x = v[i];
        if (@abs(x - prev) < 1 or @abs(x - prev) > 3 or (increasing and prev > x) or (!increasing and x > prev)) {
            return false;
        }
        prev = x;
    }
    return true;
}

fn parse_line(x: *std.ArrayList(i32), v: []const u8) void {
    var it = std.mem.split(u8, v, " ");

    while (it.next()) |token| {
        const value = std.fmt.parseInt(i32, token, 10) catch return;
        x.*.append(value) catch return;
    }
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const stdin = std.io.getStdIn().reader();
    var buf: [256]u8 = undefined;
    var ar = std.ArrayList(i32).init(allocator);
    defer ar.deinit();
    var sum: i32 = 0;
    while (true) {
        const line = try stdin.readUntilDelimiterOrEof(&buf, '\n') orelse break;
        if (line.len != 0) {
            parse_line(&ar, line);

            const n = ar.items.len;
            for (0..n) |i| {
                const v = ar.orderedRemove(i);
                if (check_one(ar.items[0 .. n - 1])) {
                    sum += 1;
                    break;
                }
                _ = try ar.insert(i, v);
            }
        }
        ar.clearRetainingCapacity();
    }
    print("{d}", .{sum});
}
