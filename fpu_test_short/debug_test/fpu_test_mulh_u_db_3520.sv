class fpu_test_mulh_u_db_3520 extends fpu_test_base;
	`uvm_component_utils(fpu_test_mulh_u_db_3520)

	`include "../fpu_top/fpu_def.svh"

	fpu_seq_base seq_sdirect;
	fpu_seq_base seq_final;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_top.set_timeout(1000ns, 1);
	endfunction

	task run_phase(uvm_phase phase);
		phase.phase_done.set_drain_time(this, 110);
		phase.raise_objection(this, {get_name, "run_phase starts"});

		m_fpu_agent_cfg.fpu_vif.rst_gen_direct(1, 10);

		seq_sdirect = fpu_seq_base::type_id::create("seq_sdirect");
		seq_final   = fpu_seq_base::type_id::create("seq_final");

		if (!seq_sdirect.randomize() with
			{sub_num_seq_item == 1;
			 sqb_valid_i == 1;
			 sqb_op_i == `MULH_U;
			 sqb_operand_a_i == 32'h315D_0C0B;
			 sqb_operand_b_i == 32'hC70C_CA7A;
			 sqb_operand_c_i == 32'h0000_0000;
			 sqb_rm_i == `RTZ;
			 sqb_fn_i == 0;
			 sqb_user_i == 8'h00;
			 sqb_num_wait_clk == 1;
			 sqb_test_final == 0;
			 sqb_handshake_i == 1;})
`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

		seq_sdirect.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

		if (!seq_final.randomize() with
			{sub_num_seq_item == 1;
			 sqb_num_wait_clk == 1;
			 sqb_test_final   == 1;})
`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

		seq_final.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

		phase.drop_objection(this, {get_name, "run_phase finishes"});
	endtask
endclass
