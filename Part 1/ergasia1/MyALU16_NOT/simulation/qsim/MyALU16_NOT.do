onerror {quit -f}
vlib work
vlog -work work MyALU16_NOT.vo
vlog -work work MyALU16_NOT.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.MyALU16_NOT_vlg_vec_tst
vcd file -direction MyALU16_NOT.msim.vcd
vcd add -internal MyALU16_NOT_vlg_vec_tst/*
vcd add -internal MyALU16_NOT_vlg_vec_tst/i1/*
add wave /*
run -all
