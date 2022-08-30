const std = @import("std");

const Error = error{SyntaxError};

fn parseBool(str: []const u8) !bool {
    const expectedValues = .{
        .{ .s = "1", .v = true },
        .{ .s = "t", .v = true },
        .{ .s = "T", .v = true },
        .{ .s = "true", .v = true },
        .{ .s = "TRUE", .v = true },
        .{ .s = "True", .v = true },
        .{ .s = "0", .v = false },
        .{ .s = "f", .v = false },
        .{ .s = "F", .v = false },
        .{ .s = "false", .v = false },
        .{ .s = "FALSE", .v = false },
        .{ .s = "False", .v = false },
    };
    inline for (expectedValues) |expectedValue| {
        if (std.mem.eql(u8, str, expectedValue.s)) {
            return expectedValue.v;
        }
    }
    return error.SyntaxError;
}

test {
    const expect = std.testing.expect;
    const expectError = std.testing.expectError;

    try expect(try parseBool("1"));
    try expect(try parseBool("t"));
    try expect(try parseBool("T"));
    try expect(try parseBool("true"));
    try expect(try parseBool("TRUE"));
    try expect(try parseBool("True"));

    try expect(!try parseBool("0"));
    try expect(!try parseBool("f"));
    try expect(!try parseBool("F"));
    try expect(!try parseBool("false"));
    try expect(!try parseBool("FALSE"));
    try expect(!try parseBool("False"));

    try expectError(error.SyntaxError, parseBool("X"));
}
