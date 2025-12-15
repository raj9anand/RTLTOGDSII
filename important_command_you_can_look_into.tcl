############################################################################################
                                 Synopsys Design Constraint (SDC)
############################################################################################

#operating conditions
set_operating_conditions
#wire load models
set_wire_load_min_block_size
set_wire_load_mode
set_wire_load_model
set_wire_load_selection_group
#system interface
set_drive
set_driving_cell
set_fanout_load
set_input_transition
set_load
set_port_fanout_number
#design rule constraint
set_max_capacitance
set_max_fanout
set_max_transition
set_min_capacitance

#set timing/clock constraint
create_clock -period 4 -name CK1 -waveform {0 2}
set_min_pulse_width -high 2.5 [all_clocks]
set_min_pulse_width -low 2.0 [all_clocks]
create_generated_clock
group_path
set_clock_gating_check
set_clock_groups
set_clock_latency
set_clock_sense
set_clock_transition
set_clock_uncertainty
set_data_check
set_disable_timing
set_ideal_latency
set_ideal_network
set_ideal_transition
set_input_delay
set_max_time_borrow
set_output_delay
set_propagated_clock
set_resistance
set_timing_derate

##area constraints
set_max_area
## multivoltage and power optimization
create_voltage_area
set_level_shifter_strategy
set_level_shifter_threshold
set_max_dynamic_power
set_max_leakage_power
### logic assignment
set_case_analysis
set_logic_dc
set_logic_one
set_logic_zero

#timing excpetion
set_false_path
set_max_delay
set_min_delay
set_multicycle_path

###############################################################################################
                                    Static Timing Analysis(STA)
###############################################################################################
set_case_analysis 
read_parasitics
check_timing
