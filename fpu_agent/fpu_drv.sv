//==================================================================================================
// Owner:    Hoang Pham
// Filename: fpu_drv
// History:  2019.06.21 Create new version
//==================================================================================================

class fpu_drv extends uvm_driver #(fpu_seq_item);
	`uvm_component_utils(fpu_drv)

	fpu_agent_cfg m_fpu_agent_cfg;
	fpu_ft_opts   m_fpu_ft_opts;

	virtual fpu_if_bfm fpu_vif;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(fpu_agent_cfg)::get(this, "", "fpu_agent_cfg", m_fpu_agent_cfg))
			`uvm_fatal("DRV_CONFIG", "cannot get fpu_agent_cfg from config database")

		fpu_vif = m_fpu_agent_cfg.fpu_vif;

		if (!uvm_config_db #(fpu_ft_opts)::get(this, "", "fpu_ft_opts", m_fpu_ft_opts))
		 	`uvm_fatal("DRV_CONFIG", "cannot get fpu_ft_opts from config database")
	endfunction

	task run_phase(uvm_phase phase);
		fpu_seq_item req_item;

		`uvm_info(get_name(), "run_phase starts", UVM_FULL)

		forever begin
			seq_item_port.try_next_item(req_item);
			if (req_item != null) begin
				`uvm_info(get_name(),
									$sformatf("\nreq_item = %0h %0h %0h %0h %0h",
									req_item.op_i, req_item.operand_a_i, req_item.operand_b_i, req_item.operand_c_i, req_item.rm_i), UVM_FULL)

				if (req_item.test_final) begin
					`uvm_info(get_name(), "test_final", UVM_FULL)
					seq_item_port.item_done();
					break;
				end

				fpu_vif.drive_bfm(req_item);
				`uvm_info(get_name(), "drive_bfm() finishes", UVM_FULL)

				if (!req_item.valid_i) begin
					m_fpu_ft_opts.num_iseq_item = m_fpu_ft_opts.num_iseq_item + 1;
				end

				if (req_item.valid_i & (!req_item.handshake_i) & (!fpu_vif.m_fpu_if.ready_o)) begin
					m_fpu_ft_opts.num_not_handshake = m_fpu_ft_opts.num_not_handshake + 1;
				end

				m_fpu_ft_opts.num_seq_item = m_fpu_ft_opts.num_seq_item + 1;

				seq_item_port.item_done();
				`uvm_info(get_name(), "item_done() finishes", UVM_FULL)
			end else begin
				`uvm_info(get_name(), $sformatf("\nitem null"), UVM_FULL)
				@(posedge fpu_vif.m_fpu_if.clk);
				fpu_vif.m_fpu_if.valid_i <= 0;
			end
		end

		fpu_vif.drive_ctrl_i(0);
		`uvm_info(get_name(), "run_phase finishes", UVM_FULL)
	endtask
endclass
