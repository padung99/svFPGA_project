vlib work

vlog -sv Packet.sv
vlog -sv random_testing.sv

vsim random_testing

run -all
