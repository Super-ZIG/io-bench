// types.zig - Shared types and constants for io-bench
//
// repo   : https://github.com/Super-ZIG/io
// docs   : https://super-zig.github.io/io/
// author : https://github.com/maysara-elshewehy
//
// Developed with ❤️ by Maysara.



// ╔══════════════════════════════════════ PACK ══════════════════════════════════════╗

    const std           = @import("std");
    const Alloc         = std.mem.Allocator;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    pub const TableResult = struct {
        bench_name       : [32]u8,
        scale           : usize,
        runs            : usize,
        total_time   : u64,
        avg_time     : u64,
    };

    pub const Config = struct {
        handlers    : [2] struct {
            name: []const u8,
            bench_fn: fn (Alloc, comptime usize) void,
        },
        scales      : []const usize = &.{ 10, 100, 1000 },
        rounds      : usize = 3,
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝