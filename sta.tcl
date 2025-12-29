###############################################################################################
                                    Static Timing Analysis(STA)
###############################################################################################
set_case_analysis 
read_parasitics
check_timing
timeDesign -preCTS -SlackReports -drvReports

#to check all reg2reg voilation path
createBasicPathGroups -expanded
timeDesign -preCTS -SlackReports -drvReports
#specific reg2reg timing
report_timing -from <register1_name> -to <register2_name>
report_timing -from <register1_name> -to <register2_name>  -check_type hold

##from all input to register
report_timing -from [all_inputs] -to [all_registers]

report_timing -from [all_registers] -to [all_registers]


##############multi cycle path
set_multicycle_path -setup 2 -from FF1/Q -to FF2/Q
set_multicycle_path -hold 1 -from FF1/Q -to FF2/Q
