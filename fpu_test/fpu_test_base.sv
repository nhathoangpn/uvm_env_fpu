//==================================================================================================
// Owner:    Hoang Pham
// Filename: fpu_test_base
// History:  2019.06.21 Create new version
//==================================================================================================

class fpu_test_base extends uvm_test;
	`uvm_component_utils(fpu_test_base)

	fpu_env       m_fpu_env;
	fpu_env_cfg   m_fpu_env_cfg;
	fpu_agent_cfg m_fpu_agent_cfg;
	fpu_ft_opts   m_fpu_ft_opts;

	function new(string name, uvm_component parent);
		super.new(name, parent);
		uvm_top.set_timeout(15ms, 1);
	endfunction

	virtual function void configure_fpu_agent(fpu_agent_cfg cfg);
		cfg.active                  = UVM_ACTIVE;
		cfg.has_functional_coverage = 1;
		cfg.has_scoreboard          = 1;
	endfunction

	virtual function void configure_fpu_env(fpu_env_cfg cfg);
		cfg.active                  = UVM_ACTIVE;
		cfg.has_functional_coverage = 1;
		cfg.has_scoreboard          = 1;
	endfunction

	function void build_phase(uvm_phase phase);
		m_fpu_env_cfg   = fpu_env_cfg::type_id::create("m_fpu_env_cfg");
		m_fpu_agent_cfg = fpu_agent_cfg::type_id::create("m_fpu_agent_cfg");

		configure_fpu_env(m_fpu_env_cfg);
		configure_fpu_agent(m_fpu_agent_cfg);

		m_fpu_env_cfg.m_fpu_agent_cfg = m_fpu_agent_cfg;

		if (!uvm_config_db #(virtual fpu_if_bfm)::get(this, "", "fpu_vif", m_fpu_agent_cfg.fpu_vif))
			`uvm_fatal("TEST_CONFIG", "cannot get virtual interface from config database")

		uvm_config_db #(fpu_env_cfg)::set(this, "*", "fpu_env_cfg", m_fpu_env_cfg);

		if (!uvm_config_db #(fpu_ft_opts)::get(null, "", "fpu_ft_opts", m_fpu_ft_opts))
			`uvm_fatal("TEST_CONFIG", "cannot get fpu_ft_opts from config database")

		m_fpu_env = fpu_env::type_id::create("m_fpu_env", this);
	endfunction
endclass
