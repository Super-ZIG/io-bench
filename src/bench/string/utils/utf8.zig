// Copyright (c) 2025 Maysara, All rights reserved.
//
// repo : https://github.com/Super-ZIG/io
// docs : https://super-zig.github.io/io/string/utf8
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

    const short_testing_value   = "Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦";
    const medium_testing_value  = "Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦";
    const long_testing_value    = "Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦Aأ你🌟☹️👨‍🏭👨‍👩‍👧‍👦";

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // @zig/unicode
    fn std_bench(_: std.mem.Allocator, comptime num: usize) void {
        for (0..num) |_| {
            // encode
            {
                var buf: [4]u8 = undefined;

                // short
                for (short_testing_value) |c| {
                    var res = std.unicode.utf8Encode(c, &buf) catch unreachable;
                    res += 1;
                }

                // medium
                for (medium_testing_value) |c| {
                    var res = std.unicode.utf8Encode(c, &buf) catch unreachable;
                    res += 1;
                }

                // long
                for (long_testing_value) |c| {
                    var res = std.unicode.utf8Encode(c, &buf) catch unreachable;
                    res += 1;
                }
            }

            // decode
            {
                // short
                {
                    var i : usize = 0;
                    while (i < short_testing_value.len) {
                        const len = std.unicode.utf8ByteSequenceLength(short_testing_value[i]) catch unreachable;
                        var res = std.unicode.utf8Decode(short_testing_value[i..i+len]) catch unreachable;
                        res += len;
                        i += len;
                    }
                }

                // medium
                {
                    var i : usize = 0;
                    while (i < medium_testing_value.len) {
                        const len = std.unicode.utf8ByteSequenceLength(medium_testing_value[i]) catch unreachable;
                        var res = std.unicode.utf8Decode(medium_testing_value[i..i+len]) catch unreachable;
                        res += len;
                        i += len;
                    }
                }

                // long
                {
                    var i : usize = 0;
                    while (i < long_testing_value.len) {
                        const len = std.unicode.utf8ByteSequenceLength(long_testing_value[i]) catch unreachable;
                        var res = std.unicode.utf8Decode(long_testing_value[i..i+len]) catch unreachable;
                        res += len;
                        i += len;
                    }
                }
            }
        }
    }

    // @super-zig/utf8
    fn io_bench(_: std.mem.Allocator, comptime num: usize) void {
        for (0..num) |_| {
            // encode
            {
                var buf: [4]u8 = undefined;

                // short
                for (short_testing_value) |c| {
                    var res = io.string.utils.utf8.encode(c, &buf);
                    res += 1;
                }

                // medium
                for (medium_testing_value) |c| {
                    var res = io.string.utils.utf8.encode(c, &buf);
                    res += 1;
                }

                // long
                for (long_testing_value) |c| {
                    var res = io.string.utils.utf8.encode(c, &buf);
                    res += 1;
                }
            }

            // decode
            {
                // short
                {
                    var i : usize = 0;
                    while (i < short_testing_value.len) {
                        const len = io.string.utils.utf8.getFirstByteLength(short_testing_value[i]);
                        var res = io.string.utils.utf8.decode(short_testing_value[i..i+len]);
                        res += len;
                        i += len;
                    }
                }

                // medium
                {
                    var i : usize = 0;
                    while (i < medium_testing_value.len) {
                        const len = io.string.utils.utf8.getFirstByteLength(medium_testing_value[i]);
                        var res = io.string.utils.utf8.decode(medium_testing_value[i..i+len]);
                        res += len;
                        i += len;
                    }
                }

                // long
                {
                    var i : usize = 0;
                    while (i < long_testing_value.len) {
                        const len = io.string.utils.utf8.getFirstByteLength(long_testing_value[i]);
                        var res = io.string.utils.utf8.decode(long_testing_value[i..i+len]);
                        res += len;
                        i += len;
                    }
                }
            }
        }
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ Bench ═════════════════════════════════════╗

    fn std_x10   (allocator: std.mem.Allocator) void { std_bench(allocator, 10);       }
    fn std_x1k   (allocator: std.mem.Allocator) void { std_bench(allocator, 1000);     }
    fn std_x100k (allocator: std.mem.Allocator) void { std_bench(allocator, 100000);   }

    fn io_x10    (allocator: std.mem.Allocator) void { io_bench(allocator, 10);        }
    fn io_x1k    (allocator: std.mem.Allocator) void { io_bench(allocator, 1000);      }
    fn io_x100k  (allocator: std.mem.Allocator) void { io_bench(allocator, 100000);    }

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
    // - zig build run -- utf8                    # for debug   build
    // - zig build run --release=fast -- utf8     # for release build

// ╚══════════════════════════════════════════════════════════════════════════════════╝