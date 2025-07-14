// vs.zig — Multi-Library Benchmark Framework - Compare your library against multiple implementations
//
// repo   : https://github.com/Super-ZIG/io
// docs   : https://super-zig.github.io/io/
// author : https://github.com/maysara-elshewehy
//
// Developed with ❤️ by Maysara.



// ╔══════════════════════════════════════ PACK ══════════════════════════════════════╗

    const std           = @import("std");
    const io            = @import("../io/io.zig");
    const zBench        = @import("./libs/zBench/zbench.zig");
    const report        = @import("./utils/report.zig");

    pub const types     = @import("./utils/types.zig");
    pub const helpers   = @import("./utils/helpers.zig");

    pub const Alloc     = std.mem.Allocator;
    pub const keep      = std.mem.doNotOptimizeAway;
    pub const getSlice  = helpers.getSlice;
    pub const Config    = types.Config;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Run benchmarks N times, aggregate results, and print markdown
    /// table and winner summary.
    pub fn run(comptime config: Config) !void {
        const stdout = std.io.getStdOut().writer();
        const warm_up_rounds : usize = 1; // skip initial warm-up round

        // 1. Print the table header
        try report.print_table_header_markdown(stdout);

        // 2. Allocate memory for the benchmark
        const allocator = std.heap.page_allocator;
        helpers.utf8_sample = try helpers.genSlice(allocator, 1000, .utf8);
        defer allocator.free(helpers.utf8_sample);
        helpers.ascii_sample = try helpers.genSlice(allocator, 1000, .ascii);
        defer allocator.free(helpers.ascii_sample);

        // 2.1 Check
        if (helpers.utf8_sample.len == 0 or helpers.findMax(usize, config.scales) > helpers.utf8_sample.len)
        std.debug.panic("utf8_sample not initialized or scale exceeds length", .{});

        // 3. Prepare results array
        const MaxLibs = 8;
        const MaxScales = 8;
        var results: [MaxScales][MaxLibs]types.TableResult = undefined;
        var scale_count: usize = 0;

        // 4. Run each benchmark at each scale
        inline for (config.scales) |scale| {
            // 4.1 Prepare results array for scale
            var scale_results: [MaxLibs]types.TableResult = undefined;

            // 4.2 Run each benchmark at each scale
            inline for (.{0, 1}) |i| {
                const bench_name = config.handlers[i].name;
                const bench_fn = if (i == 0) helpers.make_bench(config.handlers[0].bench_fn, scale) else helpers.make_bench(config.handlers[1].bench_fn, scale);

                // 4.3 Run N times, and record total and average time
                var times: [100]u64 = undefined;
                var round_index: usize = 0;
                var total_runs: usize = 0;

                var actual_repeats: usize = 0;
                while (actual_repeats < config.rounds + warm_up_rounds) : (actual_repeats += 1) {
                    try stdout.print("\rRunning [{s}] at scale: {d}, Round: {d}", .{ bench_name, scale, actual_repeats });

                    // 4.3.1 Run benchmarks
                    var bench = zBench.Benchmark.init(std.heap.page_allocator, .{ .iterations = 0 });
                    defer bench.deinit();
                    const full_bench_name = comptime std.fmt.comptimePrint("{s}_x{d}", .{ bench_name, scale });
                    try bench.add(full_bench_name, bench_fn, .{});

                    var iter = try bench.iterator();
                    while (try iter.next()) |step| switch (step) {
                        .result => |res| {
                            var sum: u64 = 0;
                            for (res.readings.timings_ns) |t| sum += t;
                            const avg = sum / res.readings.iterations;

                            if (actual_repeats >= warm_up_rounds) {
                                times[round_index] = avg;
                                round_index += 1;
                                total_runs += res.readings.iterations;
                            }
                        },
                        else => {},
                    };
                }

                // 4.3.2 Calculate average after dropping top & bottom 10%
                std.mem.sort(u64, times[0..round_index], {}, comptime std.sort.asc(u64));
                const filtered_avg = helpers.filteredAvg(times[0..round_index]);

                // 4.3.3 Create TableResult with results
                var name_buf: [32]u8 = undefined;
                const combined_name = std.fmt.bufPrint(&name_buf, "{s}_x{d}", .{ bench_name, scale }) catch "";
                name_buf[combined_name.len] = 0;

                scale_results[i] = types.TableResult{
                    .bench_name = name_buf,
                    .scale = scale,
                    .runs = total_runs / @max(round_index, 1),
                    .total_time = filtered_avg * (total_runs / @max(round_index, 1)),
                    .avg_time = filtered_avg,
                };

                try stdout.writeAll("\r                                              \r");
            }

            // 4.4 Print table row with results
            const baseline_time = scale_results[0].avg_time;

            for (scale_results[0..2]) |r| {
                const speed = if (r.avg_time > 0)
                    @as(f64, @floatFromInt(baseline_time)) / @as(f64, @floatFromInt(r.avg_time))
                else
                    0.0;

                try report.print_table_row_markdown(
                    stdout,
                    r.bench_name[0..std.mem.indexOfScalar(u8, &r.bench_name, 0) orelse 32],
                    r.runs,
                    r.total_time,
                    r.avg_time,
                    speed,
                );
            }

            results[scale_count] = scale_results;
            scale_count += 1;
        }
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝