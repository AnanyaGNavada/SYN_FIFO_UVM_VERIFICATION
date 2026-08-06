interface fifo_interface(input bit clk,rst);
logic wr_cs, rd_cs, wr_en, rd_en, full, empty;
logic [`DATA_WIDTH-1:0] data_in, data_out;

clocking drv_cb @(posedge clk);
default input #1 output #0;
output wr_cs, rd_cs, wr_en, rd_en, data_in;
endclocking

clocking mon_cb @(posedge clk);
default input #1 output #0;
input wr_cs, rd_cs, wr_en, rd_en, data_in;
input data_out, full, empty;
endclocking

modport drv (clocking drv_cb);
modport mon (clocking mon_cb);

endinterface
