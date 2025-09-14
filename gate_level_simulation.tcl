###########xcelium command
#gui_mode
xrun mod10counter_net.v mod10counter_tb.v slow_vdd1v0_basic_Cells.v -access +rwc -gui &

#terminal_mode
xrun mod10counter_net.v mod10counter_tb.v slow_vdd1v0_basic_Cells.v


###############incesive

#gui_mode
irun mod10counter_net.v mod10counter_tb.v slow_vdd1v0_basic_Cells.v -access +rwc -gui &

#terminal_mode
irun mod10counter_net.v mod10counter_tb.v slow_vdd1v0_basic_Cells.v