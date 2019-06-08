PROJECT=jtpopeye
SOURCE_FILES= \
	msg.py 					    \
	../hdl/jtpopeye_bck.v		\
	../hdl/jtpopeye_buf.v		\
	../hdl/jtpopeye_cen.v		\
	../hdl/jtpopeye_colmix.v	\
	../hdl/jtpopeye_dma.v		\
	../hdl/jtpopeye_game.v		\
	../hdl/jtpopeye_main.v		\
	../hdl/jtpopeye_mist.v		\
	../hdl/jtpopeye_obj.v		\
	../hdl/jtpopeye_prom_we.v	\
	../hdl/jtpopeye_rom.v		\
	../hdl/jtpopeye_security.v	\
	../hdl/jtpopeye_timing.v	\
	../hdl/jtpopeye_txt.v		\
	../hdl/jtpopeye_video_dec.v	\
	../hdl/jtpopeye_video.v		\
	../modules/jtframe/hdl/ram/jtgng_ram.v		     \
	../modules/jtframe/hdl/ram/jtgng_prom.v		     \
	../modules/jtframe/hdl/jtgng_sdram.v		     \
	../modules/jtframe/hdl/sdram/jtframe_romrq.v     \
	../modules/jtframe/hdl/mist/jtframe_mist.v       \
	../modules/jtframe/hdl/mist/jtgng_mist_base.v    \
	../modules/jtframe/hdl/jtgng_board.v             \
	../modules/jtframe/hdl/keyboard/jtgng_keyboard.v \
	../modules/jtframe/hdl/keyboard/ps2_intf.vhd     \
	jtpopeye_mist.qip                                \
	jtpopeye.qip

ASSIGNMENT_FILES = jtpopeye.qpf jtpopeye.qsf set_qip.tcl

all: smart.log $(PROJECT).asm.rpt $(PROJECT).sta.rpt

prog: smart.log $(PROJECT).asm.rpt
	program.sh

clean:
	rm -rf *.rpt *.chg smart.log *.htm *.eqn *.pin *.sof *.pof db incremental_db *jdi *fit.* *summary
	rm -f $(PROJECT).qsf *.qws *.qpf *.smsg

map: smart.log $(PROJECT).map.rpt
fit: smart.log $(PROJECT).fit.rpt
asm: smart.log $(PROJECT).asm.rpt
sta: smart.log $(PROJECT).sta.rpt
smart: smart.log

MAP_ARGS = --family="Cyclone III"
FIT_ARGS = --part=EP3C25E144C8
ASM_ARGS =
STA_ARGS =

STAMP = echo done >

$(PROJECT).map.rpt: map.chg $(SOURCE_FILES)
	quartus_map $(MAP_ARGS) $(PROJECT)
	$(STAMP) asm.chg
	$(STAMP) sta.chg

$(PROJECT).fit.rpt: fit.chg $(PROJECT).map.rpt
	quartus_fit $(FIT_ARGS) $(PROJECT)
	$(STAMP) asm.chg
	# $(STAMP) sta.chg

$(PROJECT).asm.rpt: asm.chg $(PROJECT).fit.rpt
	quartus_asm $(ASM_ARGS) $(PROJECT)

$(PROJECT).sta.rpt: sta.chg $(PROJECT).fit.rpt
	quartus_sta $(STA_ARGS) $(PROJECT)

smart.log: $(ASSIGNMENT_FILES)
	quartus_sh --determine_smart_action $(PROJECT) > smart.log

$(ASSIGNMENT_FILES): set_qip.tcl
	msg.py
	quartus_sh --prepare $(PROJECT)
	quartus_sh -t set_qip.tcl

map.chg:
	$(STAMP) map.chg
fit.chg:
	$(STAMP) fit.chg
sta.chg:
	$(STAMP) sta.chg
asm.chg:
	$(STAMP) asm.chg

