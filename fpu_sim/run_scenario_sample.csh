#!/bin/csh

source ./dotfile_short

make compile CCOV_EN=on

make run_sim UVM_TEST_NAME=fpu_test_sample_00 CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_sample_01 CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_sample_02 CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_sample_03 CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_sample_04 CCOV_EN=on
make run_sim UVM_TEST_NAME=fpu_test_sample_05 CCOV_EN=on
