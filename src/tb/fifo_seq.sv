class fifo_seq extends uvm_sequence #(fifo_seq_item);
`uvm_object_utils(fifo_seq)
function new(string name = "fifo_seq");
	super.new(name);
endfunction

task write_operation;
	req=fifo_seq_item::type_id::create("req");
        start_item(req);
	req.randomize() with {req.wr_en==1;req.wr_cs==1; req.rd_en==0; req.rd_cs==0;};
	finish_item(req);
endtask

task read_operation;
	req=fifo_seq_item::type_id::create("req");
        start_item(req);
	req.randomize() with {req.rd_en==1;req.rd_cs==1;req.wr_en==0;req.wr_cs==0;};
	finish_item(req);
endtask

task write_read_operation;
	req=fifo_seq_item::type_id::create("req");
        start_item(req);
	req.randomize() with {req.wr_en==1;req.wr_cs==1; req.rd_en==1; req.rd_cs==1;};
	finish_item(req);
endtask

task body();
repeat(15)
write_operation;

repeat(15)
read_operation;

repeat(15)
write_operation;

repeat(15)
read_operation;

repeat(5)
write_read_operation;

/*repeat(260)
write_operation;*/

endtask
endclass
