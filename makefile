TOP=crc7_tb_top.sv
SIM_VCS_DIR=./sim/vcs
SIM_NCV_DIR=./sim/ncv


.PHONY: c s clean_ncv clean_vcs sim tb src


c:clean_ncv
	-access rw                               \
	-quiet    -clean                         \
	cd ${SIM_NCV_DIR} && irun                \
	-sv -disable_sem2009                     \
	-uvmhome CDNS-1.2                        \
	+define+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR \
	-incdir ../../tb                         \
	-incdir ../../src                        \
	+gui  +nctimescale+1ns/100ps             \
	../../tb/${TOP}                          &

s:clean_vcs
	cd ${SIM_VCS_DIR} && vcs -R              \
	-quiet                                   \
	-sverilog                                \
	-ntb_opts uvm                            \
	-timescale=1ns/100ps                     \
	+incdir+../../tb+../../src               \
	-l vcs.log                               \
	-gui                                     \
	../../tb/${TOP}                          &

scov:scov
	cd ${SIM_VCS_DIR} && urg -dir simv.vdb   \
	-format text ${TOP}

clean_ncv:
	-@rm -rf ${SIM_NCV_DIR}/*
	echo "-----irun directory is cleaned------"

clean_vcs:
	-@rm -rf ${SIM_VCS_DIR}/*
	echo "-----vcs directory is cleaned------"
