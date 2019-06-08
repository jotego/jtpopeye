project_open jtpopeye

# set_global_assignment -name VERILOG_MACRO "TV80S=1"
set_global_assignment -name VERILOG_MACRO "MIST=1"
# set_global_assignment -name VERILOG_MACRO "NODMA=1"
set_global_assignment -name VERILOG_MACRO "NOOBJ=1"
# set_global_assignment -name VERILOG_MACRO "NOUART=1"

set_global_assignment -name TOP_LEVEL_ENTITY jtpopeye_mist
set_global_assignment -name QIP_FILE jtpopeye_mist.qip
set_global_assignment -name QIP_FILE ../modules/jtframe/hdl/mist/mist.qip
set_global_assignment -name QIP_FILE ../modules/jtframe/hdl/clocking/jtframe_pll20.qip
# set_global_assignment -name SDC_FILE ../modules/jtframe/hdl/mist/mist_io.sdc

source ../modules/jtframe/hdl/mist/mist_pins.tcl
