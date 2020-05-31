//==================================================================================================
// Owner:    Hoang Pham
// Filename: fpu_seq_item
// History:  2019.06.21 Create new version
//==================================================================================================

class fpu_seq_item extends uvm_sequence_item;
	`uvm_object_utils(fpu_seq_item)

	`include "../fpu_top/fpu_def.svh"

	rand logic [`VLDI_W - 1 : 0] valid_i;
	rand logic [`OP_W   - 1 : 0] op_i;
	rand logic [`OPD_W  - 1 : 0] operand_a_i;
	rand logic [`OPD_W  - 1 : 0] operand_b_i;
	rand logic [`OPD_W  - 1 : 0] operand_c_i;
	rand logic [`RM_W   - 1 : 0] rm_i;
	rand logic [`FN_W   - 1 : 0] fn_i;
	rand logic [`USRI_W - 1 : 0] user_i;

			 logic	                 rst;
			 logic [`RDY_W - 1 : 0]  ready_o;
			 logic [`VLDO_W - 1 : 0] valid_o;

	rand int num_wait_clk;
	rand bit test_final;
	rand bit handshake_i;

	function new(string name = "fpu_seq_item");
		super.new(name);
	endfunction
endclass
