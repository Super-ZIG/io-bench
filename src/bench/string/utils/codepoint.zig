// Copyright (c) 2025 Maysara, All rights reserved.
//
// repo : https://github.com/Super-ZIG/io
// docs : https://super-zig.github.io/io/string/codepoint
//
// owner : https://github.com/maysara-elshewehy
// email : maysara.elshewehy@gmail.com
//
// Made with ❤️ by Maysara



// ╔══════════════════════════════════════ PACK ══════════════════════════════════════╗

    const std_unicode   = @import("std").unicode;
    const io_codepoint  = @import("../../../libs/io/io.zig").string.utils.codepoint;
    const vs            = @import("../../../libs/vs/vs.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    fn std_bench(_: vs.Alloc, comptime scale: usize) void {
        const sample = vs.getSlice(scale, .utf8);

        for (0..scale) |_| {
            var iter = std_unicode.Utf8Iterator { .bytes = sample, .i = 0 };
            while(iter.nextCodepoint()) |cp| vs.keep(cp);
        }
    }

    fn io_bench(_: vs.Alloc, comptime scale: usize) void {
        const sample = vs.getSlice(scale, .utf8);

        for (0..scale) |_| {
            var iter = io_codepoint.Utf8Iterator { .src = sample, .pos = 0 };
            while(iter.nextCodepoint()) |cp| vs.keep(cp.src);
        }
    }

    pub const config : vs.Config = .{
        .handlers  = .{
            .{ .name = "std", .bench_fn = std_bench },
            .{ .name = "io",  .bench_fn = io_bench },
        },
        .rounds     = 3,
        .scales     = &.{ 10, 100, 1000 },
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝