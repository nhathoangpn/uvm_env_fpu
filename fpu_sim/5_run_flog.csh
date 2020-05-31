#!/bin/csh -f

####This is for debug test only ##########
source ./dotfile_short

make compile                                                CCOV_EN=on DEBUG_TEST_EN=on

make run_sim UVM_TEST_NAME=fpu_test_flog_0_5_to_1_0         CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_flog_1_0_to_1_5         CCOV_EN=on DEBUG_TEST_EN=on
make run_sim UVM_TEST_NAME=fpu_test_flog_1_5_to_2_0         CCOV_EN=on DEBUG_TEST_EN=on

