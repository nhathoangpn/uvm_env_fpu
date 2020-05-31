//==================================================================================================
// Owner:    Hoang Pham
// Filename: tb_top
// History:  2019.06.21 Create new version
//==================================================================================================

module tb_top;
	`include "fpu_def.svh"

	import uvm_pkg::*;
	import fpu_test_pkg::*;
	import fpu_agent_pkg::fpu_ft_opts;

	fpu_if     FPU_IF();
	fpu_if_bfm fpu_vif(FPU_IF);

	fpu_ft_opts m_fpu_ft_opts;

	fpu_top #(.P_FPU_ARITH_EN(`P_FPU_ARITH_EN),
						.P_FPU_CMPCNV_EN(`P_FPU_CMPCNV_EN),
						.P_FPU_SPMATH_EN(`P_FPU_SPMATH_EN),
						.P_FPU_SPMATH_EXPLOG_EN(`P_FPU_SPMATH_EXPLOG_EN))
	DUT (
		.clk					(FPU_IF.clk),
		.rst					(FPU_IF.rst),
		.valid_i			(FPU_IF.valid_i),
		.ready_o			(FPU_IF.ready_o),
		.op_i					(FPU_IF.op_i),
		.operand_a_i	(FPU_IF.operand_a_i),
		.operand_b_i	(FPU_IF.operand_b_i),
		.operand_c_i	(FPU_IF.operand_c_i),
		.rm_i					(FPU_IF.rm_i),
		.fn_i					(FPU_IF.fn_i),
		.user_i				(FPU_IF.user_i),
		.valid_o			(FPU_IF.valid_o),
		.result_o			(FPU_IF.result_o),
		.fflags_o			(FPU_IF.fflags_o),
		.iflags_o			(FPU_IF.iflags_o),
		.error_o			(FPU_IF.error_o),
		.user_o				(FPU_IF.user_o),
		.stall_i			(FPU_IF.stall_i)
		);

	`ifdef P_FPU_ARITH_EN_1
		assign	FPU_IF.valid_o_arith			=	DUT.arith_en.i_arith.i_ctl_stg3.valid_s3_o;
		assign	FPU_IF.guard_bit_arith		=	DUT.arith_en.i_arith.i_norm_round.w_guard_bit;
		assign	FPU_IF.round_bit_arith		=	DUT.arith_en.i_arith.i_norm_round.w_round_bit;
		assign	FPU_IF.sticky_bit_arith		=	DUT.arith_en.i_arith.i_norm_round.w_sticky_bit;
	`endif
	`ifdef P_FPU_SPMATH_EN_1
		`ifdef P_FPU_SPMATH_EXPLOG_EN_1
			//assign	FPU_IF.valid_o_spmath_div_sqrt	=	DUT.spmath_en.i_smath.spmath_explog_en.i_sm_round_norm_flg.valid_div_sqrt_s2_i;
			//assign	FPU_IF.valid_o_spmath_log_exp		=	DUT.spmath_en.i_smath.spmath_explog_en.i_sm_round_norm_flg.valid_log_exp_s2_i;
			assign	FPU_IF.valid_o_spmath_div_sqrt	=	DUT.spmath_en.i_smath.spmath_explog_en.i_sm_round_norm_flg.w_fdiv_fsqrt;
			assign	FPU_IF.valid_o_spmath_log_exp		=	DUT.spmath_en.i_smath.spmath_explog_en.i_sm_round_norm_flg.w_fexp_flog;
			assign	FPU_IF.guard_bit_spmath					=	DUT.spmath_en.i_smath.spmath_explog_en.i_sm_round_norm_flg.w_guard_bit;
			assign	FPU_IF.round_bit_spmath					=	DUT.spmath_en.i_smath.spmath_explog_en.i_sm_round_norm_flg.w_round_bit;
			assign	FPU_IF.sticky_bit_spmath				=	DUT.spmath_en.i_smath.spmath_explog_en.i_sm_round_norm_flg.w_sticky_bit;
		`endif
		`ifdef P_FPU_SPMATH_EXPLOG_EN_0
			//assign	FPU_IF.valid_o_spmath_div_sqrt	=	DUT.spmath_en.i_smath.spmath_explog_dis.i_sm_round_norm_flg.valid_div_sqrt_s2_i;
			assign	FPU_IF.valid_o_spmath_div_sqrt	=	DUT.spmath_en.i_smath.spmath_explog_dis.i_sm_round_norm_flg.w_fdiv_fsqrt;
			assign	FPU_IF.guard_bit_spmath					=	DUT.spmath_en.i_smath.spmath_explog_dis.i_sm_round_norm_flg.w_guard_bit;
			assign	FPU_IF.round_bit_spmath					=	DUT.spmath_en.i_smath.spmath_explog_dis.i_sm_round_norm_flg.w_round_bit;
			assign	FPU_IF.sticky_bit_spmath				=	DUT.spmath_en.i_smath.spmath_explog_dis.i_sm_round_norm_flg.w_sticky_bit;
		`endif
	`endif
	`ifdef P_FPU_CMPCNV_EN_1
		assign	FPU_IF.valid_o_cmpcnv_i2f			=	DUT.cmpcnv_en.i_cmpcnv.i_co_round.i2f_valid_i;
		assign	FPU_IF.guard_bit_cmpcnv_i2f		=	DUT.cmpcnv_en.i_cmpcnv.i_co_round.i2f_guard_i;
		assign	FPU_IF.round_bit_cmpcnv_i2f		=	DUT.cmpcnv_en.i_cmpcnv.i_co_round.i2f_round_i;
		assign	FPU_IF.sticky_bit_cmpcnv_i2f	=	DUT.cmpcnv_en.i_cmpcnv.i_co_round.i2f_sticky_i;
		assign	FPU_IF.valid_o_cmpcnv_f2i			=	DUT.cmpcnv_en.i_cmpcnv.i_co_round.f2i_valid_i;
		assign	FPU_IF.fraction_0_cmpcnv_f2i	=	DUT.cmpcnv_en.i_cmpcnv.i_co_round.w_fraction_f2i_vd[0];
		assign	FPU_IF.fraction_1_cmpcnv_f2i	=	DUT.cmpcnv_en.i_cmpcnv.i_co_round.w_fraction_f2i_vd[1];
	`endif

	assign FPU_IF.skid_stt[1:0] = DUT.i_packed.i_skid_buf_ctrlpath.r_state;
	assign FPU_IF.skid_stt[3:2] = DUT.i_packed.i_skid_buf_ctrlpath.w_state_next;

	initial begin
		m_fpu_ft_opts = new("m_fpu_ft_opts");

		uvm_config_db #(virtual fpu_if_bfm)::set(null, "uvm_test_top", "fpu_vif", fpu_vif);
		uvm_config_db #(fpu_ft_opts)::set(null, "*", "fpu_ft_opts", m_fpu_ft_opts);

		run_test();
	end

	`ifdef VPD
		initial begin
			$vcdpluson;
			$vcdplusmemon;
		end
	`endif

endmodule
