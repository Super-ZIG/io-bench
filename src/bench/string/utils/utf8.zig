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

    const std_unicode   = @import("std").unicode;
    const io_utf8       = @import("../../../libs/io/io.zig").string.utils.utf8;
    const vs            = @import("../../../libs/vs/vs.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    fn std_bench(_: vs.Alloc, comptime scale: usize) void {
        const sample = vs.getSlice(scale, .utf8);

        for (0..scale) |_| {
            var i: usize = 0;

            while (i < sample.len) {
                // sequence length
                const len = std_unicode.utf8ByteSequenceLength(sample[i]) catch {
                    i += 1;
                    continue;
                };

                if (i + len > sample.len) break;

                // decode
                const decoded = std_unicode.utf8Decode(sample[i..i+len]) catch unreachable;
                vs.keep(decoded);

                // codepoint length
                const codepoint_len = std_unicode.utf8CodepointSequenceLength(decoded) catch 1;
                vs.keep(codepoint_len);

                // encode
                var buf: [4]u8 = undefined;
                const encoded_len = std_unicode.utf8Encode(decoded, &buf) catch unreachable;
                vs.keep(buf);
                vs.keep(encoded_len);

                i += len;
            }
        }
    }

    fn io_bench(_: vs.Alloc, comptime scale: usize) void {
        const sample = vs.getSlice(scale, .utf8);

        for (0..scale) |_| {
            var i: usize = 0;

            while (i < sample.len) {
                // sequence length
                const len = io_utf8.getCodepointLengthOrNull(sample[i]) orelse {
                    i += 1;
                    continue;
                };

                if (i + len > sample.len) break;

                // decode
                const decoded = io_utf8.decode(sample[i..i+len]);
                vs.keep(decoded);

                // codepoint length
                const codepoint_len = io_utf8.getCodepointLength(decoded);
                vs.keep(codepoint_len);

                // encode
                var buf: [4]u8 = undefined;
                const encoded_len = io_utf8.encode(decoded, &buf);
                vs.keep(buf);
                vs.keep(encoded_len);

                i += len;
            }
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