//==================================================================================================
// Owner:    Hoang Pham
// Filename: fpu_agent
// History:  2019.06.21 Create new version
//==================================================================================================

class fpu_agent extends uvm_agent;
	`uvm_component_utils(fpu_agent)

	fpu_agent_cfg m_fpu_agent_cfg;

	fpu_drv m_fpu_drv;
	fpu_mon m_fpu_mon;
	fpu_sqr m_fpu_sqr;

	uvm_analysis_port #(fpu_seq_item) scb_seq_ap;
	uvm_analysis_port #(fpu_mon_item) scb_mon_ap;
	uvm_analysis_port #(fpu_seq_item) fcov_seq_ap;
	uvm_analysis_port #(fpu_seq_item) fcov_seq_grs_ap;
	uvm_analysis_port #(fpu_mon_item) fcov_mon_ap;
	uvm_analysis_port #(fpu_mon_item) fcov_mon_grs_ap;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if (!uvm_config_db #(fpu_agent_cfg)::get(this, "", "fpu_agent_cfg", m_fpu_agent_cfg))
			`uvm_fatal("AGENT_CONFIG", "cannot get fpu_agent_cfg from config database")

		if (m_fpu_agent_cfg.active == UVM_ACTIVE) begin
			m_fpu_drv = fpu_drv::type_id::create("m_fpu_drv", this);
			m_fpu_sqr = fpu_sqr::type_id::create("m_fpu_sqr", this);
		end

		m_fpu_mon = fpu_mon::type_id::create("m_fpu_mon", this);

		if (m_fpu_agent_cfg.has_functional_coverage) begin
			fcov_seq_ap = new("fcov_seq_ap", this);
			fcov_seq_grs_ap = new("fcov_seq_grs_ap", this);
			fcov_mon_ap = new("fcov_mon_ap", this);
			fcov_mon_grs_ap = new("fcov_mon_grs_ap", this);
		end

		if (m_fpu_agent_cfg.has_scoreboard) begin
			scb_seq_ap = new("scb_seq_ap", this);
			scb_mon_ap = new("scb_mon_ap", this);
		end
	endfunction

	function void connect_phase(uvm_phase phase);
		if (m_fpu_agent_cfg.active == UVM_ACTIVE) begin
			m_fpu_drv.seq_item_port.connect(m_fpu_sqr.seq_item_export);
		end

		if (m_fpu_agent_cfg.has_functional_coverage) begin
			m_fpu_mon.fcov_seq_ap.connect(fcov_seq_ap);
			m_fpu_mon.fcov_seq_grs_ap.connect(fcov_seq_grs_ap);
			m_fpu_mon.fcov_mon_ap.connect(fcov_mon_ap);
			m_fpu_mon.fcov_mon_grs_ap.connect(fcov_mon_grs_ap);
		end

		if (m_fpu_agent_cfg.has_scoreboard) begin
			m_fpu_mon.scb_seq_ap.connect(scb_seq_ap);
			m_fpu_mon.scb_mon_ap.connect(scb_mon_ap);
		end
	endfunction
endclass
