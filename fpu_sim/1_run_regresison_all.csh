#!/bin/csh -f

source ./dotfile_short

set rpt_time = `date +%Y%m%d_%H%M%S`
touch START_$rpt_time

####--------------------------------------------
####--- Run 1 time with SEED=1 -----------------

## Test: Have disable pipeline
./run_test_blackbox_dis_pipe.csh
## Test: For test in debugging phase
./run_debug_test_blackbox_short.csh

## Compile again for enabling all pipelines
 make compile                                                     CCOV_EN=on
## Test: Fcov and ccov improvement
./run_fcov_ccov_improve.csh

####--- Run 11 times with SEED=fixed value------------

### Only used to generate seed number at first time
##set loop_num = 11 
##@ loop = $loop_num
##
## while ($loop > 1) 
## set seed = `od -vAn -N4 -tx4 < /dev/random`
## echo "$seed"
## @ loop -= 1
##
## end


## Set fixed SEED number
 set seed = ( \
             1        \
	         614e8c76 )
#	         06c43c96 \
#	         0098279e \
#	         120ed0a4 \
#	         26a2efa3 \
#	         c1895737 \
#	         0cfe98fd \
#	         f9a9a5b2 \
#	         42635682 )
 
 ##---START to run RANDOM test ----#
 foreach snum  ($seed)
  # Test: Single Floating point computing
  make run_sim UVM_TEST_NAME=fpu_test_fadd                         CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_fsub                         CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_fmul                         CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_fdiv                         CCOV_EN=on RAND_SEED=$snum 
  make run_sim UVM_TEST_NAME=fpu_test_fmadd                        CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_fmnadd                       CCOV_EN=on RAND_SEED=$snum 
  make run_sim UVM_TEST_NAME=fpu_test_fmnsub                       CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_fmsub                        CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_fsqrt                        CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_fexp                         CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_flog                         CCOV_EN=on RAND_SEED=$snum
  
  # Test: Compare computing
  make run_sim UVM_TEST_NAME=fpu_test_feq                          CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_fle                          CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_flt                          CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_fmax                         CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_fmin                         CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_fne                          CCOV_EN=on RAND_SEED=$snum
  
  # Test: Convert computing
  make run_sim UVM_TEST_NAME=fpu_test_fcvt_s_w                     CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_fcvt_s_wu                    CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_fcvt_w_s                     CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_fcvt_wu_s                    CCOV_EN=on RAND_SEED=$snum
  
  # Test: Integer computing
  make run_sim UVM_TEST_NAME=fpu_test_add                          CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_add_u                        CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_div_s                        CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_div_u                        CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_madd                         CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_mnadd                        CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_mnsub                        CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_msub                         CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_mulh_su                      CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_mulh                         CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_mulh_u                       CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_mul_su                       CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_mul                          CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_mul_u                        CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_rem_s                        CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_rem_u                        CCOV_EN=on RAND_SEED=$snum 
  make run_sim UVM_TEST_NAME=fpu_test_sub                          CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_sub_u                        CCOV_EN=on RAND_SEED=$snum
  
  # Test: Input operands flushing subnormal number
  make run_sim UVM_TEST_NAME=fpu_test_input_flush_fadd             CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_input_flush_fdiv             CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_input_flush_fexp             CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_input_flush_flog             CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_input_flush_fmadd            CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_input_flush_fmnadd           CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_input_flush_fmnsub           CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_input_flush_fmsub            CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_input_flush_fmul             CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_input_flush_fsqrt            CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_input_flush_fsub             CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_input_flush_fcvt_w_s         CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_input_flush_fcvt_wu_s        CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_input_flush_feq              CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_input_flush_fle              CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_input_flush_flt              CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_input_flush_fmax             CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_input_flush_fmin             CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_input_flush_fne              CCOV_EN=on RAND_SEED=$snum
  
  # Test: Result output flushing subnormal number
  make run_sim UVM_TEST_NAME=fpu_test_output_flush_fsub            CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_output_flush_fsqrt           CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_output_flush_fmul            CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_output_flush_fmsub           CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_output_flush_fmnsub          CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_output_flush_fmnadd          CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_output_flush_fmadd           CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_output_flush_flog            CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_output_flush_fexp            CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_output_flush_fdiv            CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_output_flush_fadd            CCOV_EN=on RAND_SEED=$snum
  
  # Test: Pipeline/Non-pipeline check
  make run_sim UVM_TEST_NAME=fpu_test_pipeline_cmpcvt              CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_pipeline_arth                CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_pipeline_arth_cmpcvt         CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_nonpipeline_sm_vld           CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_nonpipeline_sm_invld         CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_arth_sm_compcvt_vld          CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_arth_sm_compcvt_invld        CCOV_EN=on RAND_SEED=$snum
  
  # Test: Reset check
  make run_sim UVM_TEST_NAME=fpu_test_rst_arth                     CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_rst_cmpcvt                   CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_rst_sm                       CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_rst_init                     CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_rst_init_error_o             CCOV_EN=on RAND_SEED=$snum
  
  # Test: Stall check
  make run_sim UVM_TEST_NAME=fpu_test_stall_rand                   CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_stall_arth                   CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_stall_sm                     CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_test_stall_cmpcvt                 CCOV_EN=on RAND_SEED=$snum
  
  # Test: Conflict beween Reset and Stall
  make run_sim UVM_TEST_NAME=fpu_test_conflict_stall_reset         CCOV_EN=on RAND_SEED=$snum
  
  # Test: Error occur when access to reserve operations
  make run_sim UVM_TEST_NAME=fpu_error_test_arth                   CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_error_test_cmpcvt                 CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_error_test_sm                     CCOV_EN=on RAND_SEED=$snum
  make run_sim UVM_TEST_NAME=fpu_error_test_reserved_pipeline      CCOV_EN=on RAND_SEED=$snum
  
  #Test: Error occur when access to reserved rm_i
  make run_sim UVM_TEST_NAME=fpu_test_reserved_rm                  CCOV_EN=on RAND_SEED=$snum

 end

####-------For report result ----###
./report_result_all.csh


set rpt_time = `date +%Y%m%d_%H%M%S`
touch END_$rpt_time

####--------------------------------------------
