onerror {quit -f}
vlib work
vlog -work work digitalClock.vo
vlog -work work digitalClock.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.digitalClock_vlg_vec_tst
vcd file -direction digitalClock.msim.vcd
vcd add -internal digitalClock_vlg_vec_tst/*
vcd add -internal digitalClock_vlg_vec_tst/i1/*
add wave /*
run -all
