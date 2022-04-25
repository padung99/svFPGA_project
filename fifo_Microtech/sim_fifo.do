vlib work

vlog -sv fifo_Microtech.sv
vlog -sv fifo_tb.sv

vsim fifo_tb

add log -r /*
add wave -r *
run -all