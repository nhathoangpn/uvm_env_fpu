//==================================================================================================
// Owner:    Hoang Pham
// Filename: fpu_agent_cfg
// History:  2019.06.21 Create new version
//==================================================================================================

class fpu_agent_cfg extends uvm_object;
	`uvm_object_utils(fpu_agent_cfg)

	uvm_active_passive_enum active = UVM_ACTIVE;
	bit has_functional_coverage    = 1;
	bit has_scoreboard             = 1;

	virtual fpu_if_bfm fpu_vif;

	function new(string name = "fpu_agent_cfg");
		super.new(name);
	endfunction
endclass
