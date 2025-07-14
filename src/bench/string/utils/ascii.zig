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

    const std_ascii     = @import("std").ascii;
    const io_ascii      = @import("../../../libs/io/io.zig").string.utils.ascii;
    const vs            = @import("../../../libs/vs/vs.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    fn std_bench(_: vs.Alloc, comptime scale: usize) void {
        const sample = vs.getSlice(scale, .ascii)[0];

        for (0..scale) |_| {
            const upper         = std_ascii.toUpper(sample);
            vs.keep(upper);

            const lower         = std_ascii.toLower(sample);
            vs.keep(lower);

            const is_upper      = std_ascii.isUpper(sample);
            vs.keep(is_upper);

            const is_lower      = std_ascii.isLower(sample);
            vs.keep(is_lower);

            const is_alpha      = std_ascii.isAlphabetic(sample);
            vs.keep(is_alpha);

            const is_digit      = std_ascii.isDigit(sample);
            vs.keep(is_digit);

            const is_alnum      = std_ascii.isAlphanumeric(sample);
            vs.keep(is_alnum);

            const is_space      = std_ascii.isWhitespace(sample);
            vs.keep(is_space);

            const is_ctrl       = std_ascii.isControl(sample);
            vs.keep(is_ctrl);
        }
    }

    fn io_bench(_: vs.Alloc, comptime scale: usize) void {
        const sample = vs.getSlice(scale, .ascii)[0];

        for (0..scale) |_| {
            const upper         = io_ascii.toUpper(sample);
            vs.keep(upper);

            const lower         = io_ascii.toLower(sample);
            vs.keep(lower);

            const is_upper      = io_ascii.isUpper(sample);
            vs.keep(is_upper);

            const is_lower      = io_ascii.isLower(sample);
            vs.keep(is_lower);

            const is_alpha      = io_ascii.isAlphabetic(sample);
            vs.keep(is_alpha);

            const is_digit      = io_ascii.isDigit(sample);
            vs.keep(is_digit);

            const is_alnum      = io_ascii.isAlphanumeric(sample);
            vs.keep(is_alnum);

            const is_space      = io_ascii.isWhitespace(sample);
            vs.keep(is_space);

            const is_ctrl       = io_ascii.isControl(sample);
            vs.keep(is_ctrl);
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