// Copyright (c) 2025 Maysara, All rights reserved.
//
// repo: https://github.com/Super-ZIG/io
// docs: https://super-zig.github.io/io
//
// Made with ❤️ by Maysara
//
// maysara.elshewehy@gmail.com.
// https://github.com/maysara-elshewehy



// ╔══════════════════════════════════════ PACK ══════════════════════════════════════╗

    const std = @import("std");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    pub fn main() !void {
        const args = try std.process.argsAlloc(std.heap.page_allocator);
        defer std.process.argsFree(std.heap.page_allocator, args);

        // get the target benchmark
        const target = if (args.len <= 1) {
            std.debug.print("Usage: {s} <bench_type>\n", .{args[0]});
            return error.NoBenchTypeProvided;
        } else args[1];

        // run the benchmark
        if (std.mem.eql(u8, target, "ascii")) try @import("./bench/string/utils/ascii.zig").run()
        else if (std.mem.eql(u8, target, "utf8")) try @import("./bench/string/utils/utf8.zig").run()
        // ..

        else return error.InvalidBenchType;
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝