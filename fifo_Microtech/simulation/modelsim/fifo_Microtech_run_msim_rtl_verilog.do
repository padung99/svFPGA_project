transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+F:/YandexDisk/FPGAPRoject/fifo_Microtech {F:/YandexDisk/FPGAPRoject/fifo_Microtech/fifo_Microtech.sv}

