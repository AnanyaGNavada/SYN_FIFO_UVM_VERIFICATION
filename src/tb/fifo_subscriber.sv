class fifo_subscriber extends uvm_subscriber #(fifo_seq_item);
`uvm_component_utils(fifo_subscriber)
fifo_seq_item si;
covergroup fifo_cg;
	data_in_cp : coverpoint si.data_in {
		bins zero ={0};
		bins max= {{`DATA_WIDTH{1'b1}}};
		bins others = default; }
	wr_en_cp : coverpoint si.wr_en { 
		bins low= {0};
		bins high = {1}; }
	rd_en_cp : coverpoint si.rd_en {
		bins low= {0};
		bins high = {1}; }
	wr_cs_cp : coverpoint si.wr_cs {
		bins low= {0};
		bins high = {1}; }
	rd_cs_cp : coverpoint si.rd_cs {
		bins low= {0};
		bins high = {1}; }
	rd_en_wr_en : cross wr_en_cp , rd_en_cp;
	wr_cs_rd_cs : cross wr_cs_cp, rd_cs_cp;
endgroup
function new(string name = "fifo_subscriber", uvm_component parent);
	super.new(name,parent);
	fifo_cg=new();
endfunction
virtual function void write ( fifo_seq_item t);
	si=t;
	fifo_cg.sample();
endfunction
endclass
