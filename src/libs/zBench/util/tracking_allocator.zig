const std = @import("std");
const Allocator = std.mem.Allocator;

const TrackingAllocator = @This();

parent_allocator: Allocator,
current_allocated: usize = 0,
max_allocated: usize = 0,
allocation_count: usize = 0,

pub fn init(parent_allocator: Allocator) TrackingAllocator {
    return .{
        .parent_allocator = parent_allocator,
    };
}

pub fn allocator(self: *TrackingAllocator) Allocator {
    return .{
        .ptr = self,
        .vtable = &.{
            .alloc = alloc,
            .resize = resize,
            .remap = remap,
            .free = free,
        },
    };
}

pub fn maxAllocated(self: TrackingAllocator) usize {
    return self.max_allocated;
}

pub fn allocationCount(self: TrackingAllocator) usize {
    return self.allocation_count;
}

fn alloc(
    ctx: *anyopaque,
    len: usize,
    alignment: std.mem.Alignment,
    ra: usize,
) ?[*]u8 {
    const self: *TrackingAllocator = @ptrCast(@alignCast(ctx));
    const result = self.parent_allocator.rawAlloc(len, alignment, ra);
    if (result) |_| {
        self.allocation_count += 1;
        self.current_allocated += len;
        if (self.max_allocated < self.current_allocated)
            self.max_allocated = self.current_allocated;
    }
    return result;
}

fn resize(
    ctx: *anyopaque,
    buf: []u8,
    alignment: std.mem.Alignment,
    new_len: usize,
    ra: usize,
) bool {
    const self: *TrackingAllocator = @ptrCast(@alignCast(ctx));
    const result = self.parent_allocator.rawResize(buf, alignment, new_len, ra);
    if (result) {
        self.allocation_count += 1;
        if (buf.len < new_len) {
            self.current_allocated += new_len - buf.len;
            if (self.max_allocated < self.current_allocated)
                self.max_allocated = self.current_allocated;
        } else self.current_allocated -= buf.len - new_len;
    }
    return result;
}

fn remap(
    ctx: *anyopaque,
    buf: []u8,
    alignment: std.mem.Alignment,
    new_len: usize,
    ra: usize,
) ?[*]u8 {
    const self: *TrackingAllocator = @ptrCast(@alignCast(ctx));

    return self.parent_allocator.rawRemap(buf, alignment, new_len, ra);
}

fn free(
    ctx: *anyopaque,
    buf: []u8,
    alignment: std.mem.Alignment,
    ra: usize,
) void {
    const self: *TrackingAllocator = @ptrCast(@alignCast(ctx));
    self.parent_allocator.rawFree(buf, alignment, ra);
    self.current_allocated -= buf.len;
}

/// This allocator is used in front of another allocator and tracks the maximum
/// memory usage on every call to the allocator.
pub fn trackingAllocator(parent_allocator: Allocator) TrackingAllocator {
    return TrackingAllocator.init(parent_allocator);
}
