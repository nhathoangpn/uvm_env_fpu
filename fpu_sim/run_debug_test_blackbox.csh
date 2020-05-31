#!/bin/csh -f

####This is for debug test only ##########
source ./dotfile

make compile                                              CCOV_EN=on DEBUG_TEST_EN=on

# Test: Single Floating point computing -> Arithmetic
make run_sim UVM_TEST_NAME=fpu_test_fmadd_db_01           CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fmadd_db_spec_3495_01 CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fadd_db_3457_01       CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fadd_db_3457_02       CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fadd_db_3457_03       CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fadd_db_3458_01       CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fadd_db_3504_01       CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fmul_db_3460_01       CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_mul_db_3517           CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_mulh_db_3519          CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_mulh_u_db_3520        CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_sub_db_3516           CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_add_db_3486           CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_div_db_3487           CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_div_u_db_3488         CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_madd_db_3490          CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_mnadd_db_3490         CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_msub_db_3490          CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_mnsub_db_3490         CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_mul_db_3499           CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_mulh_db_3499          CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_rem_db_3529           CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_rem_u_db_3529         CCOV_EN=on DEBUG_TEST_EN=on


## Test: Single Floating point computing -> Special math
make run_sim UVM_TEST_NAME=fpu_test_fdiv_db_3505           CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fdiv_db_3505_01_inf_p  CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fdiv_db_3505_02_inf_m  CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fdiv_db_3505_03_zero_p CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fdiv_db_3505_04_zero_m CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fdiv_db_3505_05_cNAN   CCOV_EN=on DEBUG_TEST_EN=on

make run_sim UVM_TEST_NAME=fpu_test_fmul_db_3506           CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fmul_db_3508           CCOV_EN=on DEBUG_TEST_EN=on

## Test: Single Floating point computing -> Compare

## Test: Single Floating point computing -> Convert


## Test: Single Integer computing -> Arithmetic


## Test: Single Integer computing -> Special math
make run_sim UVM_TEST_NAME=fpu_test_flog_db_3485_01        CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_flog_db_3485_02        CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_flog_db_3485_03        CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fexp_db_3525           CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_flog_db_3500           CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_flog_man_a_fix_1_0000xxxx   CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_flog_man_a_fix_2_0000xxxx   CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_flog_man_a_fix_7E_7FFFxx    CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_flog_man_a_fix_7E_7Fxxxx    CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_flog_man_a_fix_7E_xxxxxx    CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fexp_negative_126       CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fexp_negative_127       CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fexp_negative_int       CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fexp_positive_int       CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fexp_sub_normal         CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_fexp_zero               CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_flog_1_0                CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_flog_sub_normal         CCOV_EN=on DEBUG_TEST_EN=on


## Test: Single Integer computing -> Compare


## Test: Single Integer computing -> Convert
