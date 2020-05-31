#!/bin/csh -f

source ./dotfile_short

# Test: Error occur when access to disable instanced operations
make compile                                                                  CMPCNV_EN=off                             CCOV_EN=off RAND_SEED=1
make run_sim UVM_TEST_NAME=fpu_error_test_dis_cmpcvt                          CMPCNV_EN=off                             CCOV_EN=off RAND_SEED=1

make compile                                                     ARITH_EN=off                                           CCOV_EN=off RAND_SEED=1
make run_sim UVM_TEST_NAME=fpu_error_test_dis_arth               ARITH_EN=off                                           CCOV_EN=off RAND_SEED=1

make compile                                                                                SPMATH_EN=off               CCOV_EN=off RAND_SEED=1
make run_sim UVM_TEST_NAME=fpu_error_test_dis_sm                                            SPMATH_EN=off               CCOV_EN=off RAND_SEED=1

make compile                                                                                              EXPLOG_EN=off CCOV_EN=off RAND_SEED=1
make run_sim UVM_TEST_NAME=fpu_error_test_dis_explog                                                      EXPLOG_EN=off CCOV_EN=off RAND_SEED=1

# Test: Parameterized instance checking
make compile                                                     ARITH_EN=on  CMPCNV_EN=off SPMATH_EN=off EXPLOG_EN=off CCOV_EN=off RAND_SEED=1
make run_sim UVM_TEST_NAME=fpu_para_test_en_arth                 ARITH_EN=on  CMPCNV_EN=off SPMATH_EN=off EXPLOG_EN=off CCOV_EN=off RAND_SEED=1

make compile                                                     ARITH_EN=off CMPCNV_EN=on  SPMATH_EN=off EXPLOG_EN=off CCOV_EN=off RAND_SEED=1
make run_sim UVM_TEST_NAME=fpu_para_test_en_cmpcvt               ARITH_EN=off CMPCNV_EN=on  SPMATH_EN=off EXPLOG_EN=off CCOV_EN=off RAND_SEED=1

make compile                                                     ARITH_EN=off CMPCNV_EN=off SPMATH_EN=on  EXPLOG_EN=off CCOV_EN=off RAND_SEED=1
make run_sim UVM_TEST_NAME=fpu_para_test_en_sm_dis_explog        ARITH_EN=off CMPCNV_EN=off SPMATH_EN=on  EXPLOG_EN=off CCOV_EN=off RAND_SEED=1

make compile                                                     ARITH_EN=off CMPCNV_EN=off SPMATH_EN=on  EXPLOG_EN=on  CCOV_EN=off RAND_SEED=1
make run_sim UVM_TEST_NAME=fpu_para_test_en_sm_en_explog         ARITH_EN=off CMPCNV_EN=off SPMATH_EN=on  EXPLOG_EN=on  CCOV_EN=off RAND_SEED=1

make compile                                                     ARITH_EN=on  CMPCNV_EN=on  SPMATH_EN=off EXPLOG_EN=off CCOV_EN=off RAND_SEED=1
make run_sim UVM_TEST_NAME=fpu_para_test_en_arth_cmpcvt          ARITH_EN=on  CMPCNV_EN=on  SPMATH_EN=off EXPLOG_EN=off CCOV_EN=off RAND_SEED=1

make compile                                                     ARITH_EN=on  CMPCNV_EN=off SPMATH_EN=on  EXPLOG_EN=off CCOV_EN=off RAND_SEED=1
make run_sim UVM_TEST_NAME=fpu_para_test_en_arth_sm_dis_explog   ARITH_EN=on  CMPCNV_EN=off SPMATH_EN=on  EXPLOG_EN=off CCOV_EN=off RAND_SEED=1

make compile                                                     ARITH_EN=on  CMPCNV_EN=off SPMATH_EN=on  EXPLOG_EN=on  CCOV_EN=off RAND_SEED=1
make run_sim UVM_TEST_NAME=fpu_para_test_en_arth_sm_en_explog    ARITH_EN=on  CMPCNV_EN=off SPMATH_EN=on  EXPLOG_EN=on  CCOV_EN=off RAND_SEED=1

make compile                                                     ARITH_EN=off CMPCNV_EN=on  SPMATH_EN=on  EXPLOG_EN=off CCOV_EN=off RAND_SEED=1
make run_sim UVM_TEST_NAME=fpu_para_test_en_cmpcvt_sm_dis_explog ARITH_EN=off CMPCNV_EN=on  SPMATH_EN=on  EXPLOG_EN=off CCOV_EN=off RAND_SEED=1

make compile                                                     ARITH_EN=off CMPCNV_EN=on  SPMATH_EN=on  EXPLOG_EN=on  CCOV_EN=off RAND_SEED=1
make run_sim UVM_TEST_NAME=fpu_para_test_en_cmpcvt_sm_en_explog  ARITH_EN=off CMPCNV_EN=on  SPMATH_EN=on  EXPLOG_EN=on  CCOV_EN=off RAND_SEED=1

make compile                                                     ARITH_EN=on  CMPCNV_EN=on  SPMATH_EN=on  EXPLOG_EN=off CCOV_EN=off RAND_SEED=1
make run_sim UVM_TEST_NAME=fpu_para_test_en_all_dis_explog       ARITH_EN=on  CMPCNV_EN=on  SPMATH_EN=on  EXPLOG_EN=off CCOV_EN=off RAND_SEED=1

make compile                                                     ARITH_EN=on  CMPCNV_EN=on  SPMATH_EN=on  EXPLOG_EN=on  CCOV_EN=off RAND_SEED=1
make run_sim UVM_TEST_NAME=fpu_para_test_en_all_en_explog        ARITH_EN=on  CMPCNV_EN=on  SPMATH_EN=on  EXPLOG_EN=on  CCOV_EN=off RAND_SEED=1


