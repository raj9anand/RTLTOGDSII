set log file counter_lec.log -replace

###setup mode
read library slow_vdd1v0_basic_Cells.v -verilog both
read design mod10counter.v -verilog -golden
read design mod10counter_net.v -verilog -revised


###lec mode

set system mode lec

add compare point -all

compare

report compare data



######command to run do file
lec_auto           

#or
source lec.do

