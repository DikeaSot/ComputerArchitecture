onerror {quit -f}
vlib work
vlog -work work Register_ID_EX.vo
vlog -work work Register_ID_EX.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Register_ID_EX_vlg_vec_tst
vcd file -direction Register_ID_EX.msim.vcd
vcd add -internal Register_ID_EX_vlg_vec_tst/*
vcd add -internal Register_ID_EX_vlg_vec_tst/i1/*
add wave /*
run -all
