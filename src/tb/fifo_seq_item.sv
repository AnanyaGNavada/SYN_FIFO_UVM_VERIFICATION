class fifo_seq_item extends uvm_sequence_item;
rand bit wr_cs, rd_cs, wr_en, rd_en;
rand bit [`DATA_WIDTH-1:0] data_in;
bit [`DATA_WIDTH-1:0] data_out;
bit full, empty;
constraint f1 {wr_en -> wr_cs;}
constraint f2 { rd_en -> rd_cs ;}
`uvm_object_utils_begin(fifo_seq_item)
`uvm_field_int( wr_cs, UVM_ALL_ON)
`uvm_field_int( rd_cs, UVM_ALL_ON)
`uvm_field_int( wr_en, UVM_ALL_ON)
`uvm_field_int( rd_en, UVM_ALL_ON)
`uvm_field_int( data_in, UVM_ALL_ON)
`uvm_field_int( data_out, UVM_ALL_ON)
`uvm_field_int( full, UVM_ALL_ON)
`uvm_field_int( empty, UVM_ALL_ON)
`uvm_object_utils_end
function new(string name = "fifo_seq_item");
	super.new(name);
endfunction
endclass
