onerror {quit -f}
vlib work
vlog -work work myXOR.vo
vlog -work work myXOR.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.myXOR_vlg_vec_tst
vcd file -direction myXOR.msim.vcd
vcd add -internal myXOR_vlg_vec_tst/*
vcd add -internal myXOR_vlg_vec_tst/i1/*
add wave /*
run -all
