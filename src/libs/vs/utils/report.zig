// report.zig - All reporting/printing/formatting for io-bench
//
// repo   : https://github.com/Super-ZIG/io
// docs   : https://super-zig.github.io/io/
// author : https://github.com/maysara-elshewehy
//
// Developed with ❤️ by Maysara.



// ╔══════════════════════════════════════ PACK ══════════════════════════════════════╗

    const std     = @import("std");
    const types   = @import("./types.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Print the markdown table header for the benchmark results.
    pub fn print_table_header_markdown(stdout: anytype) !void {
        try stdout.writeAll("| Benchmark      | Runs       | Total Time   | Avg Time     | Speed    |\n");
        try stdout.writeAll("|----------------|------------|--------------|--------------|----------|\n");
    }

    /// Print a single row of benchmark results in markdown format.
    pub fn print_table_row_markdown(
        stdout      : anytype,
        name        : []const u8,
        runs        : usize,
        total_time  : u64,
        avg_time    : u64,
        speed       : f64,
    ) !void {
        try stdout.print(
            "| {s:<14} | {:<10} | {:<12} | {:<12} | x{d:<7.2} |\n",
            .{
                name,
                runs,
                std.fmt.fmtDuration(total_time),
                std.fmt.fmtDuration(avg_time),
                speed
            }
        );
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝