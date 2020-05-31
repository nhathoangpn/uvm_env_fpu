//==================================================================================================
// Owner:    Hoang Pham
// Filename: ft_opts
// History:  2019.06.27 Create new version
//==================================================================================================

class fpu_ft_opts extends uvm_object;
	int num_seq_item      = 0;
	int num_iseq_item     = 0;
	int num_not_handshake = 0;

	function new(string name);
		super.new(name);
	endfunction
endclass
