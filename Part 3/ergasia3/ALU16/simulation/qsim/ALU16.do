onerror {quit -f}
vlib work
vlog -work work ALU16.vo
vlog -work work ALU16.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.ALU16_vlg_vec_tst
vcd file -direction ALU16.msim.vcd
vcd add -internal ALU16_vlg_vec_tst/*
vcd add -internal ALU16_vlg_vec_tst/i1/*
add wave /*
run -all
