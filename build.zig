// Copyright (c) 2025 Maysara, All rights reserved.
//
// repo : https://github.com/Super-ZIG/io
// docs : https://super-zig.github.io/io
//
// owner : https://github.com/maysara-elshewehy
// email : maysara.elshewehy@gmail.com
//
// Made with ❤️ by Maysara



// ╔══════════════════════════════════════ PACK ══════════════════════════════════════╗

    const Build = @import("std").Build;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ BUILD ═════════════════════════════════════╗

    pub fn build(b: *Build) void {
        const exe_mod           = b.createModule(.{
            .root_source_file   = b.path("src/main.zig"),
            .target             = b.standardTargetOptions(.{}),
            .optimize           = b.standardOptimizeOption(.{}),
        });

        const exe               = b.addExecutable(.{
            .name               = "io-bench",
            .root_module        = exe_mod,
        });

        b.installArtifact(exe);

        const run_exe           = b.addRunArtifact(exe);
        run_exe.step.dependOn(b.getInstallStep());
        if (b.args) |args| run_exe.addArgs(args);

        const run_exe_step      = b.step("run", "Run the benchmarks");
        run_exe_step.dependOn(&run_exe.step);
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝