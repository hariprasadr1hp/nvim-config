// Zig example to test editor settings

const std = @import("std");

pub fn main() void {
    // Print to stdout
    std.debug.print("Hello, {}!\n", .{"Zig"});
    
    // Variable declarations (inferred types)
    var x = 10;
    var name = "John Doe";
    var is_active = true;
    
    // Variable with explicit type annotation
    var y: f64 = 5.67;

    // Constant declarations
    const pi = 3.14159;
    
    // Print variable values
    std.debug.print("x: {}, y: {}, pi: {}\n", .{x, y, pi});

    // If-else conditional
    if (is_active) {
        std.debug.print("The user {} is active.\n", .{name});
    } else {
        std.debug.print("The user {} is not active.\n", .{name});
    }

    // For loop with ranges
    for (0..5) |i| {
        std.debug.print("For loop iteration: {}\n", .{i});
    }

    // While loop
    var i = 0;
    while (i < 5) : (i += 1) {
        std.debug.print("While loop iteration: {}\n", .{i});
    }

    // Arrays
    const numbers = [_]u32{1, 2, 3, 4, 5};
    for (numbers) |num| {
        std.debug.print("Array value: {}\n", .{num});
    }

    // Switch statement (similar to match)
    const fruit = "apple";
    switch (fruit) {
        "apple" => std.debug.print("Fruit is an apple\n", .{}),
        "banana" => std.debug.print("Fruit is a banana\n", .{}),
        else => std.debug.print("Unknown fruit\n", .{}),
    }

    // Function calls
    const result = add(10, 20);
    std.debug.print("Addition result: {}\n", .{result});
    
    // Inline functions (anonymous functions)
    const multiply = blk: fn (a: i32, b: i32) i32 {
        return a * b;
    };

    const product = multiply(4, 5);
    std.debug.print("Multiplication result: {}\n", .{product});

    // Error handling
    const division_result = div(10, 2) catch |err| {
        std.debug.print("Error: {}\n", .{err});
        return;
    };
    std.debug.print("Division result: {}\n", .{division_result});

    // Structs and objects
    const point = Point{ .x = 3, .y = 4 };
    std.debug.print("Point: ({}, {})\n", .{point.x, point.y});
}

// Functions
fn add(a: i32, b: i32) i32 {
    return a + b;
}

// Error handling in functions (returning errors)
fn div(a: i32, b: i32) !i32 {
    if (b == 0) {
        return error.DivisionByZero;
    }
    return a / b;
}

// Struct definition
const Point = struct {
    x: i32,
    y: i32,

    // Struct methods
    pub fn distance(self: Point, other: Point) f64 {
        const dx = @intToFloat(f64, other.x - self.x);
        const dy = @intToFloat(f64, other.y - self.y);
        return std.math.sqrt(dx * dx + dy * dy);
    }
};

// Optional values and option types
fn find_index(arr: []const i32, target: i32) ?usize {
    for (arr) |val, index| {
        if (val == target) {
            return index;
        }
    }
    return null;
}

// Using an optional value
pub fn optional_example() void {
    const arr = [_]i32{1, 2, 3, 4, 5};
    const result = find_index(arr, 3);
    
    switch (result) {
        null => std.debug.print("Value not found\n", .{}),
        else => std.debug.print("Found at index: {}\n", .{result.?}),
    }
}

// Enum definitions and switch over enums
const Color = enum {
    Red,
    Green,
    Blue,
};

fn print_color(color: Color) void {
    switch (color) {
        .Red => std.debug.print("Color is Red\n", .{}),
        .Green => std.debug.print("Color is Green\n", .{}),
        .Blue => std.debug.print("Color is Blue\n", .{}),
    }
}

// Using slices (similar to arrays)
fn sum_slice(arr: []const i32) i32 {
    var total: i32 = 0;
    for (arr) |val| {
        total += val;
    }
    return total;
}

// Pointers and memory management
fn modify_value(ptr: *i32) void {
    // Dereferencing pointer
    const value = ptr.*;
    std.debug.print("Current value: {}\n", .{value});
    ptr.* = 42; // Modify value at the pointer location
}

pub fn pointer_example() void {
    var num = 10;
    modify_value(&num);
    std.debug.print("Modified value: {}\n", .{num});
}

// Error handling with defer and error sets
fn file_example() !void {
    const file = try std.fs.cwd().openFile("example.txt", .{});
    defer file.close(); // Automatically close the file when function exits

    // Do something with the file...
    const size = try file.seekToEnd();
    std.debug.print("File size: {}\n", .{size});
}

// Generics example
fn identity(T: type, value: T) T {
    return value;
}

pub fn generics_example() void {
    const num = identity(i32, 42);
    const text = identity([]const u8, "Hello");

    std.debug.print("Generic value (i32): {}\n", .{num});
    std.debug.print("Generic value (string): {}\n", .{text});
}

