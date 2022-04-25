vlib work

vlog -sv fifo.sv
vlog -sv top_tb.sv

vsim top_tb

add log -r /*
add wave -r *
run -all
