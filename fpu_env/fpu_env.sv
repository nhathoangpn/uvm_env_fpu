//==================================================================================================
// Owner:    Hoang Pham
// Filename: fpu_env
// History:  2019.06.21 Create new version
//==================================================================================================

class fpu_env extends uvm_env;
	`uvm_component_utils(fpu_env)

	fpu_env_cfg   m_fpu_env_cfg;
	fpu_agent_cfg m_fpu_agent_cfg;

	fpu_agent m_fpu_agent;
	fpu_fcov  m_fpu_fcov;
	fpu_scb   m_fpu_scb;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if (!uvm_config_db #(fpu_env_cfg)::get(this, "", "fpu_env_cfg", m_fpu_env_cfg))
			`uvm_fatal("ENV_CONFIG", "cannot get fpu_env_cfg from config database")

		m_fpu_agent_cfg = m_fpu_env_cfg.m_fpu_agent_cfg;

		uvm_config_db #(fpu_agent_cfg)::set(this, "m_fpu_agent*", "fpu_agent_cfg", m_fpu_agent_cfg);

		m_fpu_agent = fpu_agent::type_id::create("m_fpu_agent", this);

		if (m_fpu_env_cfg.has_functional_coverage) begin
			m_fpu_fcov = fpu_fcov::type_id::create("m_fpu_fcov", this);
		end

		if (m_fpu_env_cfg.has_scoreboard) begin
			m_fpu_scb = fpu_scb::type_id::create("m_fpu_scb", this);
		end
	endfunction

	function void connect_phase(uvm_phase phase);
		if (m_fpu_env_cfg.has_functional_coverage) begin
			m_fpu_agent.fcov_seq_ap.connect(m_fpu_fcov.fcov_seq_exp);
			m_fpu_agent.fcov_seq_grs_ap.connect(m_fpu_fcov.fcov_seq_grs_exp);
			m_fpu_agent.fcov_mon_ap.connect(m_fpu_fcov.fcov_mon_exp);
			m_fpu_agent.fcov_mon_grs_ap.connect(m_fpu_fcov.fcov_mon_grs_exp);
		end

		if (m_fpu_env_cfg.has_scoreboard) begin
			m_fpu_agent.scb_seq_ap.connect(m_fpu_scb.scb_seq_exp);
			m_fpu_agent.scb_mon_ap.connect(m_fpu_scb.scb_mon_exp);
		end
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
	endfunction
endclass
