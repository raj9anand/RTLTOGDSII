
# -------------------------------------------------
# Clock Definition
# -------------------------------------------------
create_clock -name clk -period 1 [get_ports clk]
set_clock_uncertainty 0.2 [get_clocks clk]


set_input_delay 1.0 -clock clk [get_ports reset]
set_output_delay 1.0 -clock clk [get_ports q]


set_input_transition 0.1 [get_ports clk]
set_load 0.1 [get_ports q]
