#!/bin/csh -f

source ./dotfile_short

# No need to compile again when running regression script
##make compile                                                            CCOV_EN=on

# Test: Cov improve
make run_sim UVM_TEST_NAME=fpu_test_div_dz_cov_improve                   CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_div_u_dz_cov_improve                 CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_rem_dz_cov_improve                   CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_rem_u_dz_cov_improve                 CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fmadd_unf_1_cov_improve              CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fmadd_unf_2_cov_improve              CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_flog_man_a_zero_cov_improve          CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_cnv_cov_improve 			         CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_packed_cov_improve 			         CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fsqrt_SRT_cov_improve                CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fexp_norm_cov_improve                CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_none_calc_cov_improve                CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_flog_cnt_pointer_cov_improve         CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_arith_ccov_improve                   CCOV_EN=on

# Test: FCOV improvement
make run_sim UVM_TEST_NAME=fpu_test_fcov_rst_during_calc                 CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fcov_round_w_output_flushing         CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fcov_stall_reset_type1               CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fcov_stall_reset_type2               CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fcov_cs_op_operand                   CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fcov_fcvt_w_wu_s_out_of_range        CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fcov_nx_0                            CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fcov_fmul_grs_xx0	                 CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fcov_uf_of_fmadd	                 CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fcov_cg_FPU_Flags_Coverage           CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fcov_cg_Result_format_Arith_fmxxx    CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fcov_fexp_grs_010_100_110            CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fcov_flog_lzc                        CCOV_EN=on


