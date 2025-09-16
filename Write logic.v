 // Write domain logic
    always @(posedge wclk or negedge wrst_n) begin
        if (!wrst_n) begin
            wptr_bin <= 0;
            wptr_gray <= 0;
        end else if (write_en && !full) begin
            mem[wptr_bin] <= wdata;
            wptr_bin <= wptr_bin + 1;
            wptr_gray <= (wptr_bin >> 1) ^ wptr_bin; // binary to gray
        end
    end
