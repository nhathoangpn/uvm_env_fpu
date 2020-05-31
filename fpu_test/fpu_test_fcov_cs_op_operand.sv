//==================================================================================================
// Owner:    Hoang Pham
// Filename:
// History:  2019.06.21 Create new version
//==================================================================================================

class fpu_test_fcov_cs_op_operand extends fpu_test_base;
	`uvm_component_utils(fpu_test_fcov_cs_op_operand)

	`include "../fpu_top/fpu_def.svh"

	fpu_seq_base seq_srandom;
	fpu_seq_base seq_final;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		phase.phase_done.set_drain_time(this, 110);
		phase.raise_objection(this, {get_name, "run_phase starts"});

		m_fpu_agent_cfg.fpu_vif.rst_gen_direct(1, 10);

		seq_srandom = fpu_seq_base::type_id::create("seq_srandom");
		seq_final   = fpu_seq_base::type_id::create("seq_final");

//==================================================================================================
//bins flog_03
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FLOG;
				 sqb_operand_a_i  == 32'h3F80_0000;
				 sqb_operand_b_i  == 32'h0000_0000;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i         inside{[0:1]};
		 		 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
//bins feq_02
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FEQ;
				 sqb_operand_a_i  == 32'h3F81_2345;
				 sqb_operand_b_i  == 32'h3F81_2345;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i         inside{[0:1]};
		 		 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
//bins feq_12
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FEQ;
				 sqb_operand_a_i  == 32'hBF81_2345;
				 sqb_operand_b_i  == 32'hBF81_2345;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i         inside{[0:1]};
		 		 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
//bins fne_01
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FNE;
				 sqb_operand_a_i  == 32'h3F81_2345;
				 sqb_operand_b_i  == 32'h3F81_2345;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i         inside{[0:1]};
		 		 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
//bins fne_11
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FNE;
				 sqb_operand_a_i  == 32'hBF81_2345;
				 sqb_operand_b_i  == 32'hBF81_2345;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i         inside{[0:1]};
		 		 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
//bins fadd_02
		for (int i = 0; i < 20; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FADD;
				 sqb_operand_a_i  == 32'h7F7F_FFFF;
				 sqb_operand_b_i  == 32'h7F7F_FFFF;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i         inside{[0:1]};
		 		 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
//bins fsub_05
		for (int i = 0; i < 20; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FSUB;
				 sqb_operand_a_i  == 32'h7F7F_FFFF;
				 sqb_operand_b_i  == 32'hFF7F_FFFF;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i         inside{[0:1]};
		 		 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
//bins fsub_13
		for (int i = 0; i < 20; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FSUB;
				 sqb_operand_a_i  == 32'hFF7F_FFFF;
				 sqb_operand_b_i  == 32'h7F7F_FFFF;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
				 sqb_fn_i         inside{[0:1]};
		 		 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		if (!seq_final.randomize() with
			{sub_num_seq_item == 1;
			 sqb_num_wait_clk == 1;
			 sqb_test_final   == 1;})
		`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

		seq_final.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

		phase.drop_objection(this, {get_name, "run_phase finishes"});
	endtask
endclass
