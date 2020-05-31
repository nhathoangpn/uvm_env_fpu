//==================================================================================================
// Owner:    Hoang Pham
// Filename:
// History:  2019.06.21 Create new version
//==================================================================================================

class fpu_test_fcov_round_w_output_flushing extends fpu_test_base;
	`uvm_component_utils(fpu_test_fcov_round_w_output_flushing)

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
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FMADD;
				 sqb_operand_a_i  == 32'hA01C_2402;
				 sqb_operand_b_i  == 32'h1F90_5010;
				 sqb_operand_c_i  == 32'h0098_0516;
				 sqb_rm_i         == `RMM;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FMADD;
				 sqb_operand_a_i  == 32'hA01C_2402;
				 sqb_operand_b_i  == 32'h1F90_5010;
				 sqb_operand_c_i  == 32'h0098_0516;
				 sqb_rm_i         ==`RNE;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FMNADD;
				 sqb_operand_a_i  == 32'hA01C_2402;
				 sqb_operand_b_i  == 32'h1F90_5010;
				 sqb_operand_c_i  == 32'h0098_0516;
				 sqb_rm_i         == `RMM;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FMNADD;
				 sqb_operand_a_i  == 32'hA01C_2402;
				 sqb_operand_b_i  == 32'h1F90_5010;
				 sqb_operand_c_i  == 32'h0098_0516;
				 sqb_rm_i         == `RNE;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FMSUB;
				 sqb_operand_a_i  == 32'h043C_32C6;
				 sqb_operand_b_i  == 32'h3CA2_6FE5;
				 sqb_operand_c_i  == 32'h016E_0F64;
				 sqb_rm_i         == `RMM;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FMSUB;
				 sqb_operand_a_i  == 32'h3F1B_CA68;
				 sqb_operand_b_i  == 32'h034B_574C;
				 sqb_operand_c_i  == 32'h02FA_10B1;
				 sqb_rm_i         == `RNE;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FMNSUB;
				 sqb_operand_a_i  == 32'h043C_32C6;
				 sqb_operand_b_i  == 32'h3CA2_6FE5;
				 sqb_operand_c_i  == 32'h016E_0F64;
				 sqb_rm_i         == `RMM;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FMNSUB;
				 sqb_operand_a_i  == 32'h143D_3C46;
				 sqb_operand_b_i  == 32'h2C1A_302B;
				 sqb_operand_c_i  == 32'h00D7_5FD9;
				 sqb_rm_i         == `RNE;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FDIV;
				 sqb_operand_a_i  == 32'h0090_501E;
				 sqb_operand_b_i  == 32'h7F90_501D;
				 sqb_operand_c_i  == 32'hFFFF_FFFF;
				 sqb_rm_i         == `RNE;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FSQRT;
				 sqb_operand_a_i  == 32'hC4AD_0647;
				 sqb_operand_b_i  == 32'h7860_6EDD;
				 sqb_operand_c_i  == 32'h1A4E_6A92;
				 sqb_rm_i         == `RMM;
				 sqb_fn_i         == 0;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FSQRT;
				 sqb_operand_a_i  == 32'hED41_E3CB;
				 sqb_operand_b_i  == 32'hF4EE_DB64;
				 sqb_operand_c_i  == 32'h792B_3DBB;
				 sqb_rm_i         == `RMM;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end




//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FMNADD;
				 sqb_operand_a_i  == 32'h201c_2402;
				 sqb_operand_b_i  == 32'h1f90_5010;
				 sqb_operand_c_i  == 32'h8098_0516;
				 sqb_rm_i         == `RMM;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FMNADD;
				 sqb_operand_a_i  == 32'h201c_2402;
				 sqb_operand_b_i  == 32'h1f90_5010;
				 sqb_operand_c_i  == 32'h8098_0516;
				 sqb_rm_i         == `RNE;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FMNSUB;
				 sqb_operand_a_i  == 32'h201c_2402;
				 sqb_operand_b_i  == 32'h1f90_5010;
				 sqb_operand_c_i  == 32'h0098_0516;
				 sqb_rm_i         == `RMM;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FMNSUB;
				 sqb_operand_a_i  == 32'h201c_2402;
				 sqb_operand_b_i  == 32'h1f90_5010;
				 sqb_operand_c_i  == 32'h0098_0516;
				 sqb_rm_i         == `RNE;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FMSUB;
				 sqb_operand_a_i  == 32'h201c_2402;
				 sqb_operand_b_i  == 32'h1f90_5010;
				 sqb_operand_c_i  == 32'h0098_0516;
				 sqb_rm_i         == `RMM;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FMSUB;
				 sqb_operand_a_i  == 32'ha01c_2402;
				 sqb_operand_b_i  == 32'h1f90_5010;
				 sqb_operand_c_i  == 32'h8098_0516;
				 sqb_rm_i         == `RNE;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FMUL;
				 sqb_operand_a_i  == 32'ha080_0000;
				 sqb_operand_b_i  == 32'h1F00_0000;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         == `RMM;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FMUL;
				 sqb_operand_a_i  == 32'h2080_0000;
				 sqb_operand_b_i  == 32'h1F00_0000;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         == `RMM;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FMUL;
				 sqb_operand_a_i  == 32'ha080_0000;
				 sqb_operand_b_i  == 32'h1F00_0000;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         == `RNE;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FMUL;
				 sqb_operand_a_i  == 32'h2080_0000;
				 sqb_operand_b_i  == 32'h1F00_0000;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         == `RNE;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 8; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FLOG;
				 sqb_operand_a_i  == 32'h3f80_0000;
				 sqb_operand_b_i  == 32'h0000_0000;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         == `RDN;
				 sqb_fn_i         inside{0,1};
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 8; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FLOG;
				 sqb_operand_a_i  == 32'h3f80_0000;
				 sqb_operand_b_i  == 32'h0000_0000;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         == `RTZ;
				 sqb_fn_i         inside{0,1};
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FDIV;
				 sqb_operand_a_i  == 32'had78_0000;
				 sqb_operand_b_i  == 32'h6c82_0000;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         == `RMM;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FDIV;
				 sqb_operand_a_i  == 32'h2d78_0000;
				 sqb_operand_b_i  == 32'h6c82_0000;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         == `RMM;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FDIV;
				 sqb_operand_a_i  == 32'h2e36_14a5;
				 sqb_operand_b_i  == 32'hf45d_b220;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         == `RMM;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FDIV;
				 sqb_operand_a_i  == 32'had78_0000;
				 sqb_operand_b_i  == 32'h6c82_0000;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         == `RNE;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FDIV;
				 sqb_operand_a_i  == 32'h2d78_0000;
				 sqb_operand_b_i  == 32'h6c82_0000;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         == `RNE;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FDIV;
				 sqb_operand_a_i  == 32'h2e36_14a5;
				 sqb_operand_b_i  == 32'hf45d_b220;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         == `RNE;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FDIV;
				 sqb_operand_a_i  == 32'h2e36_14a5;
				 sqb_operand_b_i  == 32'h745d_b220;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         == `RNE;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FEXP;
				 sqb_operand_a_i  == 32'hc2fc_0001;
				 sqb_operand_b_i  == 32'h0000_0000;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         == `RMM;
				 sqb_fn_i         == 0;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FEXP;
				 sqb_operand_a_i  == 32'hc2fc_0001;
				 sqb_operand_b_i  == 32'h0000_0000;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         == `RMM;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FEXP;
				 sqb_operand_a_i  == 32'hc2fc_0001;
				 sqb_operand_b_i  == 32'h0000_0000;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         == `RNE;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FLOG;
				 sqb_operand_a_i  == 32'h3f80_0000;
				 sqb_operand_b_i  == 32'h0000_0000;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         == `RMM;
				 sqb_fn_i         == 0;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FLOG;
				 sqb_operand_a_i  == 32'h3f80_0000;
				 sqb_operand_b_i  == 32'h0000_0000;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         == `RMM;
				 sqb_fn_i         == 1;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FLOG;
				 sqb_operand_a_i  == 32'h3f80_0000;
				 sqb_operand_b_i  == 32'h0000_0000;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         == `RNE;
				 sqb_fn_i         == 0;
				 sqb_user_i       inside{[8'h00:8'hFF]};
				 sqb_num_wait_clk == 1;
				 sqb_test_final   == 0;
				 sqb_handshake_i  == 1;})
			`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

			seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
		end

//==================================================================================================
		for (int i = 0; i < 1; i++) begin
			if (!seq_srandom.randomize() with
				{sub_num_seq_item == 1;
				 sqb_valid_i      == 1;
				 sqb_op_i         == `FLOG;
				 sqb_operand_a_i  == 32'h3f80_0000;
				 sqb_operand_b_i  == 32'h0000_0000;
				 sqb_operand_c_i  == 32'h0000_0000;
				 sqb_rm_i         == `RNE;
				 sqb_fn_i         == 1;
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
