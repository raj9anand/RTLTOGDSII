

########filesetup
source filename.globals
init_design

checkDesign -timingLibrary
checkDesign -physicalLibrary
checkDesign -netlist
checkDesign -all

########floorplan

########pinplacement
checkPinAssignment
legalizePin -pin * -moveFixedPin
setPtnPinStatus -pin * -status FIXED
saveIoFile pins.io


##########placement
place_design
timeDesign -preCTS -slackReports -drvReports
createBasicsPathGroups -expanded
timeDesign -preCTS -slackReports -drvReports
report_timing -from [all_registers] -to [all_registers]
report_timing -from [all_registers] -to [all_registers] -max <path_number>
report_timing -from [all_registers] -to [all_outputs] 
reportCongestion -overflow
report_power
reportGateCount
saveDesign prects.enc
optDesign -preCTS



####cts
source counter_opt.enc

add_ndr -width {Metal 0.12 Metal2 0.16 Metal3 0.16 Metal4 0.16 Metal5 0.16 Metal6 0.16 Metal7 0.16 Metal8 0.16 Metal9 0.16 Metal10 0.44 Metal11 0.44} -spacing {Metal 0.12 Metal2 0.14 Metal3 0.14 Metal4 0.14 Metal5 0.14 Metal6 0.14 Metal7 0.14 Metal8 0.14 Metal9 0.14 Metal10 0.4 Metal11 0.4} -name 2w2s
create_route_type -name clkroute -non_default_rule 2w2s -bottom_preferred_layer Metal5 -top_preferred_layer Metal6
set_ccopt_property route_type clkroute -net_type trunk
set_ccopt_property route_type clkroute -net_type leaf
set_ccopt_property buffer_cells {CLKBUFX8 CLKBUFX12}
set_ccopt_property inverter_cells {CLKINVX8 CLKINVX12}
set_ccopt_property clock_gatting_cells TLANTNTSCA*
create_ccopt_clock_tree_spec -file ccopt.spec


source ccopt.spec
ccopt_design -cts
optDesign -postCTS



report_timing
timeDesign -postCTS -drvReports -slackReports
timeDesign -postCTS -slackReports -hold
report_ccopt_skew_groups
set_propagated_clock [get_clocks*]
optDesign -postCTS -setup
report_clock_timing -type skew
reportCongestion -overflow
reportDesignUtil
reportGateCount

saveDesign ./pd_output/post_cts.enc


####routing

source ./pd_output/post_cts.enc
routeDesign
setAnalysisMode -analysisType onChipVariation
report_timing
optDesign -postRoute
timeDesign -postRoute -slackReports -drvReports
verify_drc
saveDesign ./pd_output/post_route.enc



extractRC
rcOut -spef max.spef -rc_corner max_rc
verifyProcesssAntenna

#############sta


##########physical_verification
source ./pd_output/post_route.enc
verify_drc
verify_connectivity
addFiller -cell FILL1

saveNetlist routed.v


##########poweranalysis



#######savegdsii
streamOut counter.gds





