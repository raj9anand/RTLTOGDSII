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

##placement_command










