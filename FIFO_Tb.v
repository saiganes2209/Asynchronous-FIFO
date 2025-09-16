`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 

//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps
module async_fifo_tb();

    reg wclk = 0, rclk = 0;
    always #5 wclk = ~wclk;  // 100 MHz
    always #7 rclk = ~rclk;  // ~71 MHz (asynchronous)

    reg wrst_n = 0, rrst_n = 0;
    reg write_en = 0, read_en = 0;
    reg [8:0] wdata = 0;
    wire [8:0] rdata;
    wire full, empty;

    async_fifo dut (
        .wclk(wclk), .rclk(rclk),
        .wrst_n(wrst_n), .rrst_n(rrst_n),
        .write_en(write_en), .read_en(read_en),
        .wdata(wdata), .rdata(rdata),
        .full(full), .empty(empty)
    );

    // 🟡 VCD Dump
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, async_fifo_tb);
    end

    initial begin
        // Reset
        wrst_n = 0; rrst_n = 0;
        #20;
        wrst_n = 1; rrst_n = 1;
        #20;

        // Write 10 values
        repeat (10) begin
            @(posedge wclk);
            if (!full) begin
                write_en = 1;
                wdata = $random;
            end
        end
        write_en = 0;

        // Wait before reading
        #100;

       // Read 10 values
        repeat (10) begin
            @(posedge rclk);
            if (!empty)
                read_en = 1;
        end
        read_en = 0;

        #100;
        $finish;
    end
endmodule
