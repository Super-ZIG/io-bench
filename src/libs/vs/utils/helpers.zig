// helpers.zig - Utility functions for io-bench
//
// repo   : https://github.com/Super-ZIG/io
// docs   : https://super-zig.github.io/io/
// author : https://github.com/maysara-elshewehy
//
// Developed with ❤️ by Maysara.



// ╔══════════════════════════════════════ PACK ══════════════════════════════════════╗

    const std     = @import("std");
    const Alloc   = std.mem.Allocator;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    pub var utf8_sample    : []const u8 = undefined;
    pub var ascii_sample   : []const u8 = undefined;

    /// Pre-allocate samples for each scale to avoid memory allocation
    /// overhead during the benchmark runs.
    pub inline fn getSlice(comptime scale: usize, comptime mode: enum { utf8, ascii }) []const u8 {
        return switch (mode) {
            .utf8  => utf8_sample[0..scale],
            .ascii => ascii_sample[0..scale],
        };
    }

    /// Generates a UTF-8 or ASCII sample string of a given size, with random characters.
    pub fn genSlice(allocator: Alloc, comptime scale: usize, comptime mode: enum { utf8, ascii }) ![]u8 {
        var seed: u64 = undefined;
        try std.posix.getrandom(std.mem.asBytes(&seed));

        var prng = std.Random.DefaultPrng.init(seed);
        const rand = prng.random();

        const SAMPLE =
            if (mode == .utf8)
                "\x00\x01\x02\x03\x04\x05\x06\x07\x0A\x0B\x0C\x0D\x0E\x0F\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1A\x1B\x1C\x1D\x1E\x1F"
            else
                " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";

        const multiplier = 10 * scale;
        var builder = try std.ArrayList(u8).initCapacity(allocator, multiplier);

        for (0..multiplier) |_| {
            const index = rand.uintLessThan(usize, SAMPLE.len);
            try builder.append(SAMPLE[index]);
        }

        return builder.toOwnedSlice();
    }

    /// Helper to create a benchmark function with a specific number of iterations.
    pub fn make_bench(bench_fn: fn (Alloc, comptime usize) void, comptime n: usize) fn (Alloc) void {
        return struct {
            pub fn call(a: Alloc) void { bench_fn(a, n); }
        }.call;
    }

    /// Find the maximum value in a slice of type T
    pub fn findMax(comptime T: type, slice: []const T) T {
        var max_val = slice[0];
        for (slice) |val| max_val = @max(max_val, val);
        return max_val;
    }

    /// Sum all elements of a slice
    pub fn sumAll(data: []const u64) u64 {
        var sum: u64 = 0;
        for (data) |v| sum += v;
        return sum;
    }

    /// Return average excluding outliers (10% top & bottom)
    pub fn filteredAvg(data: []const u64) u64 {
        const drop_percent : f64 = 0.1; // drop top & bottom 10% as outliers

        const len = data.len;
        if (len < 5) return sumAll(data) / data.len;

        const flen : f64 = @floatFromInt(len);
        const res : usize = @intFromFloat(flen * drop_percent);
        const drop : usize = @intCast(std.math.clamp(res, 1, len / 2 - 1));
        const slice = data[drop .. len - drop];
        return sumAll(slice) / slice.len;
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝