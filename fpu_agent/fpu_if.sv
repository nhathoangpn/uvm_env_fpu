//==================================================================================================
// Owner:    Hoang Pham
// Filename: fpu_if
// History:  2019.06.21 Create new version
//==================================================================================================

interface fpu_if;
	`include "../fpu_top/fpu_def.svh"
	`include "fpu_bb_sva.svh"

	bit                     clk;
	bit                     rst;
	logic [`VLDI_W - 1 : 0] valid_i;
	logic [`OP_W   - 1 : 0] op_i;
	logic [`OPD_W  - 1 : 0] operand_a_i;
	logic [`OPD_W  - 1 : 0] operand_b_i;
	logic [`OPD_W  - 1 : 0] operand_c_i;
	logic [`RM_W   - 1 : 0] rm_i;
	logic [`FN_W   - 1 : 0] fn_i;
	logic [`USRI_W - 1 : 0] user_i;

	logic [`STLL_W - 1 : 0] stall_i;

	logic [`RDY_W  - 1 : 0] ready_o;
	logic [`VLDO_W - 1 : 0] valid_o;
	logic [`RS_W   - 1 : 0] result_o;
	logic [`FF_W   - 1 : 0] fflags_o;
	logic [`IF_W   - 1 : 0] iflags_o;
	logic [`ERR_W  - 1 : 0] error_o;
	logic [`USRO_W - 1 : 0] user_o;

	//Internal signal
	logic		valid_o_arith;
	logic		guard_bit_arith;
	logic		round_bit_arith;
	logic		sticky_bit_arith;
	logic		valid_o_spmath_div_sqrt;
	logic		valid_o_spmath_log_exp;
	logic		guard_bit_spmath;
	logic		round_bit_spmath;
	logic		sticky_bit_spmath;
	logic		valid_o_cmpcnv_i2f;
	logic		guard_bit_cmpcnv_i2f;
	logic		round_bit_cmpcnv_i2f;
	logic		sticky_bit_cmpcnv_i2f;
	logic		valid_o_cmpcnv_f2i;
	logic		fraction_0_cmpcnv_f2i;
	logic		fraction_1_cmpcnv_f2i;

	logic	[3:0]	skid_stt;

	real clk_period = 1ns;

	always #(clk_period/2) clk = !clk;

	initial begin
		rst         <= 1'b0;
		valid_i     <= {`VLDI_W{1'b0}};
		op_i        <= {`OP_W{1'b0}};
		operand_a_i <= {`OPD_W{1'b0}};
		operand_b_i <= {`OPD_W{1'b0}};
		operand_c_i <= {`OPD_W{1'b0}};
		rm_i        <= {`RM_W{1'b0}};
		fn_i        <= {`FN_W{1'b0}};
		user_i      <= {`USRI_W{1'b0}};
		stall_i     <= {`STLL_W{1'b0}};
	end

endinterface 
