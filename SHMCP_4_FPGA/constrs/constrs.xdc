create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} [get_ports clk_in]
set_property BITSTREAM.Config.SPI_buswidth 4 [current_design]

set_property IOSTANDARD LVCMOS33 [get_ports clk_in]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

set_property IOSTANDARD LVCMOS33 [get_ports load]
set_property IOSTANDARD LVCMOS33 [get_ports state]

set_property IOSTANDARD LVCMOS33 [get_ports {instr[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {instr[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {instr[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {instr[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {instr[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {instr[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {instr[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {instr[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports {reg_disp[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {reg_disp[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {reg_disp[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {reg_disp[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports state_o]
set_property IOSTANDARD LVCMOS33 [get_ports load_o]
set_property IOSTANDARD LVCMOS33 [get_ports trm_f]

set_property IOSTANDARD LVCMOS33 [get_ports {sel[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sel[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sel[0]}]

set_property PACKAGE_PIN R2 [get_ports clk_in]
set_property PACKAGE_PIN G15 [get_ports rst]

set_property PACKAGE_PIN H13 [get_ports load]
set_property PACKAGE_PIN H14 [get_ports state]

set_property PACKAGE_PIN L17 [get_ports {instr[7]}]
set_property PACKAGE_PIN L18 [get_ports {instr[6]}]
set_property PACKAGE_PIN M14 [get_ports {instr[5]}]
set_property PACKAGE_PIN N14 [get_ports {instr[4]}]
set_property PACKAGE_PIN M16 [get_ports {instr[3]}]
set_property PACKAGE_PIN M17 [get_ports {instr[2]}]
set_property PACKAGE_PIN M18 [get_ports {instr[1]}]
set_property PACKAGE_PIN N18 [get_ports {instr[0]}]

set_property PACKAGE_PIN E18 [get_ports {reg_disp[3]}]
set_property PACKAGE_PIN F13 [get_ports {reg_disp[2]}]
set_property PACKAGE_PIN E13 [get_ports {reg_disp[1]}]
set_property PACKAGE_PIN H15 [get_ports {reg_disp[0]}]

set_property PACKAGE_PIN F18 [get_ports load_o]
set_property PACKAGE_PIN J15 [get_ports state_o]
set_property PACKAGE_PIN E14 [get_ports trm_f]

set_property PACKAGE_PIN H18 [get_ports {sel[2]}]
set_property PACKAGE_PIN G18 [get_ports {sel[1]}]
set_property PACKAGE_PIN M5 [get_ports {sel[0]}]