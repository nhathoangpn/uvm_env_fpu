//==================================================================================================
// Owner:    Hoang Pham
// Filename: fpu_sqr
// History:  2019.06.21 Create new version
//==================================================================================================

class fpu_sqr extends uvm_sequencer #(fpu_seq_item);
	`uvm_component_utils(fpu_sqr)

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

endclass