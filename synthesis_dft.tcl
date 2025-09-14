#####synthesis##########
##search path for libraries tcl and rtl
set_db init_lib_search_path {/DIG_DESIGN/STUDENTS/PHD/anandraj/mod10counter/lib/}
set_db init_hdl_search_path {/DIG_DESIGN/STUDENTS/PHD/anandraj/mod10counter/rtl/}
set_db script_search_path {/DIG_DESIGN/STUDENTS/PHD/anandraj/mod10counter/constraint/}


##library and rtl

set_db library slow_vdd1v0_basic_Cells.lib
read_hdl mod10counter.v
set top_design mod10counter

###elaborate
elaborate mod10counter

##read_sdc
read_sdc constraint.sdc

####scan_chain_insertion_part1
check_dft_rules
set_db dft_scan_style muxed_scan
define_shift_enable -name SE -active high -create_port SE default


###synthesis step
syn_generic
syn_map
syn_opt



####scan_chain_insertion_part2
set_db design:mod10counter .dft_min_number_of_scan_chains 1
define_scan_chain -name top_chain -sdi scan_ff_in -sdo scan_ff_out -create_port
connect_scan_chains -auto_create_chains
report_scan_chains



#####write_file
write_hdl > mod10counter_dft_net.v
write_sdc > constraint_dft_out.sdc


###generate report
report_area > area_dft.rpt
report_power > power_dft.rpt
report_timing > timing_dft.rpt
report_gates > gates_dft.rpt


##after sourcing run below command for synthesis

source synthesis_dft.tcl