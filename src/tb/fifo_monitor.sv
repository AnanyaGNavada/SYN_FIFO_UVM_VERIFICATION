class fifo_monitor extends uvm_monitor;
`uvm_component_utils(fifo_monitor)
uvm_analysis_port #(fifo_seq_item) mon_port;
virtual fifo_interface.mon vif;
fifo_seq_item mon_seq;
function new(string name = "fifo_monitor", uvm_component parent);
	super.new(name,parent);
	mon_port=new("mon_port",this);
endfunction
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(virtual fifo_interface) ::get(this, "" ,"vif",vif))
	`uvm_fatal(get_type_name(),"Monitor get failed")
endfunction
task run_phase(uvm_phase phase);
	forever begin
		mon_seq=fifo_seq_item::type_id::create("mon_seq");
		@(vif.mon_cb);
				mon_seq.data_in=vif.mon_cb.data_in;

		mon_seq.wr_en=vif.mon_cb.wr_en;
		mon_seq.wr_cs=vif.mon_cb.wr_cs;
		mon_seq.rd_en=vif.mon_cb.rd_en;
		mon_seq.rd_cs=vif.mon_cb.rd_cs;
				//@(vif.mon_cb);
		mon_seq.data_out=vif.mon_cb.data_out;
		mon_seq.empty=vif.mon_cb.empty;
		mon_seq.full=vif.mon_cb.full;
		mon_port.write(mon_seq);
		`uvm_info("MONITOR",$sformatf("INPUTS : data_in = %d wr_en =%d wr_cs = %d rd_en = %d rd_cs = %d",mon_seq.data_in, mon_seq.wr_en, mon_seq.wr_cs, mon_seq.rd_en, mon_seq.rd_cs),UVM_NONE)
		`uvm_info("MONITOR",$sformatf("OUTPUTS : data_out = %d full = %d empty = %d",mon_seq.data_out, mon_seq.full, mon_seq.empty),UVM_NONE)
	end
endtask
endclass
