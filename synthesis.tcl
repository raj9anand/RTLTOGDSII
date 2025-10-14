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
###to check any submodule is not connected
check_design -unresolved

##read_sdc
read_sdc constraint.sdc

#lint_check
report_timing -lint

###synthesis step
syn_generic
syn_map
syn_opt


#####write_file
write_hdl > mod10counter_net.v
write_sdc > constraint_out.sdc


###generate report
report_area > area.rpt
report_power > power.rpt
report_timing > timing.rpt
report_gates > gates.rpt


##after sourcing run belo command for synthesis


source synthesis.tcl
