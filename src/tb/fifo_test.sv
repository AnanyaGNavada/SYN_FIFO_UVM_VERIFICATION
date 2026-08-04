class fifo_test extends uvm_test;
`uvm_component_utils(fifo_test)
fifo_env env;
fifo_seq s1;
function new(string name="fifo_test",uvm_component parent);
	super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	env=fifo_env::type_id::create("env",this);
endfunction
function void end_of_elaboration_phase(uvm_phase phase);
	super.end_of_elaboration_phase(phase);
	uvm_top.print_topology();
endfunction
task run_phase (uvm_phase phase);
	phase.raise_objection(this);
	s1=fifo_seq::type_id::create("s1");
	s1.start(env.ag.fs);
	#60;
	phase.drop_objection(this);
	`uvm_info(get_type_name(),"Testcases completed",UVM_LOW)
endtask
endclass
