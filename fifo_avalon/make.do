vlib work

vlog -sv avalon_interface.sv
vlog -sv fifo_avalon.sv
vlog -sv fifo_tb.sv

vsim fifo_tb


add log -r /*
add wave -r *
run -all
