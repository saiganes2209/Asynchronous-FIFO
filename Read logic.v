
    // Read domain logic
    always @(posedge rclk or negedge rrst_n) begin
        if (!rrst_n) begin
            rptr_bin <= 0;
            rptr_gray <= 0;
            rdata <= 0;
        end else if (read_en && !empty) begin
            rdata <= mem[rptr_bin];
            rptr_bin <= rptr_bin + 1;
            rptr_gray <= (rptr_bin >> 1) ^ rptr_bin;
        end
    end
