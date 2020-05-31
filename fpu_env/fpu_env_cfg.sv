//==================================================================================================
// Owner:    Hoang Pham
// Filename: fpu_env_cfg
// History:  2019.06.21 Create new version
//==================================================================================================

class fpu_env_cfg extends uvm_object;
	`uvm_object_utils(fpu_env_cfg)

	uvm_active_passive_enum active = UVM_ACTIVE;
	bit has_functional_coverage    = 1;
	bit has_scoreboard             = 1;

	fpu_agent_cfg m_fpu_agent_cfg;

	function new(string name = "fpu_env_cfg");
		super.new(name);
	endfunction
endclass
