//==================================================================================================
// Owner:    Hoang Pham
// Filename: fpu_mon_item
// History:  2019.06.21 Create new version
//==================================================================================================

class fpu_mon_item extends uvm_sequence_item;
	`uvm_object_utils(fpu_mon_item)

	`include "../fpu_top/fpu_def.svh"

	logic [`RS_W   - 1 : 0] result_o;
	logic [`FF_W   - 1 : 0] fflags_o;
	logic [`IF_W   - 1 : 0] iflags_o;
	logic [`ERR_W  - 1 : 0] error_o;
	logic [`USRO_W - 1 : 0] user_o;

	logic [`STLL_W - 1 : 0] stall_i;
	logic 									rst;

	//Internal signal
	logic			valid_o_arith;
	logic			guard_bit_arith;
	logic			round_bit_arith;
	logic			sticky_bit_arith;
	logic			valid_o_spmath_div_sqrt;
	logic			valid_o_spmath_log_exp;
	logic			guard_bit_spmath;
	logic			round_bit_spmath;
	logic			sticky_bit_spmath;
	logic			valid_o_cmpcnv_i2f;
	logic			guard_bit_cmpcnv_i2f;
	logic			round_bit_cmpcnv_i2f;
	logic			sticky_bit_cmpcnv_i2f;
	logic			valid_o_cmpcnv_f2i;
	logic			fraction_0_cmpcnv_f2i;
	logic			fraction_1_cmpcnv_f2i;

	function new(string name = "fpu_mon_item");
		super.new(name);
	endfunction
endclass
