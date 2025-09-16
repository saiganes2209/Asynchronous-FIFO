// Status logic
    assign empty = (rptr_gray == wptr_gray_sync2);
    assign full  = (wptr_gray == {~rptr_gray_sync2[PTR_WIDTH-1:PTR_WIDTH-2], rptr_gray_sync2[PTR_WIDTH-3:0]});
