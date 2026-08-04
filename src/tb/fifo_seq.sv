class fifo_seq extends uvm_sequence #(fifo_seq_item);
`uvm_object_utils(fifo_seq)
function new(string name = "fifo_seq");
	super.new(name);
endfunction

task write_operation;
	req=fifo_seq_item::type_id::create("req");
        start_item(req);
	req.randomize() with {req.wr_en==1;req.wr_cs==1;};
	finish_item(req);
endtask

task read_operation;
	req=fifo_seq_item::type_id::create("req");
        start_item(req);
	req.randomize() with {req.rd_en==1;req.rd_cs==1;};
	finish_item(req);
endtask

task body();
repeat(3) begin
    write_operation;
   end
    
    read_operation;
    read_operation;
    read_operation;
endtask
endclass
