const std = @import("std");
const print = std.debug.print;

test "check_one" {
    try std.testing.expect(check_one(&.{ 1, 2, 3, 4 }) == true);
    try std.testing.expect(check_one(&.{ 7, 12, 17, 22, 27 }) == false);
    try std.testing.expect(check_one(&.{ 1, 2, 3, 5 }) == true);
    try std.testing.expect(check_one(&.{ 2, 4, 6, 4 }) == false);
}

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

            if (check_one(ar.items)) {
                sum += 1;
            }
        }
        ar.clearRetainingCapacity();
    }
    print("{d}", .{sum});
}
