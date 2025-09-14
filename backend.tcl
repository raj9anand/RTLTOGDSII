###floorplan_command###
#done using gui mode

##pinplacement_command#####
checkPinAssignment                       ###checkpin
legalizePin -pin * -moveFixedpin         ###legalizepin
setPtnPinStatus -pin * -status fixed     ###fixpin at location
verify_drc                               ##drc_check
saveDesign ./pd_output/pinplacement.enc      #save ur pinplacement design

###powerplanning_command#########
#it is completly done using gui mode.
#must check drc after powerplanning
verify_drc
saveDesign  ./pd_output/mod10counter_powerplan.enc    #save ur powerplan design

###loadscandef
read_def mod10counter_scandef.scandef
set_db reorder_scan_comp_logic true

######placement_command##########
placeDesign 
optDesign -preCTS
     ###or##
place_opt_design

checkPlace
report_timing
reportCongestion -overflow
saveDesign ./pd_output/mod10counter_placed.enc

###cts##########
source ./pd_output/mod10counter_placed.enc
##Cts specification setup
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
report_ccopt_ske_groups

saveDesign ./pd_output/post_cts.enc


#######################routing###########
source ./pd_output/post_cts.enc
routeDesign
setAnalysisMode -analysisType onChipVariation
report_timing
optDesign -postRoute
timeDesign -postRoute -slackReports -drvReports
verify_drc
saveDesign ./pd_output/post_route.enc

#####parasitic extraction ##############




























