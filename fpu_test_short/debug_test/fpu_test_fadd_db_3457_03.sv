//==================================================================================================
// Owner:    Toan Vu
// Filename: fpu_test_fadd_db_3457_03.sv
// History:  2019.09.24 Create new version
//==================================================================================================

class fpu_test_fadd_db_3457_03 extends fpu_test_base;
	`uvm_component_utils(fpu_test_fadd_db_3457_03)

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
			 sqb_op_i == `FADD;
			 sqb_operand_a_i == 32'h87fe785a;
			 sqb_operand_b_i == 32'h08ff1f0e;
			 sqb_operand_c_i == 32'h08bf80f7;
			 sqb_rm_i == `RNE;
			 sqb_fn_i == 1;
			 //sqb_user_i == 8'h00;
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
