class fifo_driver extends uvm_driver #(fifo_seq_item);
`uvm_component_utils(fifo_driver)
virtual fifo_interface.drv vif;
fifo_seq_item dr_seq;
function new(string name = "fifo_driver", uvm_component parent);
	super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(virtual fifo_interface)::get(this, "" ,"vif", vif))
	`uvm_fatal(get_type_name(),"Driver get failed")
endfunction
task run_phase(uvm_phase phase);
	forever begin
		dr_seq=fifo_seq_item::type_id::create("dr_seq");
		seq_item_port.get_next_item(dr_seq);
		@(vif.drv_cb);
		vif.drv_cb.data_in<=dr_seq.data_in;
		vif.drv_cb.wr_en<=dr_seq.wr_en;
		vif.drv_cb.rd_en<=dr_seq.rd_en;
		vif.drv_cb.wr_cs<=dr_seq.wr_cs;
		vif.drv_cb.rd_cs<=dr_seq.rd_cs;
		seq_item_port.item_done();
		`uvm_info(get_type_name(),$sformatf("DRIVER : data_in =%d wr_en=%d wr_cs = %d rd_en = %d rd_cs = %d",dr_seq.data_in,dr_seq.wr_en,dr_seq.wr_cs,dr_seq.rd_en,dr_seq.rd_cs),UVM_NONE)
	end
endtask
endclass
