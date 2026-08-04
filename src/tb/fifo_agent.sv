class fifo_agent extends uvm_agent;
`uvm_component_utils(fifo_agent)
fifo_driver fd;
fifo_monitor fm;
fifo_seqr fs;
function new(string name = "fifo_agent", uvm_component parent);
	super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	fm = fifo_monitor::type_id::create("fm",this);
	uvm_config_db#(uvm_active_passive_enum)::get(this, "", "is_active", is_active);
	if(get_is_active()==UVM_ACTIVE)
 	begin
 		fd=fifo_driver::type_id::create("fd",this);
		fs = fifo_seqr::type_id::create("fs",this);
 	end
endfunction
function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	if(get_is_active==UVM_ACTIVE) begin
		fd.seq_item_port.connect(fs.seq_item_export);
	end
endfunction
endclass
