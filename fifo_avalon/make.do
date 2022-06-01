vlib work

vlog -sv fifo.sv
vlog -sv avalon_interface.sv
vlog -sv fifo_avalon.sv
vlog -sv fifo_tb.sv

vsim fifo_tb

add log -r /*

#Use this command to add "mem waveform"
add wave "sim:/fifo_tb/dut/fifo_inst/mem"

add wave -r *
run -all
