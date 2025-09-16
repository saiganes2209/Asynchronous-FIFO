`timescale 1ns / 1ps

// 
//////////////////////////////////////////////////////////////////////////////////

module async_fifo #(parameter WIDTH=8, DEPTH=16, PTR_WIDTH=4)(
    input wclk, rclk,
    input wrst_n, rrst_n,
    input write_en, read_en,
    input [WIDTH-1:0] wdata,
    output reg [WIDTH-1:0] rdata,
    output full, empty
);

    reg [WIDTH-1:0] mem [0:DEPTH-1];

    reg [PTR_WIDTH-1:0] wptr_bin = 0, wptr_gray = 0;
    reg [PTR_WIDTH-1:0] rptr_bin = 0, rptr_gray = 0;

    reg [PTR_WIDTH-1:0] wptr_gray_sync1 = 0, wptr_gray_sync2 = 0;
    reg [PTR_WIDTH-1:0] rptr_gray_sync1 = 0, rptr_gray_sync2 = 0;
