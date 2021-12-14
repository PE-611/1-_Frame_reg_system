transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {1-frame.vo}

vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/18.1/Projects/Project\ 1-frame\ reg\ system/simulation/modelsim {C:/intelFPGA_lite/18.1/Projects/Project 1-frame reg system/simulation/modelsim/main.vt}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L gate_work -L work -voptargs="+acc"  main_vlg_tst

add wave *
view structure
view signals
run -all
