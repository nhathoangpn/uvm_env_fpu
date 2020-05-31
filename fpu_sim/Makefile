#-------------------------------------------------------------------------------
# set variables
#-------------------------------------------------------------------------------
# coverage enable
CCOV_EN  = off
FCOV_EN  = off

# wave enable
WAVE_EN  = off

# verbosity
UVM_VERBOSITY = UVM_NONE

# test name
UVM_TEST_NAME = fpu_test_base

# rand seed
RAND_SEED = 1

# user define
ENV_DEF        += +define+FOR_REGRESSION
DEBUG_TEST_EN  += off
ARITH_EN       += on
CMPCNV_EN      += on
SPMATH_EN      += on
EXPLOG_EN      += on

ifeq ($(ARITH_EN), on)
	ARITH_OPT = +define+P_FPU_ARITH_EN=1+P_FPU_ARITH_EN_1
	ENV_DEF  += +define+ENV_ARITH_EN
else
	ARITH_OPT = +define+P_FPU_ARITH_EN=0
endif

ifeq ($(CMPCNV_EN), on)
	CMPCNV_OPT = +define+P_FPU_CMPCNV_EN=1+P_FPU_CMPCNV_EN_1
	ENV_DEF   += +define+ENV_CMPCNV_EN
else
	CMPCNV_OPT = +define+P_FPU_CMPCNV_EN=0
endif

ifeq ($(SPMATH_EN), on)
	SPMATH_OPT = +define+P_FPU_SPMATH_EN=1+P_FPU_SPMATH_EN_1
	ENV_DEF   += +define+ENV_SPMATH_EN
else
	SPMATH_OPT = +define+P_FPU_SPMATH_EN=0
endif

ifeq ($(EXPLOG_EN), on)
	EXPLOG_OPT = +define+P_FPU_SPMATH_EXPLOG_EN=1+P_FPU_SPMATH_EXPLOG_EN_1
	ENV_DEF   += +define+ENV_EXPLOG_EN
else
	EXPLOG_OPT = +define+P_FPU_SPMATH_EXPLOG_EN=0+P_FPU_SPMATH_EXPLOG_EN_0
endif

ifeq ($(DEBUG_TEST_EN), on)
	DEBUG_TEST = "DEBUG_"
else
	DEBUG_TEST = ""
endif

#-------------------------------------------------------------------------------
# directories
#-------------------------------------------------------------------------------
CCOV_DIR     = $(SIM_DIR)/ccov_$(DEBUG_TEST)ARITH_$(ARITH_EN)_CMPCNV_$(CMPCNV_EN)_SPMATH_$(SPMATH_EN)_EXPLOG_$(EXPLOG_EN)
LOG_DIR      = $(SIM_DIR)/log_$(DEBUG_TEST)ARITH_$(ARITH_EN)_CMPCNV_$(CMPCNV_EN)_SPMATH_$(SPMATH_EN)_EXPLOG_$(EXPLOG_EN)
LOG_DIR_TEST = $(LOG_DIR)/$(UVM_TEST_NAME)_$(RAND_SEED)

#-------------------------------------------------------------------------------
# testbench
#-------------------------------------------------------------------------------
DUV_TOP_NAME = fpu_top
DUV_TOP_FILE = $(DUV_TOP_NAME).v
TB_TOP_NAME  = tb_top
TB_TOP_FILE  = $(TB_TOP_NAME).sv
FLIST_NAME   = fpu_flist
FLIST_FILE   = $(FLIST_NAME).f
WAVE_FILE    = $(UVM_TEST_NAME)_$(RAND_SEED).vpd
LOG_FILE     = $(UVM_TEST_NAME)_$(RAND_SEED).log

#-------------------------------------------------------------------------------
# wave options
#-------------------------------------------------------------------------------
ifeq (${WAVE_EN}, on)
	WAVE_DEF = +define+VPD
	WAVE_OPT = +vpdfile+$(LOG_DIR_TEST)/$(WAVE_FILE)
endif

#-------------------------------------------------------------------------------
# code coverage options
#-------------------------------------------------------------------------------
COMP_CCOV_OPT = ""
RUN_CCOV_OPT  = ""
URG_OPT       = ""

ifeq (${CCOV_EN}, on)
  COMP_CCOV_OPT += -cm line+cond+fsm+tgl+branch+assert
	COMP_CCOV_OPT += -cm_tgl mda
	COMP_CCOV_OPT += -cm_hier cov_hier.f
  COMP_CCOV_OPT += -cm_dir $(CCOV_DIR)/simv.vdb
  COMP_CCOV_OPT += -cm_name $(UVM_TEST_NAME)_$(RAND_SEED)

  RUN_CCOV_OPT  += -cm line+cond+fsm+tgl+branch+assert
  RUN_CCOV_OPT  += -cm_dir $(CCOV_DIR)/simv.vdb
  RUN_CCOV_OPT  += -cm_name $(UVM_TEST_NAME)_$(RAND_SEED)
  RUN_CCOV_OPT  += +tb_cov_db_dir=$(CCOV_DIR)
  RUN_CCOV_OPT  += +tb_cov_db_name=$(UVM_TEST_NAME)_$(RAND_SEED)

  URG_OPT       += -format both
  URG_OPT       += -report $(CCOV_DIR)/urgReport
  URG_OPT       += -split metric -legacy
  URG_OPT       += -metric line
  URG_OPT       += -metric cond
  URG_OPT       += -metric fsm
  URG_OPT       += -metric tgl
  URG_OPT       += -metric branch
  URG_OPT       += -metric group
  URG_OPT       += -metric assert
  URG_OPT       += -show ratios
	#URG_OPT       += -show tests
endif

#-------------------------------------------------------------------------------
# compile options
#-------------------------------------------------------------------------------
COMPILE_OPT += -full64
COMPILE_OPT += -sverilog 
COMPILE_OPT += -timescale=1ns/1ps
COMPILE_OPT += +vpi
COMPILE_OPT += +memcbk
COMPILE_OPT += -ntb_opts uvm-1.2
COMPILE_OPT += -f $(FLIST_DIR)/$(FLIST_FILE)
COMPILE_OPT += -l comp.log
COMPILE_OPT += -debug_all
COMPILE_OPT += -lca $(COMP_CCOV_OPT)
COMPILE_OPT += $(WAVE_DEF)
COMPILE_OPT += $(ARITH_OPT)
COMPILE_OPT += $(CMPCNV_OPT)
COMPILE_OPT += $(SPMATH_OPT)
COMPILE_OPT += $(EXPLOG_OPT)
COMPILE_OPT += $(ENV_DEF)

#-------------------------------------------------------------------------------
# run options
#-------------------------------------------------------------------------------
RUNSIM_OPT += -l run_sim.log
RUNSIM_OPT += +ntb_random_seed=$(RAND_SEED)
RUNSIM_OPT += +vcs+lic+wait
RUNSIM_OPT += +UVM_TESTNAME=$(UVM_TEST_NAME)
RUNSIM_OPT += +UVM_VERBOSITY=$(UVM_VERBOSITY)
RUNSIM_OPT += +UVM_NO_RELNOTES
RUNSIM_OPT += $(WAVE_OPT)
RUNSIM_OPT += $(RUN_CCOV_OPT)
RUNSIM_OPT += $(ENV_DEF)

#-------------------------------------------------------------------------------
# main
#-------------------------------------------------------------------------------
do_all: ready compile run_sim
do_com: ready compile

ready:
	@if [ ! -d $(LOG_DIR)  ]; then mkdir $(LOG_DIR);  fi
	@if [ ! -d $(CCOV_DIR) ]; then mkdir $(CCOV_DIR); fi
	@if [ ! -e $(TESTFLOAT_DIR)/Lib/TestFloat-3e/build/Linux-riscV-GCC/testfloat_ver ]; then (echo "C-model was not compiled" ; exit 1); fi

compile: ready
	@vcs $(COMPILE_OPT)

run_sim:
	@if [ ! -d $(LOG_DIR_TEST) ]; then mkdir $(LOG_DIR_TEST); fi
	./simv $(RUNSIM_OPT)
	@if [ -e tfv_in_file ];  then mv tfv_in_file  $(LOG_DIR_TEST); fi
	@if [ -e tfv_out_file ]; then mv tfv_out_file $(LOG_DIR_TEST); fi
	./hang_diag.csh
	./sva_finished.csh
	./sva_not_finished.csh
	@mv run_sim.log  $(LOG_DIR_TEST)/$(LOG_FILE)
	@rm -rf tfv_in_file_t tfv_out_file_t

dve:
	@dve -full64 &

report:
	@urg -full64 -format both -dir $(CCOV_DIR)/simv.vdb $(URG_OPT)
	@if [ -d $(CCOV_DIR)/urgReport_ARITH_$(ARITH_EN)_CMPCNV_$(CMPCNV_EN)_SPMATH_$(SPMATH_EN)_EXPLOG_$(EXPLOG_EN) ]; then rm -rf $(CCOV_DIR)/urgReport_ARITH_$(ARITH_EN)_CMPCNV_$(CMPCNV_EN)_SPMATH_$(SPMATH_EN)_EXPLOG_$(EXPLOG_EN); fi
	@mv $(CCOV_DIR)/urgReport $(CCOV_DIR)/urgReport_ARITH_$(ARITH_EN)_CMPCNV_$(CMPCNV_EN)_SPMATH_$(SPMATH_EN)_EXPLOG_$(EXPLOG_EN)

clean:
	@echo "Please wait little...(Remove directory.)" ;
	@rm -rf csrc simv* vc_hdrs* comp.log tr_db.log ucli.key run_sim.log
	@rm -rf tfv_in_file* tfv_out_file* num_log_err num_sva_err
	@rm -rf DVEfiles
	@rm -rf cm.log
	@rm -rf result_*.txt

cleanall: clean
	@echo "Please wait little...(Remove directory.)" ;
	@rm -rf log* 
	@rm -rf ccov*
	@rm -rf urgReport*
