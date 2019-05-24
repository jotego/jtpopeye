project_open jtpopeye

set_global_assignment -name TOP_LEVEL_ENTITY jtpopeye_mist
set_global_assignment -name QIP_FILE jtpopeye.qip
set_global_assignment -name QIP_FILE ../modules/jtframe/hdl/mist/mist.qip
set_global_assignment -name QIP_FILE ../modules/jtframe/hdl/clocking/jtframe_pll20.qip
# set_global_assignment -name SDC_FILE ../modules/jtframe/hdl/mist/mist_io.sdc
set_global_assignment -name QIP_FILE ../modules/jt49/hdl/jt49.qip
set_global_assignment -name QIP_FILE ../modules/t80/T80.qip

source ../modules/jtframe/hdl/mist/mist_pins.tcl
