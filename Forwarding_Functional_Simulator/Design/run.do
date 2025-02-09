vlib work
vlog -lint mipspkg.sv
vlog -lint design.sv
vlog -lint testbench.sv
#vlog instructionFetch.sv
#vlog memStage.sv

vsim work.top

run -all
