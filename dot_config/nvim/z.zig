const std = @import("std");

fn foo(num: u8, num2: u8) u8 {
    return num + num2;
}

fn bar() u8 {
    return 10;
}

pub fn main() !void {
    std.debug.print("Test\n", .{});

    std.debug.print("test number {d}\n", .{bar()});
    std.debug.print("test number 2 {d}\n", .{foo(10, 20)});

    const _foobar = foo(8, 10);
}
