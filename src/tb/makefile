all:
	vlog -sv +acc +cover +fcover -l log_file.log fifo_top.sv
	vsim -vopt work.fifo_top -voptargs=+acc=npr -assertdebug -l log_file.log -coverage -c -wlf wave.wlf -do "log -r /*; coverage save -onexit -assert -directive -cvg -codeAll ucdb_file_name.ucdb; run -all; exit"
	vsim -c -do "wlf2vcd wave.wlf -o wave.vcd; exit"
