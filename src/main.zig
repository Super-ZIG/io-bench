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
    const vs = @import("./libs/vs/vs.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    const BenchType = enum {
        ascii, utf8, codepoint
    };

    pub fn main() !void {

        const args = try std.process.argsAlloc(std.heap.page_allocator);
        defer std.process.argsFree(std.heap.page_allocator, args);

        if (args.len <= 1) {
            std.debug.print("Usage: {s} <bench_type>\n", .{args[0]});
            return error.NoBenchTypeProvided;
        }

        const target = args[1];

        std.debug.print("\n", .{ });

        const targetAsEnum = std.meta.stringToEnum(BenchType, target) orelse {
            std.debug.print("Invalid benchmark type: {s}\n", .{target});
            return error.InvalidBenchType;
        };

        switch (targetAsEnum) {
            .ascii      => try vs.run(@import("./bench/string/utils/ascii.zig").config),
            .utf8       => try vs.run(@import("./bench/string/utils/utf8.zig").config),
            .codepoint  => try vs.run(@import("./bench/string/utils/codepoint.zig").config),
        }

        std.debug.print("\n", .{ });
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝
