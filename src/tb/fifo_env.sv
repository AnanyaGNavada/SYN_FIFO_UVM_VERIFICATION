class fifo_env extends uvm_env;
`uvm_component_utils (fifo_env)
fifo_agent ag;
fifo_scoreboard scb;
fifo_subscriber sub;
function new(string name="fifo_env",uvm_component parent);
	super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	uvm_config_db #(uvm_active_passive_enum)::set(this,"ag","is_active",UVM_ACTIVE);
	ag=fifo_agent::type_id::create("ag",this);
	scb=fifo_scoreboard::type_id::create("scb",this);
	sub=fifo_subscriber::type_id::create("sub",this);
endfunction
function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	ag.fm.mon_port.connect(scb.scb_imp);
	ag.fm.mon_port.connect(sub.analysis_export);
endfunction
endclass
