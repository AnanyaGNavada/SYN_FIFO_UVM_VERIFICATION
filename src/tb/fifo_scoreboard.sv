class fifo_scoreboard extends uvm_scoreboard;
`uvm_component_utils(fifo_scoreboard)
bit [`ADDR_WIDTH:0] status_cnt;
bit [`ADDR_WIDTH -1:0] wr_pointer;
bit [`ADDR_WIDTH-1:0] rd_pointer;
bit exp_full;
bit exp_empty;
bit [`DATA_WIDTH-1:0]exp_data_out;
bit[`DATA_WIDTH-1:0] mem [`ADDR_WIDTH-1:0];
virtual fifo_interface vif;
uvm_analysis_imp #(fifo_seq_item,fifo_scoreboard) scb_imp;
fifo_seq_item scb_seq;
function new(string name ="fifo_scoreboard",uvm_component parent);
	super.new(name,parent);
	scb_imp=new("scb_inp",this);
endfunction
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(virtual fifo_interface) ::get(this, "", "vif", vif))
	`uvm_fatal(get_type_name(),"Scoreboard get failed")
endfunction
function void write(fifo_seq_item t);
	scb_seq=t;
	reference_model(scb_seq);
	`uvm_info(get_type_name(),$sformatf("REFERENCE MODEL : data_in = %d wr_en = %d rd_en = %d wr_cs = %d rd_cs = %d data_out = %d full = %d empty = %d",scb_seq.data_in,scb_seq.wr_en,  scb_seq.rd_en, scb_seq.wr_cs, scb_seq.rd_cs, exp_data_out, exp_full, exp_empty),UVM_NONE)
	`uvm_info(get_type_name(),$sformatf("ACTUAL DATA : data_out = %d empty = %d full = %d ",scb_seq.data_out,scb_seq.empty, scb_seq.full),UVM_NONE)
	compare_data(scb_seq);
endfunction
function void reference_model(fifo_seq_item s);
	if(vif.rst) begin
		wr_pointer=0;
		rd_pointer=0;
		status_cnt=0;
		exp_data_out=0;
		exp_full=0;
		exp_empty=0;
	end
	else begin
		if((s.wr_en && s.wr_cs) &&(s.rd_en &&s.rd_cs)&& exp_full==0 && exp_empty ==0) begin
			mem[wr_pointer]=s.data_in;
			exp_data_out=mem[rd_pointer];
			wr_pointer++;
			rd_pointer++;
		end
		else if((s.wr_en && s.wr_cs) && exp_full==0) begin
			mem[wr_pointer]=s.data_in;
			wr_pointer++;
			status_cnt++;
		end
		else if((s.rd_en &&s.rd_cs)&& exp_empty==0) begin
			exp_data_out=mem[rd_pointer];
			rd_pointer++;
			status_cnt--;
		end
	end
	if(vif.rst) begin
		wr_pointer=0;
		rd_pointer=0;
		status_cnt=0;
		exp_data_out=0;
		exp_full=0;
		exp_empty=0;
	end
	else begin
		if(status_cnt==`RAM_DEPTH) begin
			exp_full=1;
			exp_empty=0;
		end
		else if( status_cnt==0) begin
			exp_empty=1;
			exp_full=0;
		end
		else begin
			exp_empty=0;
			exp_full=0;
		end
	end
endfunction
function void compare_data(fifo_seq_item cd);
	if(exp_data_out==cd.data_out)
		`uvm_info("Data_out"," Data_out match",UVM_MEDIUM)
	else
		`uvm_info("Data_out"," Data_out mismatch",UVM_MEDIUM)
	if(exp_empty==cd.empty)
		`uvm_info("Empty"," Empty match",UVM_MEDIUM)
	else
		`uvm_info("Empty"," Empty mismatch",UVM_MEDIUM)
	if(exp_full==cd.full)
		`uvm_info("Full"," Full match",UVM_MEDIUM)
	else
		`uvm_info("Full"," Full mismatch",UVM_MEDIUM)
endfunction
endclass
