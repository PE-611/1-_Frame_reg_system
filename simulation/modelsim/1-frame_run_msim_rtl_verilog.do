transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/Projects/Project\ 1-frame\ reg\ system {C:/intelFPGA_lite/18.1/Projects/Project 1-frame reg system/main.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/Projects/Project\ 1-frame\ reg\ system {C:/intelFPGA_lite/18.1/Projects/Project 1-frame reg system/UART_Tx.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/Projects/Project\ 1-frame\ reg\ system {C:/intelFPGA_lite/18.1/Projects/Project 1-frame reg system/exposition.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/Projects/Project\ 1-frame\ reg\ system {C:/intelFPGA_lite/18.1/Projects/Project 1-frame reg system/time_of_hold_hv.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/Projects/Project\ 1-frame\ reg\ system {C:/intelFPGA_lite/18.1/Projects/Project 1-frame reg system/spi_tx.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/Projects/Project\ 1-frame\ reg\ system {C:/intelFPGA_lite/18.1/Projects/Project 1-frame reg system/uart_rx.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/Projects/Project\ 1-frame\ reg\ system {C:/intelFPGA_lite/18.1/Projects/Project 1-frame reg system/my_ram.v}

vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/Projects/Project\ 1-frame\ reg\ system/simulation/modelsim {C:/intelFPGA_lite/18.1/Projects/Project 1-frame reg system/simulation/modelsim/main.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  main_vlg_tst

add wave *
view structure
view signals
run -all
