//==================================================================================================
// Owner:    Hoang Pham
// Filename: fpu_mon
// History:  2019.06.21 Create new version
//==================================================================================================

class fpu_mon extends uvm_monitor;
	`uvm_component_utils(fpu_mon)

	uvm_analysis_port #(fpu_seq_item) scb_seq_ap;
	uvm_analysis_port #(fpu_mon_item) scb_mon_ap;
	uvm_analysis_port #(fpu_seq_item) fcov_seq_ap;
	uvm_analysis_port #(fpu_seq_item) fcov_seq_grs_ap;
	uvm_analysis_port #(fpu_mon_item) fcov_mon_ap;
	uvm_analysis_port #(fpu_mon_item) fcov_mon_grs_ap;

	fpu_agent_cfg m_fpu_agent_cfg;
	fpu_ft_opts   m_fpu_ft_opts;

	virtual fpu_if_bfm fpu_vif;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if (!uvm_config_db #(fpu_agent_cfg)::get(this, "", "fpu_agent_cfg", m_fpu_agent_cfg))
			`uvm_fatal("MON_CONFIG", "cannot get fpu_agent_cfg from config database")

		if (!uvm_config_db #(fpu_ft_opts)::get(this, "", "fpu_ft_opts", m_fpu_ft_opts))
		 	`uvm_fatal("DRV_CONFIG", "cannot get fpu_ft_opts from config database")

		fpu_vif = m_fpu_agent_cfg.fpu_vif;

		scb_seq_ap  = new("scb_seq_ap",  this);
		scb_mon_ap  = new("scb_mon_ap",  this);
		fcov_seq_ap = new("fcov_seq_ap", this);
		fcov_seq_grs_ap = new("fcov_seq_grs_ap", this);
		fcov_mon_ap = new("fcov_mon_ap", this);
		fcov_mon_grs_ap = new("fcov_mon_grs_ap", this);

		fpu_vif.mon_stdin = this;
	endfunction

	task run_phase(uvm_phase phase);
		`uvm_info(get_name(), "run_phase starts", UVM_FULL)

		fork
			fpu_vif.capture_bfm_i();
			fpu_vif.capture_bfm_o();
		join

		`uvm_info(get_name(), "run_phase finishes", UVM_FULL)
	endtask

	function void broadcast_seq_item(fpu_seq_item seq_item);
		scb_seq_ap.write(seq_item);
		fcov_seq_ap.write(seq_item);
	endfunction
	function void broadcast_seq_item_grs(fpu_seq_item seq_item_grs);
		fcov_seq_grs_ap.write(seq_item_grs);
	endfunction


	function void broadcast_mon_item(fpu_mon_item mon_item);
		scb_mon_ap.write(mon_item);
		fcov_mon_ap.write(mon_item);
	endfunction
	function void broadcast_mon_item_grs(fpu_mon_item mon_item_grs);
		fcov_mon_grs_ap.write(mon_item_grs);
	endfunction
endclass
