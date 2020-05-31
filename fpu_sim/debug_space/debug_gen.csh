#!/bin/csh -f

########################################################################################
# Guidance
#
# Step 1: select log folder as parameter define
# Step 2: select the name of FAIL test 
# Step 3: Copy log file or NOT 
# Step 4: Run script ./debug_gen.csh
# Step 5: Check your FAIL case
#   + cd your_test_dir , example : fpu_test_input_flush_fmnadd_1/
#   + Find Error in tfv_out_file, take care operation opcode and rounding mode
#   + Ex: f32_mulNegateAdd -rminMag
#         Error line: 1261
#   + Open tfv_in_file_f32_mulNegateAdd_rminMag, fine to line 1261 to know your input operands and condition of FAIL case
#   + Generate again test case with : 1261(Line) 00485da9 7f800000 ffe92fc3 7fc00000 20
#
# NOTE : If you run only 1 operation with 1 rounding mode as direct test, you don't need to use this tool
#        But you still can use to easy debug or collect the FAIL information
########################################################################################

######################################################################
# Step 1
######################################################################
#set log = "../log_ARITH_off_CMPCNV_off_SPMATH_on_EXPLOG_off"
#set log = "../log_ARITH_off_CMPCNV_off_SPMATH_on_EXPLOG_on"
#set log = "../log_ARITH_off_CMPCNV_on_SPMATH_off_EXPLOG_off"
#set log = "../log_ARITH_off_CMPCNV_on_SPMATH_on_EXPLOG_off"
#set log = "../log_ARITH_off_CMPCNV_on_SPMATH_on_EXPLOG_on"
#set log = "../log_ARITH_on_CMPCNV_off_SPMATH_off_EXPLOG_off"
#set log = "../log_ARITH_on_CMPCNV_off_SPMATH_on_EXPLOG_off"
#set log = "../log_ARITH_on_CMPCNV_off_SPMATH_on_EXPLOG_on"
#set log = "../log_ARITH_on_CMPCNV_on_SPMATH_off_EXPLOG_off"
#set log = "../log_ARITH_on_CMPCNV_on_SPMATH_off_EXPLOG_on"
#set log = "../log_ARITH_on_CMPCNV_on_SPMATH_on_EXPLOG_off"
#set log = "../log_ARITH_on_CMPCNV_on_SPMATH_on_EXPLOG_on"
set log = "../log_ARITH_on_CMPCNV_on_SPMATH_on_EXPLOG_on"

######################################################################
# Step 2
######################################################################
set tm = "fpu_test_fmadd_unf_1_cov_improve_1"
#set tm = "fpu_test_add_1"
#set tm = "fpu_test_add_u_1"
#set tm = "fpu_test_arth_sm_compcvt_invld_1"
#set tm = "fpu_test_arth_sm_compcvt_vld_1"
#set tm = "fpu_test_conflict_stall_reset_1"
#set tm = "fpu_test_div_s_1"
#set tm = "fpu_test_div_u_1"
#set tm = "fpu_test_fadd_1"
#set tm = "fpu_test_fcvt_s_w_1"
#set tm = "fpu_test_fcvt_s_wu_1"
#set tm = "fpu_test_fcvt_w_s_1"
#set tm = "fpu_test_fcvt_wu_s_1"
#set tm = "fpu_test_fdiv_1"
#set tm = "fpu_test_feq_1"
#set tm = "fpu_test_fexp_1"
#set tm = "fpu_test_fle_1"
#set tm = "fpu_test_flog_1"
#set tm = "fpu_test_flt_1"
#set tm = "fpu_test_fmadd_1"
#set tm = "fpu_test_fmax_1"
#set tm = "fpu_test_fmin_1"
#set tm = "fpu_test_fmnadd_1"
#set tm = "fpu_test_fmnsub_1"
#set tm = "fpu_test_fmsub_1"
#set tm = "fpu_test_fmul_1"
#set tm = "fpu_test_fne_1"
#set tm = "fpu_test_fsqrt_1"
#set tm = "fpu_test_fsub_1"
#set tm = "fpu_test_input_flush_fadd_1"
#set tm = "fpu_test_input_flush_fcvt_w_s_1"
#set tm = "fpu_test_input_flush_fcvt_wu_s_1"
#set tm = "fpu_test_input_flush_fdiv_1"
#set tm = "fpu_test_input_flush_feq_1"
#set tm = "fpu_test_input_flush_fexp_1"
#set tm = "fpu_test_input_flush_fle_1"
#set tm = "fpu_test_input_flush_flog_1"
#set tm = "fpu_test_input_flush_flt_1"
#set tm = "fpu_test_input_flush_fmadd_1"
#set tm = "fpu_test_input_flush_fmax_1"
#set tm = "fpu_test_input_flush_fmin_1"
#set tm = "fpu_test_input_flush_fmnadd_1"
#set tm = "fpu_test_input_flush_fmnsub_1"
#set tm = "fpu_test_input_flush_fmsub_1"
#set tm = "fpu_test_input_flush_fmul_1"
#set tm = "fpu_test_input_flush_fne_1"
#set tm = "fpu_test_input_flush_fsqrt_1"
#set tm = "fpu_test_input_flush_fsub_1"
#set tm = "fpu_test_madd_1"
#set tm = "fpu_test_mnadd_1"
#set tm = "fpu_test_mnsub_1"
#set tm = "fpu_test_msub_1"
#set tm = "fpu_test_mul_1"
#set tm = "fpu_test_mulh_1"
#set tm = "fpu_test_mulh_su_1"
#set tm = "fpu_test_mulh_u_1"
#set tm = "fpu_test_mul_su_1"
#set tm = "fpu_test_mul_u_1"
#set tm = "fpu_test_nonpipeline_sm_invld_1"
#set tm = "fpu_test_nonpipeline_sm_vld_1"
#set tm = "fpu_test_output_flush_fadd_1"
#set tm = "fpu_test_output_flush_fdiv_1"
#set tm = "fpu_test_output_flush_fexp_1"
#set tm = "fpu_test_output_flush_flog_1"
#set tm = "fpu_test_output_flush_fmadd_1"
#set tm = "fpu_test_output_flush_fmnadd_1"
#set tm = "fpu_test_output_flush_fmnsub_1"
#set tm = "fpu_test_output_flush_fmsub_1"
#set tm = "fpu_test_output_flush_fmul_1"
#set tm = "fpu_test_output_flush_fsqrt_1"
#set tm = "fpu_test_output_flush_fsub_1"
#set tm = "fpu_test_pipeline_arth_1"
#set tm = "fpu_test_pipeline_arth_cmpcvt_1"
#set tm = "fpu_test_pipeline_cmpcvt_1"
#set tm = "fpu_test_rem_s_1"
#set tm = "fpu_test_rem_u_1"
#set tm = "fpu_test_rst_arth_1"
#set tm = "fpu_test_rst_cmpcvt_1"
#set tm = "fpu_test_rst_init_1"
#set tm = "fpu_test_rst_init_error_o_1"
#set tm = "fpu_test_rst_sm_1"
#set tm = "fpu_test_stall_arth_1"
#set tm = "fpu_test_stall_cmpcvt_1"
#set tm = "fpu_test_stall_rand_1"
#set tm = "fpu_test_stall_sm_1"
#set tm = "fpu_test_sub_1"
#set tm = "fpu_test_sub_u_1"


set tmp_dir = "$tm"

echo "DEBUG $tmp_dir"

if (! -d $tmp_dir) then
  mkdir $tmp_dir
else 
  rm -rf $tmp_dir
  mkdir $tmp_dir
endif

cd $tmp_dir/

cp -f ../${log}/${tmp_dir}/tfv_in_file .
cp -f ../${log}/${tmp_dir}/tfv_out_file .
######################################################################
# Step 3
######################################################################
cp -f ../${log}/${tmp_dir}/${tm}.log .

../split_tfv_in.py tfv_in_file

cd -

echo "FINISH GENERATE"
