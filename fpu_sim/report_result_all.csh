#!/bin/csh 

#get report for all test without debug test
./report.csh ARITH_ > result_all_test_wo_debug_test.txt

#get report for all test with enable all pipeline withoud debug test
./report.csh ARITH_on_CMPCNV_on_SPMATH_on_EXPLOG_on > result_all_test_all_pipe_on.txt

#get report all debug test
./report.csh DEBUG_ > result_all_debug_test.txt
