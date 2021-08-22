onerror {quit -f}
vlib work
vlog -work work HazardUnit.vo
vlog -work work HazardUnit.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.HazardUnit_vlg_vec_tst
vcd file -direction HazardUnit.msim.vcd
vcd add -internal HazardUnit_vlg_vec_tst/*
vcd add -internal HazardUnit_vlg_vec_tst/i1/*
add wave /*
run -all
