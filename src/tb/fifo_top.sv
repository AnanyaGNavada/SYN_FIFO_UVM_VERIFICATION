`include "defines.svh"
`include "fifo_pkgs.sv"
`include "fifo_interface.sv"
`include "syn_fifo.v"
module fifo_top;
import uvm_pkg::*;
import fifo_pkgs::*;
bit clk,rst;
always #5 clk=~clk;
initial begin
	clk=0;
	rst=0;
	#5;
	rst=1;
	#10;
	rst=0;
end
fifo_interface intf (clk,rst);
syn_fifo dut(.clk(clk), .rst(rst), .wr_cs(intf.wr_cs), .rd_cs(intf.rd_cs), .data_in(intf.data_in), .rd_en(intf.rd_en), .wr_en(intf.rd_en), .data_out(intf.data_out), .empty(intf.empty), .full(intf.full));
initial begin
	uvm_config_db #(virtual fifo_interface)::set(null,"*","vif",intf);
	 $dumpfile("dump.vcd");
	 $dumpvars;
end
initial begin
	run_test("fifo_test");
end
endmodule
