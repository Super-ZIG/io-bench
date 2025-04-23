// Copyright (c) 2025 Maysara, All rights reserved.
//
// repo : https://github.com/Super-ZIG/io
// docs : https://super-zig.github.io/io/string/ascii
//
// owner : https://github.com/maysara-elshewehy
// email : maysara.elshewehy@gmail.com
//
// Made with ❤️ by Maysara



// ╔══════════════════════════════════════ PACK ══════════════════════════════════════╗

    const std           = @import("std");
    const io            = @import("../../../libs/io/io.zig");
    const zBench        = @import("../../../libs/zBench/zbench.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const uppercase     = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const lowercase     = "abcdefghijklmnopqrstuvwxyz";
    const digits        = "0123456789";
    const letters       = uppercase ++ lowercase;

    const punctuation   = "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~";      // ! std does not have `isPunctuation` function
    const printable     = letters ++ digits ++ punctuation ++ " ";   // ! std does not have `isPrintable` function

    const whitespace    = " \t\n\r";
    const control       = "\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f";

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // @zig/ascii
    fn std_bench(_: std.mem.Allocator, comptime num: usize) void {
        for (0..num) |_| {

            // ┌────────────────────────── Conversion ────────────────────────┐

                // toUpper
                for (lowercase) |c| {
                    if (std.ascii.toUpper(c) != c) continue;
                }

                // toLower
                for (uppercase) |c| {
                    if (std.ascii.toLower(c) != c) continue;
                }

            // └──────────────────────────────────────────────────────────────┘


            // ┌────────────────────────── Properties ────────────────────────┐

                // isUpper
                for (uppercase) |c| {
                    if (!std.ascii.isUpper(c)) continue;
                }

                // isLower
                for (lowercase) |c| {
                    if (!std.ascii.isLower(c)) continue;
                }

                // isAlphabetic
                for (letters) |c| {
                    if (!std.ascii.isAlphabetic(c)) continue;
                }

                // isDigit
                for (digits) |c| {
                    if (!std.ascii.isDigit(c)) continue;
                }

                // isAlphanumeric
                for (letters ++ digits) |c| {
                    if (!std.ascii.isAlphanumeric(c)) continue;
                }

                // isWhitespace
                for (whitespace) |c| {
                    if (!std.ascii.isWhitespace(c)) continue;
                }

                // isControl
                for (control) |c| {
                    if (!std.ascii.isControl(c)) continue;
                }

            // └──────────────────────────────────────────────────────────────┘
        }
    }

    // @super-zig/ascii
    fn io_bench(_: std.mem.Allocator, comptime num: usize) void {
        for (0..num) |_| {

            // ┌────────────────────────── Conversion ────────────────────────┐

                // toUpper
                for (lowercase) |c| {
                    if (io.string.utils.ascii.toUpper(c) != c) continue;
                }

                // toLower
                for (uppercase) |c| {
                    if (io.string.utils.ascii.toLower(c) != c) continue;
                }

            // └──────────────────────────────────────────────────────────────┘


            // ┌────────────────────────── Properties ────────────────────────┐

                // isUpper
                for (uppercase) |c| {
                    if (!io.string.utils.ascii.isUpper(c)) continue;
                }

                // isLower
                for (lowercase) |c| {
                    if (!io.string.utils.ascii.isLower(c)) continue;
                }

                // isAlphabetic
                for (letters) |c| {
                    if (!io.string.utils.ascii.isAlphabetic(c)) continue;
                }

                // isDigit
                for (digits) |c| {
                    if (!io.string.utils.ascii.isDigit(c)) continue;
                }

                // isAlphanumeric
                for (letters ++ digits) |c| {
                    if (!io.string.utils.ascii.isAlphanumeric(c)) continue;
                }

                // isWhitespace
                for (whitespace) |c| {
                    if (!io.string.utils.ascii.isWhitespace(c)) continue;
                }

                // isControl
                for (control) |c| {
                    if (!io.string.utils.ascii.isControl(c)) continue;
                }

            // └──────────────────────────────────────────────────────────────┘
        }
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ Bench ═════════════════════════════════════╗

    fn std_x10   (allocator: std.mem.Allocator) void { std_bench(allocator, 10);     }
    fn std_x1k   (allocator: std.mem.Allocator) void { std_bench(allocator, 1000);   }
    fn std_x100k (allocator: std.mem.Allocator) void { std_bench(allocator, 100000); }

    fn io_x10    (allocator: std.mem.Allocator) void { io_bench(allocator, 10);      }
    fn io_x1k    (allocator: std.mem.Allocator) void { io_bench(allocator, 1000);    }
    fn io_x100k  (allocator: std.mem.Allocator) void { io_bench(allocator, 100000);  }

    pub fn run() !void {

        // init the benchmark
        var bench = zBench.Benchmark.init(std.heap.page_allocator, .{});
        defer bench.deinit();

        // to avoid noise
        try bench.add("__",         std_x1k,    .{});
        try bench.add("__",         io_x1k,     .{});

        // x10
        try bench.add("std_x10",    std_x10,    .{});
        try bench.add("io_x10",     io_x10,     .{});

        // x1k
        try bench.add("std_x1k",    std_x1k,    .{});
        try bench.add("io_x1k",     io_x1k,     .{});

        // x100k
        try bench.add("std_x100k",  std_x100k,  .{});
        try bench.add("io_x100k",   io_x100k,   .{});

        // to avoid noise
        try bench.add("__",         std_x1k,    .{});
        try bench.add("__",         io_x1k,     .{});

        // run the benchmark
        try std.io.getStdOut().writer().writeAll("\n");
        try bench.run(std.io.getStdOut().writer());
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ Usage ═════════════════════════════════════╗

    // Run the benchmark using one of the following commands:
    //
    // - zig build run -- ascii                   # for debug   build
    // - zig build run --release=fast -- ascii    # for release build

// ╚══════════════════════════════════════════════════════════════════════════════════╝