//====================================================================================================
//[1] Check reset initialization outputs of FPU block
//====================================================================================================
	property rst_init(rst_w, sig_w, value, lat);
		@(posedge clk)
			((rst_w) |-> ##(lat) (sig_w == value));
	endproperty


	SVA_RST_INIT_VALID_O:
	assert property(rst_init(.rst_w(rst), .sig_w(valid_o), .value(0), .lat(1)))
	else $error("SVA_RST_INIT_VALID_O", "valid_o is not reset");

	SVA_RST_INIT_READY_O:
	assert property(rst_init(.rst_w(rst), .sig_w(ready_o), .value(0), .lat(1)))
	else $error("SVA_RST_INIT_READY_O, ready_o is not reset");

	SVA_RST_INIT_RESULT_O:
	assert property(rst_init(.rst_w(rst), .sig_w(result_o), .value(0), .lat(1)))
	else $error("SVA_RST_INIT_RESULT_O, result_o is not reset");

	SVA_RST_INIT_FFLAGS_O:
	assert property(rst_init(.rst_w(rst), .sig_w(fflags_o), .value(0), .lat(1)))
	else $error("SVA_RST_INIT_FFLAGS_O, fflags_o is not reset");

	SVA_RST_INIT_IFLAGS_O:
	assert property(rst_init(.rst_w(rst), .sig_w(iflags_o), .value(0), .lat(1)))
	else $error("SVA_RST_INIT_IFLAGS_O, iflags_o is not reset");

	SVA_RST_INIT_ERROR_O:
	assert property(rst_init(.rst_w(rst), .sig_w(error_o), .value(0), .lat(1)))
	else $error("SVA_RST_INIT_ERROR_O, error_o is not reset");

	SVA_RST_INIT_USER_O:
	assert property(rst_init(.rst_w(rst), .sig_w(user_o), .value(0), .lat(1)))
	else $error("SVA_RST_INIT_USER_O, user_o is not reset");


//====================================================================================================
//[2] Check Reset flush pipeline stage of each subpipeline for each op
//====================================================================================================
	property flush_pipe(rst_w, op_w, vldi_w, rdyo_w, vldo_w, op);
		@(posedge clk)
		((op_w == op) && vldi_w && rdyo_w) |-> ##4
		 (($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4)) ? ((user_o == $past(user_i, 4)) ? !vldo_w : 1) : 1);
	endproperty

//================================================
	property flush_pipe_fdiv(rst_w, stll_w, op_w, op_a, op_b, vldi_w, rdyo_w, vldo_w);
		@(posedge clk)
		((op_w == `FDIV) && vldi_w && rdyo_w) |-> ##16
    (($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4) ||
			$past(rst_w,  5) || $past(rst_w,  6) || $past(rst_w,  7) || $past(rst_w,  8) ||
			$past(rst_w,  9) || $past(rst_w, 10) || $past(rst_w, 11) || $past(rst_w, 12) ||
			//$past(rst_w, 13) || $past(rst_w, 14) || $past(rst_w, 15) || $past(rst_w, 16)) ? ((user_o == $past(user_i, 16)) ? !vldo_w : 1) : 1);
			$past(rst_w, 13) || $past(rst_w, 14) || $past(rst_w, 15) || $past(rst_w, 16) || $past(rst_w, 17)) ? ((user_o == $past(user_i, 17)) ? !vldo_w : 1) : 1);
	endproperty


//================================================
	property flush_pipe_fsqrt(rst_w, stll_w, op_w, op_a, vldi_w, rdyo_w, vldo_w);
		@(posedge clk)
		((op_w == `FSQRT) && vldi_w && rdyo_w) |-> ##16
    (($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4) ||
			$past(rst_w,  5) || $past(rst_w,  6) || $past(rst_w,  7) || $past(rst_w,  8) ||
			$past(rst_w,  9) || $past(rst_w, 10) || $past(rst_w, 11) || $past(rst_w, 12) ||
			//$past(rst_w, 13) || $past(rst_w, 14) || $past(rst_w, 15) || $past(rst_w, 16)) ? ((user_o == $past(user_i, 16)) ? !vldo_w : 1) : 1);
			$past(rst_w, 13) || $past(rst_w, 14) || $past(rst_w, 15) || $past(rst_w, 16) || $past(rst_w, 17)) ? ((user_o == $past(user_i, 17)) ? !vldo_w : 1) : 1);
	endproperty

	//property flush_pipe_fsqrt_normal(rst_w, stll_w, op_w, op_a, vldi_w, rdyo_w, vldo_w);
	//	@(posedge clk)
	//	(((op_w == `FSQRT) && vldi_w && rdyo_w) &&
	//	 ((op_a >= 32'h0080_0000) && (op_a <= 32'h7F7F_FFFF)))
	//	|-> ##16
  //  (($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4) ||
	//		$past(rst_w,  5) || $past(rst_w,  6) || $past(rst_w,  7) || $past(rst_w,  8) ||
	//		$past(rst_w,  9) || $past(rst_w, 10) || $past(rst_w, 11) || $past(rst_w, 12) ||
	//		$past(rst_w, 13) || $past(rst_w, 14) || $past(rst_w, 15) || $past(rst_w, 16)) ? ((user_o == $past(user_i, 16)) ? !vldo_w : 1) : 1);
	//endproperty

	//property flush_pipe_fsqrt_nocalc(rst_w, stll_w, op_w, op_a, vldi_w, rdyo_w, vldo_w);
	//	@(posedge clk)
	//	(((op_w == `FSQRT) && vldi_w && rdyo_w) &&
	//	 !((op_a >= 32'h0080_0000) && (op_a <= 32'h7F7F_FFFF)))
	//	|-> ##4
	//	(($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4)) ? ((user_o == $past(user_i, 4)) ? !vldo_w : 1) : 1);
	//endproperty

//================================================
	property flush_pipe_fexp(rst_w, stll_w, op_w, op_a, vldi_w, rdyo_w, vldo_w);
		@(posedge clk)
		((op_w == `FEXP) && vldi_w && rdyo_w) |-> ##30
    (($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4) ||
			$past(rst_w,  5) || $past(rst_w,  6) || $past(rst_w,  7) || $past(rst_w,  8) ||
			$past(rst_w,  9) || $past(rst_w, 10) || $past(rst_w, 11) || $past(rst_w, 12) ||
			$past(rst_w, 13) || $past(rst_w, 14) || $past(rst_w, 15) || $past(rst_w, 16) ||
			$past(rst_w, 17) || $past(rst_w, 18) || $past(rst_w, 19) || $past(rst_w, 20) ||
			$past(rst_w, 21) || $past(rst_w, 22) || $past(rst_w, 23) || $past(rst_w, 24) ||
			$past(rst_w, 25) || $past(rst_w, 26) || $past(rst_w, 27) || $past(rst_w, 28) ||
			//$past(rst_w, 29) || $past(rst_w, 30)) ? ((user_o == $past(user_i, 30)) ? !vldo_w : 1) : 1);
			$past(rst_w, 29) || $past(rst_w, 30) || $past(rst_w, 31)) ? ((user_o == $past(user_i, 31)) ? !vldo_w : 1) : 1);
	endproperty

	//property flush_pipe_fexp_normal(rst_w, stll_w, op_w, op_a, vldi_w, rdyo_w, vldo_w);
	//	@(posedge clk)
	//	(((op_w == `FEXP) && vldi_w && rdyo_w) &&
	//	 (((op_a >= 32'h0080_0000) && (op_a <= 32'h7F7F_FFFF)) || ((op_a >= 32'h8080_0000) && (op_a <= 32'hFF7F_FFFF))))
	//	|-> ##30
  //  (($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4) ||
	//		$past(rst_w,  5) || $past(rst_w,  6) || $past(rst_w,  7) || $past(rst_w,  8) ||
	//		$past(rst_w,  9) || $past(rst_w, 10) || $past(rst_w, 11) || $past(rst_w, 12) ||
	//		$past(rst_w, 13) || $past(rst_w, 14) || $past(rst_w, 15) || $past(rst_w, 16) ||
	//		$past(rst_w, 17) || $past(rst_w, 18) || $past(rst_w, 19) || $past(rst_w, 20) ||
	//		$past(rst_w, 21) || $past(rst_w, 22) || $past(rst_w, 23) || $past(rst_w, 24) ||
	//		$past(rst_w, 25) || $past(rst_w, 26) || $past(rst_w, 27) || $past(rst_w, 28) ||
	//		$past(rst_w, 29) || $past(rst_w, 30)) ? ((user_o == $past(user_i, 30)) ? !vldo_w : 1) : 1);
	//endproperty

	//property flush_pipe_fexp_nocalc(rst_w, stll_w, op_w, op_a, vldi_w, rdyo_w, vldo_w);
	//	@(posedge clk)
	//	(((op_w == `FEXP) && vldi_w && rdyo_w) &&
	//	 !(((op_a >= 32'h0080_0000) && (op_a <= 32'h7F7F_FFFF)) || ((op_a >= 32'h8080_0000) && (op_a <= 32'hFF7F_FFFF))))
	//	|-> ##4
	//	(($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4)) ? ((user_o == $past(user_i, 4)) ? !vldo_w : 1) : 1);
	//endproperty

//================================================
	property flush_pipe_flog(rst_w, stll_w, op_w, op_a, vldi_w, rdyo_w, vldo_w);
		@(posedge clk)
		((op_w == `FLOG) && vldi_w && rdyo_w) |-> ##38
    (($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4) ||
			$past(rst_w,  5) || $past(rst_w,  6) || $past(rst_w,  7) || $past(rst_w,  8) ||
			$past(rst_w,  9) || $past(rst_w, 10) || $past(rst_w, 11) || $past(rst_w, 12) ||
			$past(rst_w, 13) || $past(rst_w, 14) || $past(rst_w, 15) || $past(rst_w, 16) ||
			$past(rst_w, 17) || $past(rst_w, 18) || $past(rst_w, 19) || $past(rst_w, 20) ||
			$past(rst_w, 21) || $past(rst_w, 22) || $past(rst_w, 23) || $past(rst_w, 24) ||
			$past(rst_w, 25) || $past(rst_w, 26) || $past(rst_w, 27) || $past(rst_w, 28) ||
			$past(rst_w, 29) || $past(rst_w, 30) || $past(rst_w, 31) || $past(rst_w, 32) ||
			$past(rst_w, 33) || $past(rst_w, 34) || $past(rst_w, 35) || $past(rst_w, 36) ||
			//$past(rst_w, 37) || $past(rst_w, 38)) ? ((user_o == $past(user_i, 38)) ? !vldo_w : 1) : 1);
			$past(rst_w, 37) || $past(rst_w, 38) || $past(rst_w, 39)) ? ((user_o == $past(user_i, 39)) ? !vldo_w : 1) : 1);
	endproperty

	//property flush_pipe_flog_normal(rst_w, stll_w, op_w, op_a, vldi_w, rdyo_w, vldo_w);
	//	@(posedge clk)
	//	(((op_w == `FLOG) && vldi_w && rdyo_w) &&
	//	 ((op_a >= 32'h0080_0000) && (op_a <= 32'h7F7F_FFFF)))
	//	|-> ##38
  //  (($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4) ||
	//		$past(rst_w,  5) || $past(rst_w,  6) || $past(rst_w,  7) || $past(rst_w,  8) ||
	//		$past(rst_w,  9) || $past(rst_w, 10) || $past(rst_w, 11) || $past(rst_w, 12) ||
	//		$past(rst_w, 13) || $past(rst_w, 14) || $past(rst_w, 15) || $past(rst_w, 16) ||
	//		$past(rst_w, 17) || $past(rst_w, 18) || $past(rst_w, 19) || $past(rst_w, 20) ||
	//		$past(rst_w, 21) || $past(rst_w, 22) || $past(rst_w, 23) || $past(rst_w, 24) ||
	//		$past(rst_w, 25) || $past(rst_w, 26) || $past(rst_w, 27) || $past(rst_w, 28) ||
	//		$past(rst_w, 29) || $past(rst_w, 30) || $past(rst_w, 31) || $past(rst_w, 32) ||
	//		$past(rst_w, 33) || $past(rst_w, 34) || $past(rst_w, 35) || $past(rst_w, 36) ||
	//		$past(rst_w, 37) || $past(rst_w, 38)) ? ((user_o == $past(user_i, 38)) ? !vldo_w : 1) : 1);
	//endproperty

	//property flush_pipe_flog_nocalc(rst_w, stll_w, op_w, op_a, vldi_w, rdyo_w, vldo_w);
	//	@(posedge clk)
	//	(((op_w == `FLOG) && vldi_w && rdyo_w) &&
	//	 !((op_a >= 32'h0080_0000) && (op_a <= 32'h7F7F_FFFF)))
	//	|-> ##4
	//	(($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4)) ? ((user_o == $past(user_i, 4)) ? !vldo_w : 1) : 1);
	//endproperty

//================================================
	property flush_pipe_div(rst_w, stll_w, op_w, op_a, op_b, vldi_w, rdyo_w, vldo_w);
		@(posedge clk)
		((op_w == `DIV_S) && vldi_w && rdyo_w) |-> ##18
    (($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4) ||
			$past(rst_w,  5) || $past(rst_w,  6) || $past(rst_w,  7) || $past(rst_w,  8) ||
			$past(rst_w,  9) || $past(rst_w, 10) || $past(rst_w, 11) || $past(rst_w, 12) ||
			$past(rst_w, 13) || $past(rst_w, 14) || $past(rst_w, 15) || $past(rst_w, 16) ||
			//$past(rst_w, 17) || $past(rst_w, 18)) ? ((user_o == $past(user_i, 18)) ? !vldo_w : 1) : 1);
			$past(rst_w, 17) || $past(rst_w, 18) || $past(rst_w, 19)) ? ((user_o == $past(user_i, 19)) ? !vldo_w : 1) : 1);
	endproperty

	//property flush_pipe_div_normal(rst_w, stll_w, op_w, op_a, op_b, vldi_w, rdyo_w, vldo_w);
	//	@(posedge clk)
	//	(((op_w == `DIV_S) && vldi_w && rdyo_w) &&
	//	 !(((op_a == 32'h8000_0000) && (op_b == 32'hFFFF_FFFF)) || (op_b == 32'h0000_0000)))
	//	|-> ##18
  //  (($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4) ||
	//		$past(rst_w,  5) || $past(rst_w,  6) || $past(rst_w,  7) || $past(rst_w,  8) ||
	//		$past(rst_w,  9) || $past(rst_w, 10) || $past(rst_w, 11) || $past(rst_w, 12) ||
	//		$past(rst_w, 13) || $past(rst_w, 14) || $past(rst_w, 15) || $past(rst_w, 16) ||
	//		$past(rst_w, 17) || $past(rst_w, 18)) ? ((user_o == $past(user_i, 18)) ? !vldo_w : 1) : 1);
	//endproperty

	//property flush_pipe_div_nocalc(rst_w, stll_w, op_w, op_a, op_b, vldi_w, rdyo_w, vldo_w);
	//	@(posedge clk)
	//	(((op_w == `DIV_S) && vldi_w && rdyo_w) &&
	//	 (((op_a == 32'h8000_0000) && (op_b == 32'hFFFF_FFFF)) || (op_b == 32'h0000_0000)))
	//	|-> ##4
	//	(($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4)) ? ((user_o == $past(user_i, 4)) ? !vldo_w : 1) : 1);
	//endproperty

//================================================
	property flush_pipe_divu(rst_w, stll_w, op_w, op_a, op_b, vldi_w, rdyo_w, vldo_w);
		@(posedge clk)
		((op_w == `DIV_U) && vldi_w && rdyo_w) |-> ##18
    (($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4) ||
			$past(rst_w,  5) || $past(rst_w,  6) || $past(rst_w,  7) || $past(rst_w,  8) ||
			$past(rst_w,  9) || $past(rst_w, 10) || $past(rst_w, 11) || $past(rst_w, 12) ||
			$past(rst_w, 13) || $past(rst_w, 14) || $past(rst_w, 15) || $past(rst_w, 16) ||
			//$past(rst_w, 17) || $past(rst_w, 18)) ? ((user_o == $past(user_i, 18)) ? !vldo_w : 1) : 1);
			$past(rst_w, 17) || $past(rst_w, 18) || $past(rst_w, 19)) ? ((user_o == $past(user_i, 19)) ? !vldo_w : 1) : 1);
	endproperty

	//property flush_pipe_divu_normal(rst_w, stll_w, op_w, op_a, op_b, vldi_w, rdyo_w, vldo_w);
	//	@(posedge clk)
	//	(((op_w == `DIV_U) && vldi_w && rdyo_w) &&
	//	 !(op_b == 32'h0000_0000))
	//	|-> ##18
  //  (($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4) ||
	//		$past(rst_w,  5) || $past(rst_w,  6) || $past(rst_w,  7) || $past(rst_w,  8) ||
	//		$past(rst_w,  9) || $past(rst_w, 10) || $past(rst_w, 11) || $past(rst_w, 12) ||
	//		$past(rst_w, 13) || $past(rst_w, 14) || $past(rst_w, 15) || $past(rst_w, 16) ||
	//		$past(rst_w, 17) || $past(rst_w, 18)) ? ((user_o == $past(user_i, 18)) ? !vldo_w : 1) : 1);
	//endproperty

	//property flush_pipe_divu_nocalc(rst_w, stll_w, op_w, op_a, op_b, vldi_w, rdyo_w, vldo_w);
	//	@(posedge clk)
	//	(((op_w == `DIV_U) && vldi_w && rdyo_w) &&
	//	 (op_b == 32'h0000_0000))
	//	|-> ##4
	//	(($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4)) ? ((user_o == $past(user_i, 4)) ? !vldo_w : 1) : 1);
	//endproperty

//================================================
	property flush_pipe_rem(rst_w, stll_w, op_w, op_a, op_b, vldi_w, rdyo_w, vldo_w);
		@(posedge clk)
		//((op_w == `REM_S) && vldi_w && rdyo_w) |-> ##18
		((op_w == `REM_S) && vldi_w && rdyo_w) |-> ##19
    (($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4) ||
			$past(rst_w,  5) || $past(rst_w,  6) || $past(rst_w,  7) || $past(rst_w,  8) ||
			$past(rst_w,  9) || $past(rst_w, 10) || $past(rst_w, 11) || $past(rst_w, 12) ||
			$past(rst_w, 13) || $past(rst_w, 14) || $past(rst_w, 15) || $past(rst_w, 16) ||
			//$past(rst_w, 17) || $past(rst_w, 18)) ? ((user_o == $past(user_i, 18)) ? !vldo_w : 1) : 1);
			//$past(rst_w, 17) || $past(rst_w, 18) || $past(rst_w, 19)) ? ((user_o == $past(user_i, 19)) ? !vldo_w : 1) : 1);
			$past(rst_w, 17) || $past(rst_w, 18) || $past(rst_w, 19) || $past(rst_w, 20)) ? ((user_o == $past(user_i, 20)) ? !vldo_w : 1) : 1);
	endproperty

	//property flush_pipe_rem_normal(rst_w, stll_w, op_w, op_a, op_b, vldi_w, rdyo_w, vldo_w);
	//	@(posedge clk)
	//	(((op_w == `REM_S) && vldi_w && rdyo_w) &&
	//	 !(((op_a == 32'h8000_0000) && (op_b == 32'hFFFF_FFFF)) || (op_b == 32'h0000_0000)))
	//	|-> ##18
  //  (($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4) ||
	//		$past(rst_w,  5) || $past(rst_w,  6) || $past(rst_w,  7) || $past(rst_w,  8) ||
	//		$past(rst_w,  9) || $past(rst_w, 10) || $past(rst_w, 11) || $past(rst_w, 12) ||
	//		$past(rst_w, 13) || $past(rst_w, 14) || $past(rst_w, 15) || $past(rst_w, 16) ||
	//		$past(rst_w, 17) || $past(rst_w, 18)) ? ((user_o == $past(user_i, 18)) ? !vldo_w : 1) : 1);
	//endproperty

	//property flush_pipe_rem_nocalc(rst_w, stll_w, op_w, op_a, op_b, vldi_w, rdyo_w, vldo_w);
	//	@(posedge clk)
	//	(((op_w == `REM_S) && vldi_w && rdyo_w) &&
	//	 (((op_a == 32'h8000_0000) && (op_b == 32'hFFFF_FFFF)) || (op_b == 32'h0000_0000)))
	//	|-> ##4
	//	(($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4)) ? ((user_o == $past(user_i, 4)) ? !vldo_w : 1) : 1);
	//endproperty

//================================================
	property flush_pipe_remu(rst_w, stll_w, op_w, op_a, op_b, vldi_w, rdyo_w, vldo_w);
		@(posedge clk)
		//((op_w == `REM_U) && vldi_w && rdyo_w) |-> ##18
		((op_w == `REM_U) && vldi_w && rdyo_w) |-> ##19
    (($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4) ||
			$past(rst_w,  5) || $past(rst_w,  6) || $past(rst_w,  7) || $past(rst_w,  8) ||
			$past(rst_w,  9) || $past(rst_w, 10) || $past(rst_w, 11) || $past(rst_w, 12) ||
			$past(rst_w, 13) || $past(rst_w, 14) || $past(rst_w, 15) || $past(rst_w, 16) ||
			// $past(rst_w, 17) || $past(rst_w, 18)) ? ((user_o == $past(user_i, 18)) ? !vldo_w : 1) : 1);
			//$past(rst_w, 17) || $past(rst_w, 18) || $past(rst_w, 19)) ? ((user_o == $past(user_i, 19)) ? !vldo_w : 1) : 1);
			$past(rst_w, 17) || $past(rst_w, 18) || $past(rst_w, 19) || $past(rst_w, 20)) ? ((user_o == $past(user_i, 20)) ? !vldo_w : 1) : 1);
	endproperty

	//property flush_pipe_remu_normal(rst_w, stll_w, op_w, op_a, op_b, vldi_w, rdyo_w, vldo_w);
	//	@(posedge clk)
	//	(((op_w == `REM_U) && vldi_w && rdyo_w) &&
	//	 !(op_b == 32'h0000_0000))
	//	|-> ##18
  //  (($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4) ||
	//		$past(rst_w,  5) || $past(rst_w,  6) || $past(rst_w,  7) || $past(rst_w,  8) ||
	//		$past(rst_w,  9) || $past(rst_w, 10) || $past(rst_w, 11) || $past(rst_w, 12) ||
	//		$past(rst_w, 13) || $past(rst_w, 14) || $past(rst_w, 15) || $past(rst_w, 16) ||
	//		$past(rst_w, 17) || $past(rst_w, 18)) ? ((user_o == $past(user_i, 18)) ? !vldo_w : 1) : 1);
	//endproperty

	//property flush_pipe_remu_nocalc(rst_w, stll_w, op_w, op_a, op_b, vldi_w, rdyo_w, vldo_w);
	//	@(posedge clk)
	//	(((op_w == `REM_U) && vldi_w && rdyo_w) &&
	//	 (op_b == 32'h0000_0000))
	//	|-> ##4
	//	(($past(rst_w,  1) || $past(rst_w,  2) || $past(rst_w,  3) || $past(rst_w,  4)) ? ((user_o == $past(user_i, 4)) ? !vldo_w : 1) : 1);
	//endproperty

`ifdef ENV_ARITH_EN
	SVA_RST_FLUSH_ARITH_FADD:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`FADD)))
	else $error("SVA_RST_FLUSH_ARITH_FADD, valid_o is not reset");

	SVA_RST_FLUSH_ARITH_FSUB:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`FSUB)))
	else $error("SVA_RST_FLUSH_ARITH_FSUB, valid_o is not reset");

	SVA_RST_FLUSH_ARITH_FMUL:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`FMUL)))
	else $error("SVA_RST_FLUSH_ARITH_FMUL, valid_o is not reset");

	SVA_RST_FLUSH_ARITH_FMADD:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`FMADD)))
	else $error("SVA_RST_FLUSH_ARITH_FMADD, valid_o is not reset");

	SVA_RST_FLUSH_ARITH_FMSUB:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`FMSUB)))
	else $error("SVA_RST_FLUSH_ARITH_FMSUB, valid_o is not reset");

	SVA_RST_FLUSH_ARITH_FMNADD:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`FMNADD)))
	else $error("SVA_RST_FLUSH_ARITH_FMNADD, valid_o is not reset");

	SVA_RST_FLUSH_ARITH_FMNSUB:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`FMNSUB)))
	else $error("SVA_RST_FLUSH_ARITH_FMNSUB, valid_o is not reset");

	SVA_RST_FLUSH_ARITH_ADD:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`ADD)))
	else $error("SVA_RST_FLUSH_ARITH_ADD, valid_o is not reset");

	SVA_RST_FLUSH_ARITH_SUB:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`SUB)))
	else $error("SVA_RST_FLUSH_ARITH_SUB, valid_o is not reset");

	SVA_RST_FLUSH_ARITH_MADD:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`MADD)))
	else $error("SVA_RST_FLUSH_ARITH_MADD, valid_o is not reset");

	SVA_RST_FLUSH_ARITH_MNADD:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`MNADD)))
	else $error("SVA_RST_FLUSH_ARITH_MNADD, valid_o is not reset");

	SVA_RST_FLUSH_ARITH_MSUB:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`MSUB)))
	else $error("SVA_RST_FLUSH_ARITH_MSUB, valid_o is not reset");

	SVA_RST_FLUSH_ARITH_MNSUB:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`MNSUB)))
	else $error("SVA_RST_FLUSH_ARITH_MNSUB, valid_o is not reset");

	SVA_RST_FLUSH_ARITH_MUL:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`MUL)))
	else $error("SVA_RST_FLUSH_ARITH_MUL, valid_o is not reset");

	SVA_RST_FLUSH_ARITH_MULH:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`MULH)))
	else $error("SVA_RST_FLUSH_ARITH_MULH, valid_o is not reset");

	SVA_RST_FLUSH_ARITH_ADD_U:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`ADD_U)))
	else $error("SVA_RST_FLUSH_ARITH_ADD_U, valid_o is not reset");

	SVA_RST_FLUSH_ARITH_SUB_U:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`SUB_U)))
	else $error("SVA_RST_FLUSH_ARITH_SUB_U, valid_o is not reset");

	SVA_RST_FLUSH_ARITH_MUL_U:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`MUL_U)))
	else $error("SVA_RST_FLUSH_ARITH_MUL_U, valid_o is not reset");

	SVA_RST_FLUSH_ARITH_MULH_U:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`MULH_U)))
	else $error("SVA_RST_FLUSH_ARITH_MULH_U, valid_o is not reset");

	SVA_RST_FLUSH_ARITH_MUL_SU:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`MUL_SU)))
	else $error("SVA_RST_FLUSH_ARITH_MUL_SU, valid_o is not reset");

	SVA_RST_FLUSH_ARITH_MULH_SU:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`MULH_SU)))
	else $error("SVA_RST_FLUSH_ARITH_MULH_SU, valid_o is not reset");

`endif

`ifdef ENV_CMPCNV_EN
	SVA_RST_FLUSH_CMP_CVT_FMIN:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`FMIN)))
	else $error("SVA_RST_FLUSH_CMP_CVT_FMIN, valid_o is not reset");

	SVA_RST_FLUSH_CMP_CVT_FMAX:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`FMAX)))
	else $error("SVA_RST_FLUSH_CMP_CVT_FMAX, valid_o is not reset");

	SVA_RST_FLUSH_CMP_CVT_FEQ:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`FEQ)))
	else $error("SVA_RST_FLUSH_CMP_CVT_FEQ, valid_o is not reset");

	SVA_RST_FLUSH_CMP_CVT_FLT:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`FLT)))
	else $error("SVA_RST_FLUSH_CMP_CVT_FLT, valid_o is not reset");

	SVA_RST_FLUSH_CMP_CVT_FLE:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`FLE)))
	else $error("SVA_RST_FLUSH_CMP_CVT_FLE, valid_o is not reset");

	SVA_RST_FLUSH_CMP_CVT_FNE:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`FNE)))
	else $error("SVA_RST_FLUSH_CMP_CVT_FNE, valid_o is not reset");

	SVA_RST_FLUSH_CMP_CVT_FCVT_W_S:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`FCVT_W_S)))
	else $error("SVA_RST_FLUSH_CMP_CVT_FCVT_W_S, valid_o is not reset");

	SVA_RST_FLUSH_CMP_CVT_FCVT_WU_S:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`FCVT_WU_S)))
	else $error("SVA_RST_FLUSH_CMP_CVT_FCVT_WU_S, valid_o is not reset");

	SVA_RST_FLUSH_CMP_CVT_FCVT_S_W:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`FCVT_S_W)))
	else $error("SVA_RST_FLUSH_CMP_CVT_FCVT_S_W, valid_o is not reset");

	SVA_RST_FLUSH_CMP_CVT_FCVT_S_WU:
	assert property(flush_pipe(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o), .op(`FCVT_S_WU)))
	else $error("SVA_RST_FLUSH_CMP_CVT_FCVT_S_WU, valid_o is not reset");

`endif

`ifdef ENV_SPMATH_EN
	SVA_RST_FLUSH_SM_FDIV:
	assert property(flush_pipe_fdiv(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
	else $error("SVA_RST_FLUSH_SM_FDIV, valid_o is not reset");

	SVA_RST_FLUSH_SM_FSQRT:
	assert property(flush_pipe_fsqrt(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
	else $error("SVA_RST_FLUSH_SM_FSQRT, valid_o is not reset");

	//SVA_RST_FLUSH_SM_FDIV_NORMAL:
	//assert property(flush_pipe_fdiv_normal(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
	//else $error("SVA_RST_FLUSH_SM_FDIV_NORMAL, valid_o is not reset");

	//SVA_RST_FLUSH_SM_FDIV_NOCALC:
	//assert property(flush_pipe_fdiv_nocalc(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
	//else $error("SVA_RST_FLUSH_SM_FDIV_NOCALC, valid_o is not reset");

	//SVA_RST_FLUSH_SM_FSQRT_NORMAL:
	//assert property(flush_pipe_fsqrt_normal(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
	//else $error("SVA_RST_FLUSH_SM_FSQRT_NORMAL, valid_o is not reset");

	//SVA_RST_FLUSH_SM_FSQRT_NOCALC:
	//assert property(flush_pipe_fsqrt_nocalc(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
	//else $error("SVA_RST_FLUSH_SM_FSQRT_NOCALC, valid_o is not reset");

	`ifdef ENV_EXPLOG_EN
		SVA_RST_FLUSH_SM_FEXP:
		assert property(flush_pipe_fexp(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
		else $error("SVA_RST_FLUSH_SM_FEXP, valid_o is not reset");

		SVA_RST_FLUSH_SM_FLOG:
		assert property(flush_pipe_flog(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
		else $error("SVA_RST_FLUSH_SM_FLOG, valid_o is not reset");

		//SVA_RST_FLUSH_SM_FEXP_NORMAL:
		//assert property(flush_pipe_fexp_normal(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
		//else $error("SVA_RST_FLUSH_SM_FEXP_NORMAL, valid_o is not reset");

		//SVA_RST_FLUSH_SM_FEXP_NOCALC:
		//assert property(flush_pipe_fexp_nocalc(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
		//else $error("SVA_RST_FLUSH_SM_FEXP_NOCALC, valid_o is not reset");

		//SVA_RST_FLUSH_SM_FLOG_NORMAL:
		//assert property(flush_pipe_flog_normal(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
		//else $error("SVA_RST_FLUSH_SM_FLOG_NORMAL, valid_o is not reset");

		//SVA_RST_FLUSH_SM_FLOG_NOCALC:
		//assert property(flush_pipe_flog_nocalc(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
		//else $error("SVA_RST_FLUSH_SM_FLOG_NOCALC, valid_o is not reset");

	`endif

	SVA_RST_FLUSH_SM_DIV:
	assert property(flush_pipe_div(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
	else $error("SVA_RST_FLUSH_SM_DIV, valid_o is not reset");

	SVA_RST_FLUSH_SM_DIV_U:
	assert property(flush_pipe_divu(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
	else $error("SVA_RST_FLUSH_SM_DIV_U, valid_o is not reset");

	SVA_RST_FLUSH_SM_REM:
	assert property(flush_pipe_rem(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
	else $error("SVA_RST_FLUSH_SM_REM, valid_o is not reset");

	SVA_RST_FLUSH_SM_REM_U:
	assert property(flush_pipe_remu(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
	else $error("SVA_RST_FLUSH_SM_REM_U, valid_o is not reset");

	//SVA_RST_FLUSH_SM_DIV_NORMAL:
	//assert property(flush_pipe_div_normal(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
	//else $error("SVA_RST_FLUSH_SM_DIV_NORMAL, valid_o is not reset");

	//SVA_RST_FLUSH_SM_DIV_NOCALC:
	//assert property(flush_pipe_div_nocalc(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
	//else $error("SVA_RST_FLUSH_SM_DIV_NOCALC, valid_o is not reset");

	//SVA_RST_FLUSH_SM_DIV_U_NORMAL:
	//assert property(flush_pipe_divu_normal(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
	//else $error("SVA_RST_FLUSH_SM_DIV_U_NORMAL, valid_o is not reset");

	//SVA_RST_FLUSH_SM_DIV_U_NOCALC:
	//assert property(flush_pipe_divu_nocalc(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
	//else $error("SVA_RST_FLUSH_SM_DIV_U_NOCALC, valid_o is not reset");

	//SVA_RST_FLUSH_SM_REM_NORMAL:
	//assert property(flush_pipe_rem_normal(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
	//else $error("SVA_RST_FLUSH_SM_REM_NORMAL, valid_o is not reset");

	//SVA_RST_FLUSH_SM_REM_NOCALC:
	//assert property(flush_pipe_rem_nocalc(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
	//else $error("SVA_RST_FLUSH_SM_REM_NOCALC, valid_o is not reset");

	//SVA_RST_FLUSH_SM_REM_U_NORMAL:
	//assert property(flush_pipe_remu_normal(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
	//else $error("SVA_RST_FLUSH_SM_REM_U_NORMAL, valid_o is not reset");

	//SVA_RST_FLUSH_SM_REM_U_NOCALC:
	//assert property(flush_pipe_remu_nocalc(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .vldi_w(valid_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
	//else $error("SVA_RST_FLUSH_SM_REM_U_NOCALC, valid_o is not reset");

`endif


//====================================================================================================
//[3] Check op lat for each function
//====================================================================================================
	property pipe_lat(vldi_w, rdyo_w, op_w, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, op, stt);
		@(posedge clk) disable iff (rst_w)
		(vldi_w && rdyo_w && (op_w == op) && !rst_w && !((rm_i == 3'b101) || (rm_i == 3'b110) || (rm_i == 3'b111)))
		|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0
		(vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w));
	endproperty

//================================================
	property pipe_lat_fdiv(vldi_w, rdyo_w, op_w, op_a, op_b, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
		@(posedge clk) disable iff (rst_w)
		((op_w == `FDIV) && vldi_w && rdyo_w && !rst_w && !((rm_i == 3'b101) || (rm_i == 3'b110) || (rm_i == 3'b111)))
		 //|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->16] ##0 !stll_w [->1] ##0
		 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->17] ##0 !stll_w [->1] ##0
		 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w));
	endproperty

	//property pipe_lat_fdiv_normal(vldi_w, rdyo_w, op_w, op_a, op_b, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
	//	@(posedge clk) disable iff (rst_w)
	//	((((op_w == `FDIV) && vldi_w && rdyo_w && !rst_w) &&
	//		((((op_a >= 32'h0080_0000) && (op_a <= 32'h7F7F_FFFF)) || ((op_a >= 32'h8080_0000) && (op_a <= 32'hFF7F_FFFF))) &&
	//		 (((op_b >= 32'h0080_0000) && (op_b <= 32'h7F7F_FFFF)) || ((op_b >= 32'h8080_0000) && (op_b <= 32'hFF7F_FFFF)))))
	//	 //|-> (!stll_w) [->16] ##1
	//	 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->16] ##0 !stll_w [->1] ##0
	//	 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w)));
	//endproperty

	//property pipe_lat_fdiv_nocalc(vldi_w, rdyo_w, op_w, op_a, op_b, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
	//	@(posedge clk) disable iff (rst_w)
	//	((((op_w == `FDIV) && vldi_w && rdyo_w && !rst_w) &&
	//		!((((op_a >= 32'h0080_0000) && (op_a <= 32'h7F7F_FFFF)) || ((op_a >= 32'h8080_0000) && (op_a <= 32'hFF7F_FFFF))) &&
	//		 (((op_b >= 32'h0080_0000) && (op_b <= 32'h7F7F_FFFF)) || ((op_b >= 32'h8080_0000) && (op_b <= 32'hFF7F_FFFF)))))
	//	 //|-> (!stll_w) [->4] ##1
	//	 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0
	//	 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w)));
	//endproperty

//================================================
	property pipe_lat_fsqrt(vldi_w, rdyo_w, op_w, op_a, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
		@(posedge clk) disable iff (rst_w)
		((op_w == `FSQRT) && vldi_w && rdyo_w && !rst_w && !((rm_i == 3'b101) || (rm_i == 3'b110) || (rm_i == 3'b111)))
		 //|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->16] ##0 !stll_w [->1] ##0
		 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->17] ##0 !stll_w [->1] ##0
		 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w));
	endproperty

	//property pipe_lat_fsqrt_normal(vldi_w, rdyo_w, op_w, op_a, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
	//	@(posedge clk) disable iff (rst_w)
	//	((((op_w == `FSQRT) && vldi_w && rdyo_w && !rst_w) &&
	//		((op_a >= 32'h0080_0000) && (op_a <= 32'h7F7F_FFFF)))
	//	 //|-> (!stll_w) [->16] ##1
	//	 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->16] ##0 !stll_w [->1] ##0
	//	 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w)));
	//endproperty

	//property pipe_lat_fsqrt_nocalc(vldi_w, rdyo_w, op_w, op_a, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
	//	@(posedge clk) disable iff (rst_w)
	//	((((op_w == `FSQRT) && vldi_w && rdyo_w && !rst_w) &&
	//		!((op_a >= 32'h0080_0000) && (op_a <= 32'h7F7F_FFFF)))
	//	 //|-> (!stll_w) [->4] ##1
	//	 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0
	//	 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w)));
	//endproperty

//================================================
	property pipe_lat_fexp(vldi_w, rdyo_w, op_w, op_a, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
		@(posedge clk) disable iff (rst_w)
		((op_w == `FEXP) && vldi_w && rdyo_w && !rst_w && !((rm_i == 3'b101) || (rm_i == 3'b110) || (rm_i == 3'b111)))
		 //|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->30] ##0 !stll_w [->1] ##0
		 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->31] ##0 !stll_w [->1] ##0
		 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w));
	endproperty

	//property pipe_lat_fexp_normal(vldi_w, rdyo_w, op_w, op_a, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
	//	@(posedge clk) disable iff (rst_w)
	//	((((op_w == `FEXP) && vldi_w && rdyo_w && !rst_w) &&
	//		(((op_a >= 32'h0080_0000) && (op_a <= 32'h7F7F_FFFF)) || ((op_a >= 32'h8080_0000) && (op_a <= 32'hFF7F_FFFF))))
	//	 //|-> (!stll_w) [->30] ##1
	//	 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->30] ##0 !stll_w [->1] ##0
	//	 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w)));
	//endproperty

	//property pipe_lat_fexp_nocalc(vldi_w, rdyo_w, op_w, op_a, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
	//	@(posedge clk) disable iff (rst_w)
	//	((((op_w == `FEXP) && vldi_w && rdyo_w && !rst_w) &&
	//		!(((op_a >= 32'h0080_0000) && (op_a <= 32'h7F7F_FFFF)) || ((op_a >= 32'h8080_0000) && (op_a <= 32'hFF7F_FFFF))))
	//	 //|-> (!stll_w) [->4] ##1
	//	 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0
	//	 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w)));
	//endproperty

//================================================
	property pipe_lat_flog(vldi_w, rdyo_w, op_w, op_a, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
		@(posedge clk) disable iff (rst_w)
		((op_w == `FLOG) && vldi_w && rdyo_w && !rst_w && !((rm_i == 3'b101) || (rm_i == 3'b110) || (rm_i == 3'b111)))
		 //|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->38] ##0 !stll_w [->1] ##0
		 //|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->39] ##0 !stll_w [->1] ##0
		 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->51] ##0 !stll_w [->1] ##0
		 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w));
	endproperty

	//property pipe_lat_flog_normal(vldi_w, rdyo_w, op_w, op_a, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
	//	@(posedge clk) disable iff (rst_w)
	//	((((op_w == `FLOG) && vldi_w && rdyo_w && !rst_w) &&
	//		((op_a >= 32'h0080_0000) && (op_a <= 32'h7F7F_FFFF)))
	//	 //|-> (!stll_w) [->38] ##1
	//	 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->38] ##0 !stll_w [->1] ##0
	//	 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w)));
	//endproperty

	//property pipe_lat_flog_nocalc(vldi_w, rdyo_w, op_w, op_a, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
	//	@(posedge clk) disable iff (rst_w)
	//	((((op_w == `FLOG) && vldi_w && rdyo_w && !rst_w) &&
	//		!((op_a >= 32'h0080_0000) && (op_a <= 32'h7F7F_FFFF)))
	//	 //|-> (!stll_w) [->4] ##1
	//	 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0
	//	 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w)));
	//endproperty

//================================================
	property pipe_lat_div(vldi_w, rdyo_w, op_w, op_a, op_b, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
		@(posedge clk) disable iff (rst_w)
		((op_w == `DIV_S) && vldi_w && rdyo_w && !rst_w && !((rm_i == 3'b101) || (rm_i == 3'b110) || (rm_i == 3'b111)))
		 //|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->18] ##0 !stll_w [->1] ##0
		 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->19] ##0 !stll_w [->1] ##0
		 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w));
	endproperty

	//property pipe_lat_div_normal(vldi_w, rdyo_w, op_w, op_a, op_b, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
	//	@(posedge clk) disable iff (rst_w)
	//	((((op_w == `DIV_S) && vldi_w && rdyo_w && !rst_w) &&
	//		!(((op_a == 32'h8000_0000) && (op_b == 32'hFFFF_FFFF)) || (op_b == 32'h0000_0000)))
	//	 //|-> (!stll_w) [->18] ##1
	//	 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->18] ##0 !stll_w [->1] ##0
	//	 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w)));
	//endproperty

	//property pipe_lat_div_nocalc(vldi_w, rdyo_w, op_w, op_a, op_b, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
	//	@(posedge clk) disable iff (rst_w)
	//	((((op_w == `DIV_S) && vldi_w && rdyo_w && !rst_w) &&
	//		(((op_a == 32'h8000_0000) && (op_b == 32'hFFFF_FFFF)) || (op_b == 32'h0000_0000)))
	//	 //|-> (!stll_w) [->4] ##1
	//	 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0  !stll_w [->1] ##0
	//	 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w)));
	//endproperty

//================================================
	property pipe_lat_divu(vldi_w, rdyo_w, op_w, op_a, op_b, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
		@(posedge clk) disable iff (rst_w)
		((op_w == `DIV_U) && vldi_w && rdyo_w && !rst_w && !((rm_i == 3'b101) || (rm_i == 3'b110) || (rm_i == 3'b111)))
		 //|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->18] ##0 !stll_w [->1] ##0
		 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->19] ##0 !stll_w [->1] ##0
		 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w));
	endproperty

	//property pipe_lat_divu_normal(vldi_w, rdyo_w, op_w, op_a, op_b, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
	//	@(posedge clk) disable iff (rst_w)
	//	((((op_w == `DIV_U) && vldi_w && rdyo_w && !rst_w) &&
	//		!(op_b == 32'h0000_0000))
	//	 //|-> (!stll_w) [->18] ##1
	//	 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->18] ##0 !stll_w [->1] ##0
	//	 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w)));
	//endproperty

	//property pipe_lat_divu_nocalc(vldi_w, rdyo_w, op_w, op_a, op_b, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
	//	@(posedge clk) disable iff (rst_w)
	//	((((op_w == `DIV_U) && vldi_w && rdyo_w && !rst_w) &&
	//		(op_b == 32'h0000_0000))
	//	 //|-> (!stll_w) [->4] ##1
	//	 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0
	//	 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w)));
	//endproperty

//================================================
	property pipe_lat_rem(vldi_w, rdyo_w, op_w, op_a, op_b, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
		@(posedge clk) disable iff (rst_w)
		((op_w == `REM_S) && vldi_w && rdyo_w && !rst_w && !((rm_i == 3'b101) || (rm_i == 3'b110) || (rm_i == 3'b111)))
		 //|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->18] ##0 !stll_w [->1] ##0
		 //|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->19] ##0 !stll_w [->1] ##0
		 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->20] ##0 !stll_w [->1] ##0
		 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w));
	endproperty

	//property pipe_lat_rem_normal(vldi_w, rdyo_w, op_w, op_a, op_b, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
	//	@(posedge clk) disable iff (rst_w)
	//	((((op_w == `REM_S) && vldi_w && rdyo_w && !rst_w) &&
	//		!(((op_a == 32'h8000_0000) && (op_b == 32'hFFFF_FFFF)) || (op_b == 32'h0000_0000)))
	//	 //|-> (!stll_w) [->18] ##1
	//	 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->18] ##0 !stll_w [->1] ##0
	//	 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w)));
	//endproperty

	//property pipe_lat_rem_nocalc(vldi_w, rdyo_w, op_w, op_a, op_b, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
	//	@(posedge clk) disable iff (rst_w)
	//	((((op_w == `REM_S) && vldi_w && rdyo_w && !rst_w) &&
	//		(((op_a == 32'h8000_0000) && (op_b == 32'hFFFF_FFFF)) || (op_b == 32'h0000_0000)))
	//	 //|-> (!stll_w) [->4] ##1
	//	 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0
	//	 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w)));
	//endproperty

//================================================
	property pipe_lat_remu(vldi_w, rdyo_w, op_w, op_a, op_b, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
		@(posedge clk) disable iff (rst_w)
		((op_w == `REM_U) && vldi_w && rdyo_w && !rst_w && !((rm_i == 3'b101) || (rm_i == 3'b110) || (rm_i == 3'b111)))
		 //|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->18] ##0 !stll_w [->1] ##0
		 //|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->19] ##0 !stll_w [->1] ##0
		 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->20] ##0 !stll_w [->1] ##0
		 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w));
	endproperty

	//property pipe_lat_remu_normal(vldi_w, rdyo_w, op_w, op_a, op_b, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
	//	@(posedge clk) disable iff (rst_w)
	//	((((op_w == `REM_U) && vldi_w && rdyo_w && !rst_w) &&
	//		!(op_b == 32'h0000_0000))
	//	 //|-> (!stll_w) [->18] ##1
	//	 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->18] ##0 !stll_w [->1] ##0
	//	 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w)));
	//endproperty

	//property pipe_lat_remu_nocalc(vldi_w, rdyo_w, op_w, op_a, op_b, stll_w, vldo_w, usro_w, rslt_w, fflgo_w, iflgo_w, rst_w, stt);
	//	@(posedge clk) disable iff (rst_w)
	//	((((op_w == `REM_U) && vldi_w && rdyo_w && !rst_w) &&
	//		(op_b == 32'h0000_0000))
	//	 //|-> (!stll_w) [->4] ##1
	//	 |=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0
	//	 (vldo_w && !$isunknown(usro_w) && !$isunknown(rslt_w) && !$isunknown(fflgo_w) && !$isunknown(iflgo_w)));
	//endproperty

`ifdef ENV_ARITH_EN
	SVA_LATENCY_ARITH_FADD:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`FADD), .stt(skid_stt)))
	else $error("SVA_LATENCY_ARITH_FADD, valid does not assert or result output is invalid");

	SVA_LATENCY_ARITH_FSUB:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`FSUB), .stt(skid_stt)))
	else $error("SVA_LATENCY_ARITH_FSUB, valid does not assert or result output is invalid");

	SVA_LATENCY_ARITH_FMUL:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`FMUL), .stt(skid_stt)))
	else $error("SVA_LATENCY_ARITH_FMUL, valid does not assert or result output is invalid");

	SVA_LATENCY_ARITH_FMADD:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`FMADD), .stt(skid_stt)))
	else $error("SVA_LATENCY_ARITH_FMADD, valid does not assert or result output is invalid");

	SVA_LATENCY_ARITH_FMSUB:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`FMSUB), .stt(skid_stt)))
	else $error("SVA_LATENCY_ARITH_FMSUB, valid does not assert or result output is invalid");

	SVA_LATENCY_ARITH_FMNADD:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`FMNADD), .stt(skid_stt)))
	else $error("SVA_LATENCY_ARITH_FMNADD, valid does not assert or result output is invalid");

	SVA_LATENCY_ARITH_FMNSUB:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`FMNSUB), .stt(skid_stt)))
	else $error("SVA_LATENCY_ARITH_FMNSUB, valid does not assert or result output is invalid");

	SVA_LATENCY_ARITH_ADD:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`ADD), .stt(skid_stt)))
	else $error("SVA_LATENCY_ARITH_ADD, valid does not assert or result output is invalid");

	SVA_LATENCY_ARITH_SUB:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`SUB), .stt(skid_stt)))
	else $error("SVA_LATENCY_ARITH_SUB, valid does not assert or result output is invalid");

	SVA_LATENCY_ARITH_MADD:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`MADD), .stt(skid_stt)))
	else $error("SVA_LATENCY_ARITH_MADD, valid does not assert or result output is invalid");

	SVA_LATENCY_ARITH_MNADD:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`MNADD), .stt(skid_stt)))
	else $error("SVA_LATENCY_ARITH_MNADD, valid does not assert or result output is invalid");

	SVA_LATENCY_ARITH_MSUB:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`MSUB), .stt(skid_stt)))
	else $error("SVA_LATENCY_ARITH_MSUB, valid does not assert or result output is invalid");

	SVA_LATENCY_ARITH_MNSUB:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`MNSUB), .stt(skid_stt)))
	else $error("SVA_LATENCY_ARITH_MNSUB, valid does not assert or result output is invalid");

	SVA_LATENCY_ARITH_MUL:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`MUL), .stt(skid_stt)))
	else $error("SVA_LATENCY_ARITH_MUL, valid does not assert or result output is invalid");

	SVA_LATENCY_ARITH_MULH:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`MULH), .stt(skid_stt)))
	else $error("SVA_LATENCY_ARITH_MULH, valid does not assert or result output is invalid");

	SVA_LATENCY_ARITH_ADD_U:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`ADD_U), .stt(skid_stt)))
	else $error("SVA_LATENCY_ARITH_ADD_U, valid does not assert or result output is invalid");

	SVA_LATENCY_ARITH_SUB_U:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`SUB_U), .stt(skid_stt)))
	else $error("SVA_LATENCY_ARITH_SUB_U, valid does not assert or result output is invalid");

	SVA_LATENCY_ARITH_MUL_U:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`MUL_U), .stt(skid_stt)))
	else $error("SVA_LATENCY_ARITH_MUL_U, valid does not assert or result output is invalid");

	SVA_LATENCY_ARITH_MULH_U:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`MULH_U), .stt(skid_stt)))
	else $error("SVA_LATENCY_ARITH_MULH_U, valid does not assert or result output is invalid");

	SVA_LATENCY_ARITH_MUL_SU:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`MUL_SU), .stt(skid_stt)))
	else $error("SVA_LATENCY_ARITH_MUL_SU, valid does not assert or result output is invalid");

	SVA_LATENCY_ARITH_MULH_SU:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`MULH_SU), .stt(skid_stt)))
	else $error("SVA_LATENCY_ARITH_MULH_SU, valid does not assert or result output is invalid");

`endif

`ifdef ENV_CMPCNV_EN
	SVA_LATENCY_CMP_CVT_FMIN:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`FMIN), .stt(skid_stt)))
	else $error("SVA_LATENCY_CMP_CVT_FMIN, valid does not assert or result output is invalid");

	SVA_LATENCY_CMP_CVT_FMAX:
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`FMAX), .stt(skid_stt)))
	else $error("SVA_LATENCY_CMP_CVT_FMAX, valid does not assert or result output is invalid");

	SVA_LATENCY_CMP_CVT_FEQ :
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`FEQ), .stt(skid_stt)))
	else $error("SVA_LATENCY_CMP_CVT_FEQ , valid does not assert or result output is invalid");

	SVA_LATENCY_CMP_CVT_FLT :
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`FLT), .stt(skid_stt)))
	else $error("SVA_LATENCY_CMP_CVT_FLT , valid does not assert or result output is invalid");

	SVA_LATENCY_CMP_CVT_FLE :
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`FLE), .stt(skid_stt)))
	else $error("SVA_LATENCY_CMP_CVT_FLE , valid does not assert or result output is invalid");

	SVA_LATENCY_CMP_CVT_FNE :
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`FNE), .stt(skid_stt)))
	else $error("SVA_LATENCY_CMP_CVT_FNE , valid does not assert or result output is invalid");

	SVA_LATENCY_CMP_CVT_FCVT_W_S :
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`FCVT_W_S), .stt(skid_stt)))
	else $error("SVA_LATENCY_CMP_CVT_FCVT_W_S , valid does not assert or result output is invalid");

	SVA_LATENCY_CMP_CVT_FCVT_WU_S :
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`FCVT_WU_S), .stt(skid_stt)))
	else $error("SVA_LATENCY_CMP_CVT_FCVT_WU_S , valid does not assert or result output is invalid");

	SVA_LATENCY_CMP_CVT_FCVT_S_W :
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`FCVT_S_W), .stt(skid_stt)))
	else $error("SVA_LATENCY_CMP_CVT_FCVT_S_W , valid does not assert or result output is invalid");

	SVA_LATENCY_CMP_CVT_FCVT_S_WU :
	assert property(pipe_lat(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .op(`FCVT_S_WU), .stt(skid_stt)))
	else $error("SVA_LATENCY_CMP_CVT_FCVT_S_WU , valid does not assert or result output is invalid");

`endif

`ifdef ENV_SPMATH_EN
	SVA_LATENCY_SM_FDIV:
	assert property(pipe_lat_fdiv(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .stll_w(stall_i),
																			 .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
	else $error("SVA_LATENCY_SM_FDIV, valid does not assert or result output is invalid");

	SVA_LATENCY_SM_FSQRT:
	assert property(pipe_lat_fsqrt(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .stll_w(stall_i),
																				.vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
	else $error("SVA_LATENCY_SM_FSQRT, valid does not assert or result output is invalid");

	//SVA_LATENCY_SM_FDIV_NORMAL:
	//assert property(pipe_lat_fdiv_normal(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .stll_w(stall_i),
	//																		 .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
	//else $error("SVA_LATENCY_SM_FDIV_NORMAL, valid does not assert or result output is invalid");

	//SVA_LATENCY_SM_FDIV_NOCALC:
	//assert property(pipe_lat_fdiv_nocalc(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .stll_w(stall_i),
	//																		 .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
	//else $error("SVA_LATENCY_SM_FDIV_NOCALC, valid does not assert or result output is invalid");

	//SVA_LATENCY_SM_FSQRT_NORMAL:
	//assert property(pipe_lat_fsqrt_normal(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .stll_w(stall_i),
	//																			.vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
	//else $error("SVA_LATENCY_SM_FSQRT_NORMAL, valid does not assert or result output is invalid");

	//SVA_LATENCY_SM_FSQRT_NOCALC:
	//assert property(pipe_lat_fsqrt_nocalc(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .stll_w(stall_i),
	//																			.vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
	//else $error("SVA_LATENCY_SM_FSQRT_NOCALC, valid does not assert or result output is invalid");

	`ifdef ENV_EXPLOG_EN
		SVA_LATENCY_SM_FEXP:
		assert property(pipe_lat_fexp(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .stll_w(stall_i),
																				 .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
		else $error("SVA_LATENCY_SM_FEXP, valid does not assert or result output is invalid");

		SVA_LATENCY_SM_FLOG:
		assert property(pipe_lat_flog(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .stll_w(stall_i),
																				 .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
		else $error("SVA_LATENCY_SM_FLOG, valid does not assert or result output is invalid");

		//SVA_LATENCY_SM_FEXP_NORMAL:
		//assert property(pipe_lat_fexp_normal(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .stll_w(stall_i),
		//																		 .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
		//else $error("SVA_LATENCY_SM_FEXP_NORMAL, valid does not assert or result output is invalid");

		//SVA_LATENCY_SM_FEXP_NOCALC:
		//assert property(pipe_lat_fexp_nocalc(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .stll_w(stall_i),
		//																		 .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
		//else $error("SVA_LATENCY_SM_FEXP_NOCALC, valid does not assert or result output is invalid");

		//SVA_LATENCY_SM_FLOG_NORMAL:
		//assert property(pipe_lat_flog_normal(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .stll_w(stall_i),
		//																		 .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
		//else $error("SVA_LATENCY_SM_FLOG_NORMAL, valid does not assert or result output is invalid");

		//SVA_LATENCY_SM_FLOG_NOCALC:
		//assert property(pipe_lat_flog_nocalc(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .stll_w(stall_i),
		//																		 .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
		//else $error("SVA_LATENCY_SM_FLOG_NOCALC, valid does not assert or result output is invalid");

	`endif

	SVA_LATENCY_SM_DIV:
	assert property(pipe_lat_div(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .stll_w(stall_i),
																			.vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
	else $error("SVA_LATENCY_SM_DIV, valid does not assert or result output is invalid");

	SVA_LATENCY_SM_DIV_U:
	assert property(pipe_lat_divu(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .stll_w(stall_i),
																			 .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
	else $error("SVA_LATENCY_SM_DIV_U, valid does not assert or result output is invalid");

	SVA_LATENCY_SM_REM:
	assert property(pipe_lat_rem(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .stll_w(stall_i),
																			.vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
	else $error("SVA_LATENCY_SM_REM, valid does not assert or result output is invalid");

	SVA_LATENCY_SM_REM_U:
	assert property(pipe_lat_remu(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .stll_w(stall_i),
																			 .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
	else $error("SVA_LATENCY_SM_REM_U, valid does not assert or result output is invalid");

	//SVA_LATENCY_SM_DIV_NORMAL:
	//assert property(pipe_lat_div_normal(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .stll_w(stall_i),
	//																		.vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
	//else $error("SVA_LATENCY_SM_DIV_NORMAL, valid does not assert or result output is invalid");

	//SVA_LATENCY_SM_DIV_NOCALC:
	//assert property(pipe_lat_div_nocalc(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .stll_w(stall_i),
	//																		.vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
	//else $error("SVA_LATENCY_SM_DIV_NOCALC, valid does not assert or result output is invalid");

	//SVA_LATENCY_SM_DIV_U_NORMAL:
	//assert property(pipe_lat_divu_normal(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .stll_w(stall_i),
	//																		 .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
	//else $error("SVA_LATENCY_SM_DIV_U_NORMAL, valid does not assert or result output is invalid");

	//SVA_LATENCY_SM_DIV_U_NOCALC:
	//assert property(pipe_lat_divu_nocalc(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .stll_w(stall_i),
	//																		 .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
	//else $error("SVA_LATENCY_SM_DIV_U_NOCALC, valid does not assert or result output is invalid");

	//SVA_LATENCY_SM_REM_NORMAL:
	//assert property(pipe_lat_rem_normal(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .stll_w(stall_i),
	//																		.vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
	//else $error("SVA_LATENCY_SM_REM_NORMAL, valid does not assert or result output is invalid");

	//SVA_LATENCY_SM_REM_NOCALC:
	//assert property(pipe_lat_rem_nocalc(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .stll_w(stall_i),
	//																		.vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
	//else $error("SVA_LATENCY_SM_REM_NOCALC, valid does not assert or result output is invalid");

	//SVA_LATENCY_SM_REM_U_NORMAL:
	//assert property(pipe_lat_remu_normal(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .stll_w(stall_i),
	//																		 .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
	//else $error("SVA_LATENCY_SM_REM_U_NORMAL, valid does not assert or result output is invalid");

	//SVA_LATENCY_SM_REM_U_NOCALC:
	//assert property(pipe_lat_remu_nocalc(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .op_a(operand_a_i), .op_b(operand_b_i), .stll_w(stall_i),
	//																		 .vldo_w(valid_o), .usro_w(user_o), .rslt_w(result_o), .fflgo_w(fflags_o), .iflgo_w(iflags_o), .rst_w(rst), .stt(skid_stt)))
	//else $error("SVA_LATENCY_SM_REM_U_NOCALC, valid does not assert or result output is invalid");

`endif


//====================================================================================================
//[4] Check outputs behavior when stall_i assert associated with skid buffer status
//====================================================================================================
	property stll_effect_sig(rst_w, sig_w, stll_w);
		@(posedge clk) disable iff (rst_w)
			(($rose(stll_w) && !rst_w) |=> ($stable(sig_w) throughout (!stll_w [->1])));
	endproperty

	//property stll_effect_rdy(rst_w, rdyo_w, stll_w);
	//	@(posedge clk) disable iff (rst_w)
	//		(stall_i |=> !rdyo_w);
	//endproperty


	SVA_STALL_AST_VALID_O:
	assert property(stll_effect_sig(.rst_w(rst), .sig_w(valid_o), .stll_w(stall_i)))
	else $error("SVA_STALL_AST_VALID_O, valid_o is not unchanged during stall_i");

	//SVA_STALL_AST_READY_O:
	//assert property(stll_effect_rdy(.rst_w(rst), .rdyo_w(ready_o), .stll_w(stall_i)))
	//else $error("SVA_STALL_AST_READY_O, ready_o is not de-asserted after 1 clk the stall_i raise");

	SVA_STALL_AST_RESULT_O:
	assert property(stll_effect_sig(.rst_w(rst), .sig_w(result_o), .stll_w(stall_i)))
	else $error("SVA_STALL_AST_RESULT_O, result_o is not unchanged during stall_i");

	SVA_STALL_AST_FFLAGS_O:
	assert property(stll_effect_sig(.rst_w(rst), .sig_w(fflags_o), .stll_w(stall_i)))
	else $error("SVA_STALL_AST_FFLAGS_O, fflags_o is not unchanged during stall_i");

	SVA_STALL_AST_IFLAGS_O:
	assert property(stll_effect_sig(.rst_w(rst), .sig_w(iflags_o), .stll_w(stall_i)))
	else $error("SVA_STALL_AST_IFLAGS_O, iflags_o is not unchanged during stall_i");

	SVA_STALL_AST_USER_O:
	assert property(stll_effect_sig(.rst_w(rst), .sig_w(user_o), .stll_w(stall_i)))
	else $error("SVA_STALL_AST_USER_O, user_o is not unchanged during stall_i");


//====================================================================================================
//[5] Check output behavior when stall_i and reset conflict asserting
//====================================================================================================
	property stll_rst_effect_sig(rst_w, stll_w, sig_w, value, lat);
		@(posedge clk)
			((rst_w && stll_w) |-> ##(lat) (sig_w == value));
	endproperty


	SVA_STALL_RST_AST_VALID_O:
	assert property(stll_rst_effect_sig(.rst_w(rst), .stll_w(stall_i), .sig_w(valid_o), .value(0), .lat(1)))
	else $error("SVA_STALL_RST_AST_VALID_O, valid_o is not de-asserted after 1 clk the rst and stall_i raise");

	SVA_STALL_RST_AST_READY_O:
	assert property(stll_rst_effect_sig(.rst_w(rst), .stll_w(stall_i), .sig_w(ready_o), .value(0), .lat(1)))
	else $error("SVA_STALL_RST_AST_READY_O, ready_o is not de-asserted after 1 clk the rst and stall_i raise");

	SVA_STALL_RST_AST_RESULT_O:
	assert property(stll_rst_effect_sig(.rst_w(rst), .stll_w(stall_i), .sig_w(result_o), .value(0), .lat(1)))
	else $error("SVA_STALL_RST_AST_RESULT_O, result_o is not de-asserted after 1 clk the rst and stall_i raise");

	SVA_STALL_RST_AST_FFLAGS_O:
	assert property(stll_rst_effect_sig(.rst_w(rst), .stll_w(stall_i), .sig_w(fflags_o), .value(0), .lat(1)))
	else $error("SVA_STALL_RST_AST_FFLAGS_O, fflags_o is not de-asserted after 1 clk the rst and stall_i raise");

	SVA_STALL_RST_AST_IFLAGS_O:
	assert property(stll_rst_effect_sig(.rst_w(rst), .stll_w(stall_i), .sig_w(iflags_o), .value(0), .lat(1)))
	else $error("SVA_STALL_RST_AST_IFLAGS_O, iflags_o is not de-asserted after 1 clk the rst and stall_i raise");

	SVA_STALL_RST_AST_USER_O:
	assert property(stll_rst_effect_sig(.rst_w(rst), .stll_w(stall_i), .sig_w(user_o), .value(0), .lat(1)))
	else $error("SVA_STALL_RST_AST_USER_O, user_o is not de-asserted after 1 clk the rst and stall_i raise");


//====================================================================================================
//[6] Check Error out when execting computing ops
//====================================================================================================
	property reserved_op_arith(rst_w, stll_w, op_w, rdyo_w, vldi_w, err_w, stt);
		@(posedge clk) disable iff (rst_w)
		(rdyo_w && vldi_w && (op_w[7:6] == 2'b00) && !rst_w &&
		 ((op_w != `FADD)   &&
			(op_w != `FSUB)   &&
			(op_w != `FMUL)   &&
			(op_w != `FMADD)  &&
			(op_w != `FMSUB)  &&
			(op_w != `FMNADD) &&
			(op_w != `FMNSUB) &&
			(op_w != `ADD)    &&
			(op_w != `SUB)    &&
			(op_w != `MUL)    &&
			(op_w != `MULH)   &&
			(op_w != `MADD)   &&
			(op_w != `MSUB)   &&
			(op_w != `MNADD)  &&
			(op_w != `MNSUB)  &&
			(op_w != `ADD_U)  &&
			(op_w != `SUB_U)  &&
			(op_w != `MUL_U)  &&
			(op_w != `MULH_U) &&
			(op_w != `MUL_SU) &&
			(op_w != `MULH_SU)))
		|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0 (err_w && valid_o);
	endproperty

	property disable_op_arith(rst_w, stll_w, op_w, rdyo_w, vldi_w, err_w, stt);
		@(posedge clk) disable iff (rst_w)
		(rdyo_w && vldi_w && !rst_w &&
		 ((op_w == `FADD)   ||
			(op_w == `FSUB)   ||
			(op_w == `FMUL)   ||
			(op_w == `FMADD)  ||
			(op_w == `FMSUB)  ||
			(op_w == `FMNADD) ||
			(op_w == `FMNSUB) ||
			(op_w == `ADD)    ||
			(op_w == `SUB)    ||
			(op_w == `MUL)    ||
			(op_w == `MULH)   ||
			(op_w == `MADD)   ||
			(op_w == `MSUB)   ||
			(op_w == `MNADD)  ||
			(op_w == `MNSUB)  ||
			(op_w == `ADD_U)  ||
			(op_w == `SUB_U)  ||
			(op_w == `MUL_U)  ||
			(op_w == `MULH_U) ||
			(op_w == `MUL_SU) ||
			(op_w == `MULH_SU)))
		|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0 (err_w && valid_o);
	endproperty

	property noerr_op_arith_correct_rm(rst_w, stll_w, op_w, rdyo_w, vldi_w, err_w, stt);
		@(posedge clk) disable iff (rst_w)
		(rdyo_w && vldi_w && !rst_w &&
		 ((op_w == `FADD)   ||
			(op_w == `FSUB)   ||
			(op_w == `FMUL)   ||
			(op_w == `FMADD)  ||
			(op_w == `FMSUB)  ||
			(op_w == `FMNADD) ||
			(op_w == `FMNSUB) ||
			(op_w == `ADD)    ||
			(op_w == `SUB)    ||
			(op_w == `MUL)    ||
			(op_w == `MULH)   ||
			(op_w == `MADD)   ||
			(op_w == `MSUB)   ||
			(op_w == `MNADD)  ||
			(op_w == `MNSUB)  ||
			(op_w == `ADD_U)  ||
			(op_w == `SUB_U)  ||
			(op_w == `MUL_U)  ||
			(op_w == `MULH_U) ||
			(op_w == `MUL_SU) ||
			(op_w == `MULH_SU)) &&
		 !((rm_i == 3'b101) ||
			 (rm_i == 3'b110) ||
			 (rm_i == 3'b111)))
		|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0 !(err_w && valid_o);
	endproperty

	property noerr_op_arith_reserved_rm(rst_w, stll_w, op_w, rdyo_w, vldi_w, err_w, stt);
		@(posedge clk) disable iff (rst_w)
		(rdyo_w && vldi_w && !rst_w &&
		 ((op_w == `FADD)   ||
			(op_w == `FSUB)   ||
			(op_w == `FMUL)   ||
			(op_w == `FMADD)  ||
			(op_w == `FMSUB)  ||
			(op_w == `FMNADD) ||
			(op_w == `FMNSUB) ||
			(op_w == `ADD)    ||
			(op_w == `SUB)    ||
			(op_w == `MUL)    ||
			(op_w == `MULH)   ||
			(op_w == `MADD)   ||
			(op_w == `MSUB)   ||
			(op_w == `MNADD)  ||
			(op_w == `MNSUB)  ||
			(op_w == `ADD_U)  ||
			(op_w == `SUB_U)  ||
			(op_w == `MUL_U)  ||
			(op_w == `MULH_U) ||
			(op_w == `MUL_SU) ||
			(op_w == `MULH_SU)) &&
		 ((rm_i == 3'b101) ||
			(rm_i == 3'b110) ||
			(rm_i == 3'b111)))
		|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0 (err_w && valid_o);
	endproperty


`ifdef ENV_ARITH_EN
	SVA_ERR_OUT_ARITH_REV_OP:
	assert property(reserved_op_arith(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .rdyo_w(ready_o), .vldi_w(valid_i), .err_w(error_o), .stt(skid_stt)))
	else $error("SVA_ERR_OUT_ARITH_REV_OP, error_o is not asserted when reserved input opcode");

	SVA_NOERR_OUT_ARITH_CORRECT_RM:
	assert property(noerr_op_arith_correct_rm(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .rdyo_w(ready_o), .vldi_w(valid_i), .err_w(error_o), .stt(skid_stt)))
	else $error("SVA_NOERR_OUT_ARITH_CORRECT_RM, error_o is not de-asserted when right input opcode and correct rm_i");

	SVA_NOERR_OUT_ARITH_RESERVED_RM:
	assert property(noerr_op_arith_reserved_rm(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .rdyo_w(ready_o), .vldi_w(valid_i), .err_w(error_o), .stt(skid_stt)))
	else $error("SVA_NOERR_OUT_ARITH_RESERVED_RM, error_o is not asserted when right input opcode and reserved rm_i");

`else
	SVA_ERR_OUT_ARITH_DIS:
	assert property(disable_op_arith(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .rdyo_w(ready_o), .vldi_w(valid_i), .err_w(error_o), .stt(skid_stt)))
	else $error("SVA_ERR_OUT_ARITH_DIS, error_o is not asserted when disable input opcode");

`endif

//====================================================================================================
	property reserved_op_cmpcnv(rst_w, stll_w, op_w, rdyo_w, vldi_w, err_w, stt);
		@(posedge clk) disable iff (rst_w)
		(rdyo_w && vldi_w && (op_w[7:6] == 2'b10) && !rst_w &&
		 ((op_w != `FMIN)      &&
			(op_w != `FMAX)      &&
			(op_w != `FEQ)       &&
			(op_w != `FLT)       &&
			(op_w != `FLE)       &&
			(op_w != `FNE)       &&
			(op_w != `FCVT_W_S)  &&
			(op_w != `FCVT_WU_S) &&
			(op_w != `FCVT_S_W)  &&
			(op_w != `FCVT_S_WU)))
		|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0 (err_w && valid_o);
	endproperty

	property disable_op_cmpcnv(rst_w, stll_w, op_w, rdyo_w, vldi_w, err_w, stt);
		@(posedge clk) disable iff (rst_w)
		(rdyo_w && vldi_w && !rst_w &&
		 ((op_w == `FMIN)      ||
			(op_w == `FMAX)      ||
			(op_w == `FEQ)       ||
			(op_w == `FLT)       ||
			(op_w == `FLE)       ||
			(op_w == `FNE)       ||
			(op_w == `FCVT_W_S)  ||
			(op_w == `FCVT_WU_S) ||
			(op_w == `FCVT_S_W)  ||
			(op_w == `FCVT_S_WU)))
		|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0 (err_w && valid_o);
	endproperty

	property noerr_op_cmpcnv_correct_rm(rst_w, stll_w, op_w, rdyo_w, vldi_w, err_w, stt);
		@(posedge clk) disable iff (rst_w)
		(rdyo_w && vldi_w && !rst_w &&
		 ((op_w == `FMIN)      ||
			(op_w == `FMAX)      ||
			(op_w == `FEQ)       ||
			(op_w == `FLT)       ||
			(op_w == `FLE)       ||
			(op_w == `FNE)       ||
			(op_w == `FCVT_W_S)  ||
			(op_w == `FCVT_WU_S) ||
			(op_w == `FCVT_S_W)  ||
			(op_w == `FCVT_S_WU)) &&
		 !((rm_i == 3'b101) ||
			 (rm_i == 3'b110) ||
			 (rm_i == 3'b111)))
		|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0 !(err_w && valid_o);
	endproperty

	property noerr_op_cmpcnv_reserved_rm(rst_w, stll_w, op_w, rdyo_w, vldi_w, err_w, stt);
		@(posedge clk) disable iff (rst_w)
		(rdyo_w && vldi_w && !rst_w &&
		 ((op_w == `FMIN)      ||
			(op_w == `FMAX)      ||
			(op_w == `FEQ)       ||
			(op_w == `FLT)       ||
			(op_w == `FLE)       ||
			(op_w == `FNE)       ||
			(op_w == `FCVT_W_S)  ||
			(op_w == `FCVT_WU_S) ||
			(op_w == `FCVT_S_W)  ||
			(op_w == `FCVT_S_WU)) &&
		 ((rm_i == 3'b101) ||
			(rm_i == 3'b110) ||
			(rm_i == 3'b111)))
		|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0 (err_w && valid_o);
	endproperty


`ifdef ENV_CMPCNV_EN
	SVA_ERR_OUT_CMP_CVT_REV_OP:
	assert property(reserved_op_cmpcnv(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .rdyo_w(ready_o), .vldi_w(valid_i), .err_w(error_o), .stt(skid_stt)))
	else $error("SVA_ERR_OUT_CMP_CVT_REV_OP, error_o is not asserted when reserved input opcode");

	SVA_NOERR_OUT_CMP_CVT_CORRECT_RM:
	assert property(noerr_op_cmpcnv_correct_rm(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .rdyo_w(ready_o), .vldi_w(valid_i), .err_w(error_o), .stt(skid_stt)))
	else $error("SVA_NOERR_OUT_CMP_CVT_CORRECT_RM, error_o is not de-asserted when right input opcode and correct rm_i");

	SVA_NOERR_OUT_CMP_CVT_RESERVED_RM:
	assert property(noerr_op_cmpcnv_reserved_rm(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .rdyo_w(ready_o), .vldi_w(valid_i), .err_w(error_o), .stt(skid_stt)))
	else $error("SVA_NOERR_OUT_CMP_CVT_RESERVED_RM, error_o is not asserted when right input opcode and reserved rm_i");

`else
	SVA_ERR_OUT_CMP_CVT_DIS:
	assert property(disable_op_cmpcnv(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .rdyo_w(ready_o), .vldi_w(valid_i), .err_w(error_o), .stt(skid_stt)))
	else $error("SVA_ERR_OUT_CMP_CVT_DIS, error_o is not asserted when disable input opcode");

`endif

//====================================================================================================
	property reserved_op_sm(rst_w, stll_w, op_w, rdyo_w, vldi_w, err_w, stt);
		@(posedge clk) disable iff (rst_w)
    (rdyo_w && vldi_w && (op_w[7:6] == 2'b01) && !rst_w &&
     ((op_w != `FDIV)  &&
      (op_w != `FSQRT) &&
      (op_w != `FEXP)  &&
      (op_w != `FLOG)  &&
      (op_w != `DIV_S) &&
      (op_w != `DIV_U) &&
      (op_w != `REM_S) &&
      (op_w != `REM_U)))
		|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0 (err_w && valid_o);
	endproperty

	property disable_op_sm(rst_w, stll_w, op_w, rdyo_w, vldi_w, err_w, stt);
		@(posedge clk) disable iff (rst_w)
    (rdyo_w && vldi_w && !rst_w &&
     ((op_w == `FDIV)  ||
      (op_w == `FSQRT) ||
      (op_w == `FEXP)  ||
      (op_w == `FLOG)  ||
      (op_w == `DIV_S) ||
      (op_w == `DIV_U) ||
      (op_w == `REM_S) ||
      (op_w == `REM_U)))
		|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0 (err_w && valid_o);
	endproperty

	property noerr_op_sm_correct_rm(rst_w, stll_w, op_w, rdyo_w, vldi_w, err_w, stt);
		@(posedge clk) disable iff (rst_w)
    (rdyo_w && vldi_w && !rst_w &&
     ((op_w == `FDIV)  ||
      (op_w == `FSQRT) ||
      (op_w == `DIV_S) ||
      (op_w == `DIV_U) ||
      (op_w == `REM_S) ||
      (op_w == `REM_U)) &&
		 !((rm_i == 3'b101) ||
			 (rm_i == 3'b110) ||
			 (rm_i == 3'b111)))
		|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0 !(err_w && valid_o);
	endproperty

	property noerr_op_sm_reserved_rm(rst_w, stll_w, op_w, rdyo_w, vldi_w, err_w, stt);
		@(posedge clk) disable iff (rst_w)
    (rdyo_w && vldi_w && !rst_w &&
     ((op_w == `FDIV)  ||
      (op_w == `FSQRT) ||
      (op_w == `DIV_S) ||
      (op_w == `DIV_U) ||
      (op_w == `REM_S) ||
      (op_w == `REM_U)) &&
		 ((rm_i == 3'b101) ||
			(rm_i == 3'b110) ||
			(rm_i == 3'b111)))
		|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0 (err_w && valid_o);
	endproperty

	property disable_op_explog(rst_w, stll_w, op_w, rdyo_w, vldi_w, err_w, stt);
		@(posedge clk) disable iff (rst_w)
  	(rdyo_w && vldi_w && !rst_w &&
		 ((op_w == `FEXP) || (op_w == `FLOG)))
		|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0 (err_w && valid_o);
	endproperty

	property noerr_op_explog_correct_rm(rst_w, stll_w, op_w, rdyo_w, vldi_w, err_w, stt);
		@(posedge clk) disable iff (rst_w)
  	(rdyo_w && vldi_w && !rst_w &&
		 ((op_w == `FEXP) || (op_w == `FLOG)) &&
		 !((rm_i == 3'b101) || (rm_i == 3'b110) || (rm_i == 3'b111)))
		|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0 !(err_w && valid_o);
	endproperty

	property noerr_op_explog_reserved_rm(rst_w, stll_w, op_w, rdyo_w, vldi_w, err_w, stt);
		@(posedge clk) disable iff (rst_w)
  	(rdyo_w && vldi_w && !rst_w &&
		 ((op_w == `FEXP) || (op_w == `FLOG)) &&
		 ((rm_i == 3'b101) || (rm_i == 3'b110) || (rm_i == 3'b111)))
		|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0 (err_w && valid_o);
	endproperty

	property reserved_op(rst_w, stll_w, op_w, rdyo_w, vldi_w, err_w, stt);
		@(posedge clk) disable iff (rst_w)
    (rdyo_w && vldi_w && !rst_w && (op_w[7:6] == 2'b11)) //|-> (!stll_w) [->4] ##1 err_w;
		|=> ((stt[1:0] == 2'b00) || (stt[1:0] == 2'b01)) [->4] ##0 !stll_w [->1] ##0 (err_w && valid_o);
	endproperty


`ifdef ENV_SPMATH_EN
	SVA_ERR_OUT_SM_REV_OP:
	assert property(reserved_op_sm(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .rdyo_w(ready_o), .vldi_w(valid_i), .err_w(error_o), .stt(skid_stt)))
	else $error("SVA_ERR_OUT_SM_REV_OP, error_o is not asserted when reserved input opcode");

	SVA_NOERR_OUT_SM_OTHERS_CORRECT_RM:
	assert property(noerr_op_sm_correct_rm(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .rdyo_w(ready_o), .vldi_w(valid_i), .err_w(error_o), .stt(skid_stt)))
	else $error("SVA_NOERR_OUT_SM_OTHERS_CORRECT_RM, error_o is not de-asserted when reserved input opcode and correct rm_i");

	SVA_NOERR_OUT_SM_OTHERS_RESERVED_RM:
	assert property(noerr_op_sm_reserved_rm(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .rdyo_w(ready_o), .vldi_w(valid_i), .err_w(error_o), .stt(skid_stt)))
	else $error("SVA_NOERR_OUT_SM_OTHERS_RESERVED_RM, error_o is not asserted when reserved input opcode and reserved rm_i");

	`ifdef ENV_EXPLOG_EN
		SVA_NOERR_OUT_SM_EXP_LOG_CORRECT_RM:
		assert property(noerr_op_explog_correct_rm(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .rdyo_w(ready_o), .vldi_w(valid_i), .err_w(error_o), .stt(skid_stt)))
		else $error("SVA_NOERR_OUT_SM_EXP_LOG_CORRECT_RM, error_o is not de-asserted when reserved input opcode and correct rm_i");

		SVA_NOERR_OUT_SM_EXP_LOG_RESERVED_RM:
		assert property(noerr_op_explog_reserved_rm(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .rdyo_w(ready_o), .vldi_w(valid_i), .err_w(error_o), .stt(skid_stt)))
		else $error("SVA_NOERR_OUT_SM_EXP_LOG_RESERVED_RM, error_o is not asserted when reserved input opcode and reserved rm_i");

	`else
		SVA_ERR_OUT_SM_DIS_EXP_LOG:
		assert property(disable_op_explog(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .rdyo_w(ready_o), .vldi_w(valid_i), .err_w(error_o), .stt(skid_stt)))
		else $error("SVA_ERR_OUT_SM_DIS_EXP_LOG, error_o is not asserted when disable input opcode");

	`endif
`else
	SVA_ERR_OUT_SM_DIS:
	assert property(disable_op_sm(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .rdyo_w(ready_o), .vldi_w(valid_i), .err_w(error_o), .stt(skid_stt)))
	else $error("SVA_ERR_OUT_SM_DIS, error_o is not asserted when disable input opcode");

`endif

SVA_ERR_OUT_NO_PIPELINE:
assert property(reserved_op(.rst_w(rst), .stll_w(stall_i), .op_w(op_i), .rdyo_w(ready_o), .vldi_w(valid_i), .err_w(error_o), .stt(skid_stt)))
else $error("SVA_ERR_OUT_NO_PIPELINE, error_o is not asserted when reserved input opcode");


//====================================================================================================
//[7] Check input/output handshake when executing operations
//====================================================================================================
property sm_ready_o(rst_w, vldi_w, op_w, rdyo_w, vldo_w);
	@(posedge clk) disable iff (rst_w)
	((vldi_w && rdyo_w && !rst_w && (op_w == `FDIV )) |-> ##1 $fell(rdyo_w) ##16 $rose(vldo_w) ##1 $rose(rdyo_w)) or
	((vldi_w && rdyo_w && !rst_w && (op_w == `FSQRT)) |-> ##1 $fell(rdyo_w) ##16 $rose(vldo_w) ##1 $rose(rdyo_w)) or
	((vldi_w && rdyo_w && !rst_w && (op_w == `FEXP )) |-> ##1 $fell(rdyo_w) ##30 $rose(vldo_w) ##1 $rose(rdyo_w)) or
	((vldi_w && rdyo_w && !rst_w && (op_w == `FLOG )) |-> ##1 $fell(rdyo_w) ##38 $rose(vldo_w) ##1 $rose(rdyo_w)) or
	((vldi_w && rdyo_w && !rst_w && (op_w == `DIV_S)) |-> ##1 $fell(rdyo_w) ##18 $rose(vldo_w) ##1 $rose(rdyo_w)) or
	((vldi_w && rdyo_w && !rst_w && (op_w == `DIV_U)) |-> ##1 $fell(rdyo_w) ##18 $rose(vldo_w) ##1 $rose(rdyo_w)) or
	((vldi_w && rdyo_w && !rst_w && (op_w == `REM_S)) |-> ##1 $fell(rdyo_w) ##18 $rose(vldo_w) ##1 $rose(rdyo_w)) or
	((vldi_w && rdyo_w && !rst_w && (op_w == `REM_U)) |-> ##1 $fell(rdyo_w) ##18 $rose(vldo_w) ##1 $rose(rdyo_w));
endproperty


SVA_HANDSHAKE_SM_READY_O:
assert property(sm_ready_o(.rst_w(rst), .vldi_w(valid_i), .op_w(op_i), .rdyo_w(ready_o), .vldo_w(valid_o)))
else $error("SVA_HANDSHAKE_SM_READY_O, ready_o is not de-assert after hanshake 1 cycle or is not assert after valid_o 1 cycle");


//====================================================================================================
//[8] FCOV Reset occurrence timing 
//====================================================================================================
	property fcov_reset_occurrence(vldi_w, rdyo_w, op_w, rst_w, op, start_range, end_range);
		@(posedge clk) 
			((vldi_w && rdyo_w && (op_w == op)) |-> ##[start_range:end_range] (rst_w));
	endproperty

`ifdef ENV_ARITH_EN
	FCOV_RESET_OCCURRENCE_HANDSHAKE_ARITH_FADD:
	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FADD), .start_range(0), .end_range(0)));

	FCOV_RESET_OCCURRENCE_CALCULATING_ARITH_FADD:
	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FADD), .start_range(1), .end_range(3)));

	FCOV_RESET_OCCURRENCE_THROWN_ARITH_FADD:
	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FADD), .start_range(4), .end_range(4)));

 	FCOV_RESET_OCCURRENCE_HANDSHAKE_ARITH_FSUB:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FSUB), .start_range(0), .end_range(0)));

 	FCOV_RESET_OCCURRENCE_CALCULATING_ARITH_FSUB:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FSUB), .start_range(1), .end_range(3)));

 	FCOV_RESET_OCCURRENCE_THROWN_ARITH_FSUB:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FSUB), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_ARITH_FMUL:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FMUL), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_ARITH_FMUL:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FMUL), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_ARITH_FMUL:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FMUL), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_ARITH_FMADD:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FMADD), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_ARITH_FMADD:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FMADD), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_ARITH_FMADD:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FMADD), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_ARITH_FMSUB:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FMSUB), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_ARITH_FMSUB:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FMSUB), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_ARITH_FMSUB:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FMSUB), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_ARITH_FMNADD:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FMNADD), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_ARITH_FMNADD:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FMNADD), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_ARITH_FMNADD:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FMNADD), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_ARITH_FMNSUB:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FMNSUB), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_ARITH_FMNSUB:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FMNSUB), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_ARITH_FMNSUB:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FMNSUB), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_ARITH_ADD:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`ADD), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_ARITH_ADD:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`ADD), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_ARITH_ADD:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`ADD), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_ARITH_SUB:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`SUB), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_ARITH_SUB:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`SUB), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_ARITH_SUB:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`SUB), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_ARITH_MADD:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MADD), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_ARITH_MADD:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MADD), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_ARITH_MADD:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MADD), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_ARITH_MNADD:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MNADD), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_ARITH_MNADD:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MNADD), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_ARITH_MNADD:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MNADD), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_ARITH_MSUB:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MSUB), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_ARITH_MSUB:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MSUB), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_ARITH_MSUB:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MSUB), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_ARITH_MNSUB:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MNSUB), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_ARITH_MNSUB:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MNSUB), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_ARITH_MNSUB:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MNSUB), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_ARITH_MUL:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MUL), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_ARITH_MUL:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MUL), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_ARITH_MUL:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MUL), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_ARITH_MULH:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MULH), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_ARITH_MULH:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MULH), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_ARITH_MULH:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MULH), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_ARITH_ADD_U:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`ADD_U), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_ARITH_ADD_U:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`ADD_U), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_ARITH_ADD_U:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`ADD_U), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_ARITH_SUB_U:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`SUB_U), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_ARITH_SUB_U:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`SUB_U), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_ARITH_SUB_U:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`SUB_U), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_ARITH_MUL_U:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MUL_U), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_ARITH_MUL_U:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MUL_U), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_ARITH_MUL_U:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MUL_U), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_ARITH_MULH_U:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MULH_U), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_ARITH_MULH_U:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MULH_U), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_ARITH_MULH_U:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MULH_U), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_ARITH_MUL_SU:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MUL_SU), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_ARITH_MUL_SU:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MUL_SU), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_ARITH_MUL_SU:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MUL_SU), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_ARITH_MULH_SU:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MULH_SU), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_ARITH_MULH_SU:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MULH_SU), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_ARITH_MULH_SU:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`MULH_SU), .start_range(4), .end_range(4)));
`endif
 
`ifdef ENV_CMPCNV_EN
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_CMP_CVT_FMIN:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FMIN), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_CMP_CVT_FMIN:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FMIN), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_CMP_CVT_FMIN:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FMIN), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_CMP_CVT_FMAX:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FMAX), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_CMP_CVT_FMAX:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FMAX), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_CMP_CVT_FMAX:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FMAX), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_CMP_CVT_FEQ :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FEQ), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_CMP_CVT_FEQ :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FEQ), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_CMP_CVT_FEQ :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FEQ), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_CMP_CVT_FLT :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FLT), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_CMP_CVT_FLT :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FLT), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_CMP_CVT_FLT :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FLT), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_CMP_CVT_FLE :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FLE), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_CMP_CVT_FLE :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FLE), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_CMP_CVT_FLE :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FLE), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_CMP_CVT_FNE :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FNE), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_CMP_CVT_FNE :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FNE), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_CMP_CVT_FNE :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FNE), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_CMP_CVT_FCVT_W_S :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FCVT_W_S), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_CMP_CVT_FCVT_W_S :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FCVT_W_S), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_CMP_CVT_FCVT_W_S :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FCVT_W_S), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_CMP_CVT_FCVT_WU_S :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FCVT_WU_S), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_CMP_CVT_FCVT_WU_S :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FCVT_WU_S), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_CMP_CVT_FCVT_WU_S :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FCVT_WU_S), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_CMP_CVT_FCVT_S_W :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FCVT_S_W), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_CMP_CVT_FCVT_S_W :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FCVT_S_W), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_CMP_CVT_FCVT_S_W :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FCVT_S_W), .start_range(4), .end_range(4)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_CMP_CVT_FCVT_S_WU :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FCVT_S_WU), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_CMP_CVT_FCVT_S_WU :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FCVT_S_WU), .start_range(1), .end_range(3)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_CMP_CVT_FCVT_S_WU :
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FCVT_S_WU), .start_range(4), .end_range(4)));
`endif
 
`ifdef ENV_SPMATH_EN
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_SM_FDIV:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FDIV), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_SM_FDIV:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FDIV), .start_range(1), .end_range(16)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_SM_FDIV:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FDIV), .start_range(17), .end_range(17)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_SM_FSQRT:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FSQRT), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_SM_FSQRT:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FSQRT), .start_range(1), .end_range(16)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_SM_FSQRT:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FSQRT), .start_range(17), .end_range(17)));
 
`ifdef ENV_EXPLOG_EN
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_SM_FEXP:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FEXP), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_SM_FEXP:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FEXP), .start_range(1), .end_range(29)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_SM_FEXP:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FEXP), .start_range(30), .end_range(30)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_SM_FLOG:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FLOG), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_SM_FLOG:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FLOG), .start_range(1), .end_range(49)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_SM_FLOG:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`FLOG), .start_range(50), .end_range(50)));
`endif
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_SM_DIV:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`DIV_S), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_SM_DIV:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`DIV_S), .start_range(1), .end_range(18)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_SM_DIV:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`DIV_S), .start_range(19), .end_range(19)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_SM_DIV_U:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`DIV_U), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_SM_DIV_U:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`DIV_U), .start_range(1), .end_range(18)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_SM_DIV_U:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`DIV_U), .start_range(19), .end_range(19)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_SM_REM:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`REM_S), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_SM_REM:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`REM_S), .start_range(1), .end_range(18)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_SM_REM:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`REM_S), .start_range(19), .end_range(19)));
 
 	FCOV_RESET_OCCURRENCE_HANDSHAKE_SM_REM_U:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`REM_U), .start_range(0), .end_range(0)));
 
 	FCOV_RESET_OCCURRENCE_CALCULATING_SM_REM_U:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`REM_U), .start_range(1), .end_range(18)));
 
 	FCOV_RESET_OCCURRENCE_THROWN_SM_REM_U:
 	cover property(fcov_reset_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .op(`REM_U), .start_range(19), .end_range(19)));
`endif


//====================================================================================================
//[9] FCOV Stall occurrence timing 
//====================================================================================================
	property fcov_stall_occurrence(vldi_w, rdyo_w, op_w, stll_w, op, start_range, end_range);
		@(posedge clk) 
			((vldi_w && rdyo_w && (op_w == op)) |-> ##[start_range:end_range] (stll_w));
	endproperty

`ifdef ENV_ARITH_EN
	FCOV_STALL_OCCURRENCE_CALCULATING_ARITH_FADD:
	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FADD), .start_range(1), .end_range(3)));

	FCOV_STALL_OCCURRENCE_THROWN_ARITH_FADD:
	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FADD), .start_range(4), .end_range(4)));

 	FCOV_STALL_OCCURRENCE_CALCULATING_ARITH_FSUB:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FSUB), .start_range(1), .end_range(3)));

 	FCOV_STALL_OCCURRENCE_THROWN_ARITH_FSUB:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FSUB), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_ARITH_FMUL:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FMUL), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_ARITH_FMUL:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FMUL), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_ARITH_FMADD:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FMADD), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_ARITH_FMADD:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FMADD), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_ARITH_FMSUB:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FMSUB), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_ARITH_FMSUB:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FMSUB), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_ARITH_FMNADD:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FMNADD), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_ARITH_FMNADD:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FMNADD), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_ARITH_FMNSUB:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FMNSUB), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_ARITH_FMNSUB:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FMNSUB), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_ARITH_ADD:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`ADD), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_ARITH_ADD:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`ADD), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_ARITH_SUB:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`SUB), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_ARITH_SUB:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`SUB), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_ARITH_MADD:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`MADD), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_ARITH_MADD:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`MADD), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_ARITH_MNADD:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`MNADD), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_ARITH_MNADD:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`MNADD), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_ARITH_MSUB:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`MSUB), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_ARITH_MSUB:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`MSUB), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_ARITH_MNSUB:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`MNSUB), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_ARITH_MNSUB:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`MNSUB), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_ARITH_MUL:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`MUL), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_ARITH_MUL:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`MUL), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_ARITH_MULH:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`MULH), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_ARITH_MULH:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`MULH), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_ARITH_ADD_U:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`ADD_U), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_ARITH_ADD_U:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`ADD_U), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_ARITH_SUB_U:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`SUB_U), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_ARITH_SUB_U:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`SUB_U), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_ARITH_MUL_U:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`MUL_U), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_ARITH_MUL_U:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`MUL_U), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_ARITH_MULH_U:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`MULH_U), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_ARITH_MULH_U:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`MULH_U), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_ARITH_MUL_SU:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`MUL_SU), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_ARITH_MUL_SU:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`MUL_SU), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_ARITH_MULH_SU:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`MULH_SU), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_ARITH_MULH_SU:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`MULH_SU), .start_range(4), .end_range(4)));
`endif
 
`ifdef ENV_CMPCNV_EN
 	FCOV_STALL_OCCURRENCE_CALCULATING_CMP_CVT_FMIN:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FMIN), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_CMP_CVT_FMIN:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FMIN), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_CMP_CVT_FMAX:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FMAX), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_CMP_CVT_FMAX:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FMAX), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_CMP_CVT_FEQ :
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FEQ), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_CMP_CVT_FEQ :
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FEQ), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_CMP_CVT_FLT :
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FLT), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_CMP_CVT_FLT :
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FLT), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_CMP_CVT_FLE :
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FLE), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_CMP_CVT_FLE :
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FLE), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_CMP_CVT_FNE :
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FNE), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_CMP_CVT_FNE :
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FNE), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_CMP_CVT_FCVT_W_S :
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FCVT_W_S), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_CMP_CVT_FCVT_W_S :
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FCVT_W_S), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_CMP_CVT_FCVT_WU_S :
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FCVT_WU_S), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_CMP_CVT_FCVT_WU_S :
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FCVT_WU_S), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_CMP_CVT_FCVT_S_W :
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FCVT_S_W), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_CMP_CVT_FCVT_S_W :
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FCVT_S_W), .start_range(4), .end_range(4)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_CMP_CVT_FCVT_S_WU :
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FCVT_S_WU), .start_range(1), .end_range(3)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_CMP_CVT_FCVT_S_WU :
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FCVT_S_WU), .start_range(4), .end_range(4)));
`endif
 
`ifdef ENV_SPMATH_EN
 	FCOV_STALL_OCCURRENCE_CALCULATING_SM_FDIV:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FDIV), .start_range(1), .end_range(16)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_SM_FDIV:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FDIV), .start_range(17), .end_range(17)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_SM_FSQRT:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FSQRT), .start_range(1), .end_range(16)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_SM_FSQRT:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FSQRT), .start_range(17), .end_range(17)));
 
`ifdef ENV_EXPLOG_EN
 	FCOV_STALL_OCCURRENCE_CALCULATING_SM_FEXP:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FEXP), .start_range(1), .end_range(29)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_SM_FEXP:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FEXP), .start_range(30), .end_range(30)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_SM_FLOG:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FLOG), .start_range(1), .end_range(49)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_SM_FLOG:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`FLOG), .start_range(50), .end_range(50)));
`endif
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_SM_DIV:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`DIV_S), .start_range(1), .end_range(18)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_SM_DIV:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`DIV_S), .start_range(19), .end_range(19)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_SM_DIV_U:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`DIV_U), .start_range(1), .end_range(18)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_SM_DIV_U:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`DIV_U), .start_range(19), .end_range(19)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_SM_REM:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`REM_S), .start_range(1), .end_range(18)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_SM_REM:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`REM_S), .start_range(19), .end_range(19)));
 
 	FCOV_STALL_OCCURRENCE_CALCULATING_SM_REM_U:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`REM_U), .start_range(1), .end_range(18)));
 
 	FCOV_STALL_OCCURRENCE_THROWN_SM_REM_U:
 	cover property(fcov_stall_occurrence(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .stll_w(stall_i), .op(`REM_U), .start_range(19), .end_range(19)));
`endif


//====================================================================================================
//[10] FCOV Stall and Reset conflict occurrence timing 
//====================================================================================================

// Assert "stall_i" at same timing with reset asserting, then reset
// de-asserted while stall_i still keep active 1 cycle later.
	property fcov_stall_and_reset_occurrence_1(vldi_w, rdyo_w, op_w, rst_w, stll_w, op, start_range, end_range);
		@(posedge clk) 
//LV 			((vldi_w && rdyo_w && (op_w == op)) |-> (##[start_range:end_range] (stll_w & rst_w) ##[0:$] (stll_w & (!rst_w)) ##1 ((!stll_w) & (!rst_w))));
			((vldi_w && rdyo_w && (op_w == op) && !((rm_i == 3'b101) || (rm_i == 3'b110) || (rm_i == 3'b111))) ##[start_range:end_range] (stll_w & rst_w) ##[0:end_range] (stll_w & (!rst_w)) ##1 ((!stll_w) & (!rst_w)));
	endproperty

// During asserting "stall_i", assert reset, then stall_i de-asserted while
// reset still keep active 1 cycle later. 
	property fcov_stall_and_reset_occurrence_2(vldi_w, rdyo_w, op_w, rst_w, stll_w, op, start_range, end_range);
		@(posedge clk) 
//LV 			((vldi_w && rdyo_w && (op_w == op)) |-> (##[start_range:end_range] (stll_w  & (!rst_w)) ##[1:$] (stll_w & rst_w) ##1 ((!stll_w) & (rst_w))));
			((vldi_w && rdyo_w && (op_w == op) && !((rm_i == 3'b101) || (rm_i == 3'b110) || (rm_i == 3'b111))) ##[start_range:end_range] (stll_w  & (!rst_w)) ##[1:end_range] (stll_w & rst_w) ##1 ((!stll_w) & (rst_w)));
	endproperty

`ifdef ENV_ARITH_EN
	FCOV_STALL_AND_RESET_OCCURRENCE_1_ARITH_FADD:
	cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FADD), .start_range(0), .end_range(4)));

	FCOV_STALL_AND_RESET_OCCURRENCE_2_ARITH_FADD:
	cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FADD), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_ARITH_FSUB:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FSUB), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_ARITH_FSUB:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FSUB), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_ARITH_FMUL:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FMUL), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_ARITH_FMUL:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FMUL), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_ARITH_FMADD:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FMADD), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_ARITH_FMADD:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FMADD), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_ARITH_FMSUB:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FMSUB), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_ARITH_FMSUB:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FMSUB), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_ARITH_FMNADD:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FMNADD), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_ARITH_FMNADD:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FMNADD), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_ARITH_FMNSUB:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FMNSUB), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_ARITH_FMNSUB:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FMNSUB), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_ARITH_ADD:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`ADD), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_ARITH_ADD:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`ADD), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_ARITH_SUB:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`SUB), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_ARITH_SUB:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`SUB), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_ARITH_MADD:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`MADD), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_ARITH_MADD:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`MADD), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_ARITH_MNADD:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`MNADD), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_ARITH_MNADD:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`MNADD), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_ARITH_MSUB:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`MSUB), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_ARITH_MSUB:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`MSUB), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_ARITH_MNSUB:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`MNSUB), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_ARITH_MNSUB:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`MNSUB), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_ARITH_MUL:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`MUL), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_ARITH_MUL:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`MUL), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_ARITH_MULH:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`MULH), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_ARITH_MULH:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`MULH), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_ARITH_ADD_U:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`ADD_U), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_ARITH_ADD_U:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`ADD_U), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_ARITH_SUB_U:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`SUB_U), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_ARITH_SUB_U:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`SUB_U), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_ARITH_MUL_U:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`MUL_U), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_ARITH_MUL_U:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`MUL_U), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_ARITH_MULH_U:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`MULH_U), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_ARITH_MULH_U:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`MULH_U), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_ARITH_MUL_SU:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`MUL_SU), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_ARITH_MUL_SU:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`MUL_SU), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_ARITH_MULH_SU:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`MULH_SU), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_ARITH_MULH_SU:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`MULH_SU), .start_range(0), .end_range(4)));
`endif

`ifdef ENV_CMPCNV_EN
  FCOV_STALL_AND_RESET_OCCURRENCE_1_CMP_CVT_FMIN:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FMIN), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_CMP_CVT_FMIN:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FMIN), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_CMP_CVT_FMAX:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FMAX), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_CMP_CVT_FMAX:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FMAX), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_CMP_CVT_FEQ :
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FEQ), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_CMP_CVT_FEQ :
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FEQ), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_CMP_CVT_FLT :
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FLT), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_CMP_CVT_FLT :
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FLT), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_CMP_CVT_FLE :
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FLE), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_CMP_CVT_FLE :
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FLE), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_CMP_CVT_FNE :
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FNE), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_CMP_CVT_FNE :
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FNE), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_CMP_CVT_FCVT_W_S :
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FCVT_W_S), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_CMP_CVT_FCVT_W_S :
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FCVT_W_S), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_CMP_CVT_FCVT_WU_S :
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FCVT_WU_S), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_CMP_CVT_FCVT_WU_S :
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FCVT_WU_S), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_CMP_CVT_FCVT_S_W :
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FCVT_S_W), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_CMP_CVT_FCVT_S_W :
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FCVT_S_W), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_CMP_CVT_FCVT_S_WU :
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FCVT_S_WU), .start_range(0), .end_range(4)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_CMP_CVT_FCVT_S_WU :
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FCVT_S_WU), .start_range(0), .end_range(4)));
`endif

`ifdef ENV_SPMATH_EN
  FCOV_STALL_AND_RESET_OCCURRENCE_1_SM_FDIV:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FDIV), .start_range(0), .end_range(17)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_SM_FDIV:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FDIV), .start_range(0), .end_range(17)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_SM_FSQRT:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FSQRT), .start_range(0), .end_range(17)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_SM_FSQRT:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FSQRT), .start_range(0), .end_range(17)));

`ifdef ENV_EXPLOG_EN
  FCOV_STALL_AND_RESET_OCCURRENCE_1_SM_FEXP:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FEXP), .start_range(0), .end_range(30)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_SM_FEXP:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FEXP), .start_range(0), .end_range(30)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_SM_FLOG:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FLOG), .start_range(0), .end_range(50)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_SM_FLOG:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`FLOG), .start_range(0), .end_range(50)));
`endif

  FCOV_STALL_AND_RESET_OCCURRENCE_1_SM_DIV:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`DIV_S), .start_range(0), .end_range(19)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_SM_DIV:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`DIV_S), .start_range(0), .end_range(19)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_SM_DIV_U:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`DIV_U), .start_range(0), .end_range(19)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_SM_DIV_U:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`DIV_U), .start_range(0), .end_range(19)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_SM_REM:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`REM_S), .start_range(0), .end_range(19)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_SM_REM:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`REM_S), .start_range(0), .end_range(19)));

  FCOV_STALL_AND_RESET_OCCURRENCE_1_SM_REM_U:
        cover property(fcov_stall_and_reset_occurrence_1(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`REM_U), .start_range(0), .end_range(19)));

  FCOV_STALL_AND_RESET_OCCURRENCE_2_SM_REM_U:
        cover property(fcov_stall_and_reset_occurrence_2(.vldi_w(valid_i), .rdyo_w(ready_o), .op_w(op_i), .rst_w(rst), .stll_w(stall_i), .op(`REM_U), .start_range(0), .end_range(19)));
`endif

//====================================================================================================
//[11] FCOV Round_w_output_flushing 
//====================================================================================================

`ifdef ENV_ARITH_EN
	`define RS_PRE_FLUSHING_ARITH  {tb_top.DUT.arith_en.i_arith.i_norm_round.w_flt_result_type_af[1:0]}
	`define RS_PRE_FLUSHING_ARITH_1  {tb_top.DUT.arith_en.i_arith.i_norm_round.w_flt_result_type_af[1]}
	`define RS_PRE_FLUSHING_ARITH_0  {tb_top.DUT.arith_en.i_arith.i_norm_round.w_flt_result_type_af[0]}
`endif
`ifdef ENV_SPMATH_EN
	`ifdef ENV_EXPLOG_EN
		`define RS_PRE_FLUSHING_SPMATH  {{tb_top.DUT.spmath_en.i_smath.spmath_explog_en.i_sm_round_norm_flg.w_flt_result_type_af[1:0]}}
		`define RS_PRE_FLUSHING_SPMATH_1 {{tb_top.DUT.spmath_en.i_smath.spmath_explog_en.i_sm_round_norm_flg.w_flt_result_type_af[1]}}
		`define RS_PRE_FLUSHING_SPMATH_0 {{tb_top.DUT.spmath_en.i_smath.spmath_explog_en.i_sm_round_norm_flg.w_flt_result_type_af[0]}}
	`else
		`define RS_PRE_FLUSHING_SPMATH  {{tb_top.DUT.spmath_en.i_smath.spmath_explog_dis.i_sm_round_norm_flg.w_flt_result_type_af[1:0]}}
		`define RS_PRE_FLUSHING_SPMATH_1 {{tb_top.DUT.spmath_en.i_smath.spmath_explog_dis.i_sm_round_norm_flg.w_flt_result_type_af[1]}}
		`define RS_PRE_FLUSHING_SPMATH_0 {{tb_top.DUT.spmath_en.i_smath.spmath_explog_dis.i_sm_round_norm_flg.w_flt_result_type_af[0]}}
	`endif
`endif

	property fcov_round_w_output_flushing(rst_w, op_w, vldi_w, rdyo_w, lat, vldo_w, op, rm_w, rm, fn_w, fn, rs_pre_flushing, rs_post_flushing, rs_post_flushing_val, uf, op_a, op_b, op_c);
		@(posedge clk) disable iff (rst_w)
			(((op_w == op) && vldi_w && rdyo_w && (rm_w == rm) && (fn_w == fn) && ((op_a[30:23] >= 1) && (op_a[30:23] <= 254)) && ((op_b[30:23] >= 1) && (op_b[30:23] <= 254)) && ((op_c[30:23] >= 1) && (op_c[30:23] <= 254))) |-> (##(lat - 1) ((|(rs_pre_flushing)) == 1'b1) 
																															 ##1 ((rs_post_flushing[31:0] == rs_post_flushing_val) && (uf[1] == 1'b1)))); //UF = 1
	endproperty

	property fcov_round_w_output_flushing_no_fn(rst_w, op_w, vldi_w, rdyo_w, lat, vldo_w, op, rm_w, rm, rs_pre_flushing, rs_post_flushing, rs_post_flushing_val, uf, op_a, op_b, op_c);
		@(posedge clk) disable iff (rst_w)
			(((op_w == op) && vldi_w && rdyo_w && (rm_w == rm) && ((op_a[30:23] >= 1) && (op_a[30:23] <= 254)) && ((op_b[30:23] >= 1) && (op_b[     30:23] <= 254)) && ((op_c[30:23] >= 1) && (op_c[30:23] <= 254))) |-> (##(lat - 1) ((|(rs_pre_flushing)) == 1'b1) 
																															 ##1 ((rs_post_flushing[31:0] == rs_post_flushing_val) && (uf[1] == 1'b1)))); //UF = 1
	endproperty

// POSITIVE
`ifdef ENV_ARITH_EN
	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FADD_RNE_FN_0_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FADD), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FADD_RNE_FN_1_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FADD), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FADD_RNE_FN_1_RS_MIN_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FADD), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FADD_RTZ_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FADD), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FADD_RDN_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FADD), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FADD_RUP_RS_MIN_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FADD), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FADD_RMM_FN_0_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FADD), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FADD_RMM_FN_1_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FADD), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FADD_RMM_FN_1_RS_MIN_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FADD), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));


	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FSUB_RNE_FN_0_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FSUB), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FSUB_RNE_FN_1_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FSUB), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FSUB_RNE_FN_1_RS_MIN_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FSUB), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FSUB_RTZ_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FSUB), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FSUB_RDN_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FSUB), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FSUB_RUP_RS_MIN_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FSUB), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FSUB_RMM_FN_0_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FSUB), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FSUB_RMM_FN_1_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FSUB), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FSUB_RMM_FN_1_RS_MIN_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FSUB), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMUL_RNE_FN_0_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMUL), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMUL_RNE_FN_1_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMUL), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMUL_RNE_FN_1_RS_MIN_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMUL), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMUL_RTZ_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMUL), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMUL_RDN_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMUL), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMUL_RUP_RS_MIN_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMUL), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMUL_RMM_FN_0_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMUL), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMUL_RMM_FN_1_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMUL), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMUL_RMM_FN_1_RS_MIN_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMUL), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMADD_RNE_FN_0_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMADD), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMADD_RNE_FN_1_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMADD), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMADD_RNE_FN_1_RS_MIN_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMADD), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMADD_RTZ_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMADD), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMADD_RDN_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMADD), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMADD_RUP_RS_MIN_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMADD), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMADD_RMM_FN_0_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMADD), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMADD_RMM_FN_1_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMADD), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMADD_RMM_FN_1_RS_MIN_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMADD), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMSUB_RNE_FN_0_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMSUB), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMSUB_RNE_FN_1_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMSUB), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMSUB_RNE_FN_1_RS_MIN_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMSUB), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMSUB_RTZ_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMSUB), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMSUB_RDN_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMSUB), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMSUB_RUP_RS_MIN_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMSUB), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMSUB_RMM_FN_0_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMSUB), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMSUB_RMM_FN_1_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMSUB), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMSUB_RMM_FN_1_RS_MIN_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMSUB), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNADD_RNE_FN_0_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNADD), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNADD_RNE_FN_1_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNADD), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNADD_RNE_FN_1_RS_MIN_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNADD), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMNADD_RTZ_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNADD), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMNADD_RDN_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNADD), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMNADD_RUP_RS_MIN_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNADD), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNADD_RMM_FN_0_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNADD), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNADD_RMM_FN_1_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNADD), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNADD_RMM_FN_1_RS_MIN_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNADD), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNSUB_RNE_FN_0_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNSUB), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNSUB_RNE_FN_1_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNSUB), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNSUB_RNE_FN_1_RS_MIN_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNSUB), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMNSUB_RTZ_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNSUB), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMNSUB_RDN_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNSUB), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMNSUB_RUP_RS_MIN_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNSUB), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNSUB_RMM_FN_0_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNSUB), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNSUB_RMM_FN_1_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNSUB), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNSUB_RMM_FN_1_RS_MIN_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNSUB), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

`endif

`ifdef ENV_SPMATH_EN
	FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FDIV_RNE_FN_0_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FDIV), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FDIV_RNE_FN_1_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FDIV), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FDIV_RNE_FN_1_RS_MIN_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FDIV), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FDIV_RTZ_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FDIV), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FDIV_RDN_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FDIV), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FDIV_RUP_RS_MIN_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FDIV), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FDIV_RMM_FN_0_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FDIV), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FDIV_RMM_FN_1_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FDIV), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FDIV_RMM_FN_1_RS_MIN_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FDIV), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FSQRT_RNE_FN_0_RS_ZERO_P:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FSQRT), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FSQRT_RNE_FN_1_RS_ZERO_P:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FSQRT), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FSQRT_RNE_FN_1_RS_MIN_P:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FSQRT), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FSQRT_RTZ_RS_ZERO_P:
	//HP cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FSQRT), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FSQRT_RDN_RS_ZERO_P:
	//HP cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FSQRT), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FSQRT_RUP_RS_MIN_P:
	//HP cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FSQRT), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FSQRT_RMM_FN_0_RS_ZERO_P:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FSQRT), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FSQRT_RMM_FN_1_RS_ZERO_P:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FSQRT), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FSQRT_RMM_FN_1_RS_MIN_P:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FSQRT), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

`ifdef ENV_EXPLOG_EN
	FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FEXP_RNE_FN_0_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(30), .vldo_w(valid_o), .op(`FEXP), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FEXP_RNE_FN_1_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(30), .vldo_w(valid_o), .op(`FEXP), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FEXP_RNE_FN_1_RS_MIN_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(30), .vldo_w(valid_o), .op(`FEXP), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FEXP_RTZ_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(30), .vldo_w(valid_o), .op(`FEXP), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FEXP_RDN_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(30), .vldo_w(valid_o), .op(`FEXP), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FEXP_RUP_RS_MIN_P:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(30), .vldo_w(valid_o), .op(`FEXP), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FEXP_RMM_FN_0_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(30), .vldo_w(valid_o), .op(`FEXP), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FEXP_RMM_FN_1_RS_ZERO_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(30), .vldo_w(valid_o), .op(`FEXP), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FEXP_RMM_FN_1_RS_MIN_P:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(30), .vldo_w(valid_o), .op(`FEXP), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FLOG_RNE_FN_0_RS_ZERO_P:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(38), .vldo_w(valid_o), .op(`FLOG), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FLOG_RNE_FN_1_RS_ZERO_P:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(38), .vldo_w(valid_o), .op(`FLOG), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FLOG_RNE_FN_1_RS_MIN_P:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(38), .vldo_w(valid_o), .op(`FLOG), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FLOG_RTZ_RS_ZERO_P:
	//HP cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(38), .vldo_w(valid_o), .op(`FLOG), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FLOG_RDN_RS_ZERO_P:
	//HP cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(38), .vldo_w(valid_o), .op(`FLOG), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FLOG_RUP_RS_MIN_P:
	//HP cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(38), .vldo_w(valid_o), .op(`FLOG), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FLOG_RMM_FN_0_RS_ZERO_P:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(38), .vldo_w(valid_o), .op(`FLOG), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FLOG_RMM_FN_1_RS_ZERO_P:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(38), .vldo_w(valid_o), .op(`FLOG), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FLOG_RMM_FN_1_RS_MIN_P:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(38), .vldo_w(valid_o), .op(`FLOG), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h0080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));
`endif
`endif

// NEGATIVE
`ifdef ENV_ARITH_EN
	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FADD_RNE_FN_0_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FADD), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FADD_RNE_FN_1_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FADD), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FADD_RNE_FN_1_RS_MIN_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FADD), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FADD_RTZ_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FADD), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FADD_RDN_RS_MIN_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FADD), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FADD_RUP_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FADD), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FADD_RMM_FN_0_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FADD), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FADD_RMM_FN_1_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FADD), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FADD_RMM_FN_1_RS_MIN_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FADD), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));


	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FSUB_RNE_FN_0_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FSUB), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FSUB_RNE_FN_1_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FSUB), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FSUB_RNE_FN_1_RS_MIN_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FSUB), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FSUB_RTZ_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FSUB), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FSUB_RDN_RS_MIN_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FSUB), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FSUB_RUP_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FSUB), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FSUB_RMM_FN_0_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FSUB), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FSUB_RMM_FN_1_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FSUB), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FSUB_RMM_FN_1_RS_MIN_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FSUB), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMUL_RNE_FN_0_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMUL), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMUL_RNE_FN_1_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMUL), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMUL_RNE_FN_1_RS_MIN_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMUL), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMUL_RTZ_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMUL), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMUL_RDN_RS_MIN_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMUL), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMUL_RUP_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMUL), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMUL_RMM_FN_0_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMUL), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMUL_RMM_FN_1_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMUL), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMUL_RMM_FN_1_RS_MIN_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMUL), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMADD_RNE_FN_0_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMADD), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMADD_RNE_FN_1_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMADD), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMADD_RNE_FN_1_RS_MIN_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMADD), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMADD_RTZ_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMADD), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMADD_RDN_RS_MIN_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMADD), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMADD_RUP_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMADD), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMADD_RMM_FN_0_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMADD), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMADD_RMM_FN_1_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMADD), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMADD_RMM_FN_1_RS_MIN_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMADD), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMSUB_RNE_FN_0_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMSUB), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMSUB_RNE_FN_1_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMSUB), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMSUB_RNE_FN_1_RS_MIN_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMSUB), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMSUB_RTZ_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMSUB), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMSUB_RDN_RS_MIN_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMSUB), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMSUB_RUP_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMSUB), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMSUB_RMM_FN_0_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMSUB), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMSUB_RMM_FN_1_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMSUB), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMSUB_RMM_FN_1_RS_MIN_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMSUB), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNADD_RNE_FN_0_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNADD), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNADD_RNE_FN_1_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNADD), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNADD_RNE_FN_1_RS_MIN_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNADD), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMNADD_RTZ_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNADD), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMNADD_RDN_RS_MIN_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNADD), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMNADD_RUP_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNADD), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNADD_RMM_FN_0_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNADD), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNADD_RMM_FN_1_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNADD), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNADD_RMM_FN_1_RS_MIN_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNADD), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNSUB_RNE_FN_0_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNSUB), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNSUB_RNE_FN_1_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNSUB), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNSUB_RNE_FN_1_RS_MIN_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNSUB), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMNSUB_RTZ_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNSUB), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMNSUB_RDN_RS_MIN_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNSUB), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_ARITH_FMNSUB_RUP_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNSUB), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNSUB_RMM_FN_0_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNSUB), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNSUB_RMM_FN_1_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNSUB), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_ARITH_FMNSUB_RMM_FN_1_RS_MIN_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(4), .vldo_w(valid_o), .op(`FMNSUB), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_ARITH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_c_i)));

`endif

`ifdef ENV_SPMATH_EN
	FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FDIV_RNE_FN_0_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FDIV), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FDIV_RNE_FN_1_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FDIV), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FDIV_RNE_FN_1_RS_MIN_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FDIV), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FDIV_RTZ_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FDIV), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FDIV_RDN_RS_MIN_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FDIV), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FDIV_RUP_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FDIV), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FDIV_RMM_FN_0_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FDIV), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FDIV_RMM_FN_1_RS_ZERO_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FDIV), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FDIV_RMM_FN_1_RS_MIN_N:
	cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FDIV), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_b_i), .op_c(operand_b_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FSQRT_RNE_FN_0_RS_ZERO_N:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FSQRT), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FSQRT_RNE_FN_1_RS_ZERO_N:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FSQRT), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FSQRT_RNE_FN_1_RS_MIN_N:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FSQRT), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FSQRT_RTZ_RS_ZERO_N:
	//HP cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FSQRT), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FSQRT_RDN_RS_MIN_N:
	//HP cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FSQRT), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FSQRT_RUP_RS_ZERO_N:
	//HP cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FSQRT), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FSQRT_RMM_FN_0_RS_ZERO_N:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FSQRT), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FSQRT_RMM_FN_1_RS_ZERO_N:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FSQRT), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FSQRT_RMM_FN_1_RS_MIN_N:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(16), .vldo_w(valid_o), .op(`FSQRT), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

`ifdef ENV_EXPLOG_EN
	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FEXP_RNE_FN_0_RS_ZERO_N:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(30), .vldo_w(valid_o), .op(`FEXP), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FEXP_RNE_FN_1_RS_ZERO_N:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(30), .vldo_w(valid_o), .op(`FEXP), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FEXP_RNE_FN_1_RS_MIN_N:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(30), .vldo_w(valid_o), .op(`FEXP), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FEXP_RTZ_RS_ZERO_N:
	//HP cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(30), .vldo_w(valid_o), .op(`FEXP), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FEXP_RDN_RS_MIN_N:
	//HP cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(30), .vldo_w(valid_o), .op(`FEXP), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FEXP_RUP_RS_ZERO_N:
	//HP cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(30), .vldo_w(valid_o), .op(`FEXP), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FEXP_RMM_FN_0_RS_ZERO_N:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(30), .vldo_w(valid_o), .op(`FEXP), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FEXP_RMM_FN_1_RS_ZERO_N:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(30), .vldo_w(valid_o), .op(`FEXP), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FEXP_RMM_FN_1_RS_MIN_N:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(30), .vldo_w(valid_o), .op(`FEXP), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FLOG_RNE_FN_0_RS_ZERO_N:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(38), .vldo_w(valid_o), .op(`FLOG), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FLOG_RNE_FN_1_RS_ZERO_N:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(38), .vldo_w(valid_o), .op(`FLOG), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FLOG_RNE_FN_1_RS_MIN_N:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(38), .vldo_w(valid_o), .op(`FLOG), .rm_w(rm_i), .rm(`RNE), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FLOG_RTZ_RS_ZERO_N:
	//HP cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(38), .vldo_w(valid_o), .op(`FLOG), .rm_w(rm_i), .rm(`RNE), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FLOG_RDN_RS_MIN_N:
	//HP cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(38), .vldo_w(valid_o), .op(`FLOG), .rm_w(rm_i), .rm(`RDN), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_NO_FN_SPMATH_FLOG_RUP_RS_ZERO_N:
	//HP cover property(fcov_round_w_output_flushing_no_fn(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(38), .vldo_w(valid_o), .op(`FLOG), .rm_w(rm_i), .rm(`RUP), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FLOG_RMM_FN_0_RS_ZERO_N:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(38), .vldo_w(valid_o), .op(`FLOG), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b0), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FLOG_RMM_FN_1_RS_ZERO_N:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(38), .vldo_w(valid_o), .op(`FLOG), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_0), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8000_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));

	//HP FCOV_ROUND_W_OUTPUT_FLUSHING_SPMATH_FLOG_RMM_FN_1_RS_MIN_N:
	//HP cover property(fcov_round_w_output_flushing(.rst_w(rst), .op_w(op_i), .vldi_w(valid_i), .rdyo_w(ready_o), .lat(38), .vldo_w(valid_o), .op(`FLOG), .rm_w(rm_i), .rm(`RMM), .fn_w(fn_i), .fn(1'b1), .rs_pre_flushing(`RS_PRE_FLUSHING_SPMATH_1), .rs_post_flushing(result_o), .rs_post_flushing_val(32'h8080_0000), .uf(fflags_o), .op_a(operand_a_i), .op_b(operand_a_i), .op_c(operand_a_i)));
`endif
`endif
