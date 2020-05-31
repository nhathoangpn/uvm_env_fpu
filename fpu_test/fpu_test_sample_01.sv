//==================================================================================================
// Owner:    Hoang Pham
// Filename: fpu_test_sample
// History:  2019.06.21 Create new version
//==================================================================================================

class fpu_test_sample_01 extends fpu_test_base;
	`uvm_component_utils(fpu_test_sample_01)

	`include "../fpu_top/fpu_def.svh"

	fpu_seq_base seq_srandom;
	fpu_seq_base seq_final;

	int stall_wait_num;
	int stall_width;

	function new(string name, uvm_component parent);
		super.new(name, parent);
		uvm_top.set_timeout(1000ns, 1);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		phase.phase_done.set_drain_time(this, 110);
		phase.raise_objection(this, {get_name, "run_phase starts"});
		`uvm_info(get_name(), "run_phase starts", UVM_FULL)

		m_fpu_agent_cfg.fpu_vif.rst_gen_direct(1, 10);

		seq_srandom = fpu_seq_base::type_id::create("seq_srandom");
		seq_final   = fpu_seq_base::type_id::create("seq_final");

		begin
			fork
				for (int i = 0; i < 10; i++) begin
					if (!seq_srandom.randomize() with
						{sub_num_seq_item == 1;
						 sqb_valid_i == 1;
						 sqb_op_i inside{
							 //`FADD, `FSUB, `FMUL, `FMADD, `FMSUB, `FMNADD, `FMNSUB,
							 //`ADD, `SUB, `MUL, `MULH, `MADD, `MSUB, `MNADD, `MNSUB,
							 //`ADD_U, `SUB_U, `MUL_U, `MULH_U, `MUL_SU, `MULH_SU,
							 //`FDIV, `FSQRT,/* `FEXP, `FLOG,*/ `DIV_S, `DIV_U, `REM_S, `REM_U,
							 `FMIN, `FMAX, `FEQ, `FLT, `FLE, `FNE, `FCVT_W_S, `FCVT_WU_S, `FCVT_S_W, `FCVT_S_WU};
						 sqb_operand_a_i inside{`NO_FINITE_P, `NO_FINITE_M};
						 sqb_operand_b_i inside{`NO_FINITE_P, `NO_FINITE_M, `ZERO_P};
						 sqb_operand_c_i inside{`NO_FINITE_P, `NO_FINITE_M, `INFINITE_P};
						 sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
						 sqb_fn_i == 0;
				 		 sqb_user_i inside{[8'h00:8'hFF]};
						 sqb_num_wait_clk == 1;
						 sqb_test_final == 0;
						 sqb_handshake_i dist {0:/50, 1:/50};})
					`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

					`uvm_info(get_name(), "sequence 1 starts", UVM_FULL)
					seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
				end

				for (int j = 0; j < 0; j++) begin
					stall_wait_num = $urandom_range(2, 3);
					stall_width    = $urandom_range(1, 3);
					`uvm_info(get_name(), $sformatf("\ndirect stall starts after %d", stall_wait_num), UVM_FULL)
					m_fpu_agent_cfg.fpu_vif.wait_for_op(1, `FMIN);
					m_fpu_agent_cfg.fpu_vif.stall_gen_direct(stall_wait_num, stall_width);
				end
			join
		end

		if (!seq_srandom.randomize() with
			{sub_num_seq_item == 1;
			 sqb_valid_i      == 0;
			 sqb_num_wait_clk == 1;
			 sqb_test_final   == 0;})
		`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

		`uvm_info(get_name(), "sequence 2 starts", UVM_FULL)
		seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

		begin
			fork
				for (int i = 0; i < 6789; i++) begin
					if (!seq_srandom.randomize() with
						{sub_num_seq_item == 1;
						 sqb_valid_i dist {0:/10, 1:/90};
						 sqb_op_i inside {
							 //`FADD, `FSUB, `FMUL, `FMADD, `FMSUB, `FMNADD, `FMNSUB,
					 		 //`ADD, `SUB, `MUL, `MULH, `MADD, `MSUB, `MNADD, `MNSUB,
							 //`ADD_U, `SUB_U, `MUL_U, `MULH_U, `MUL_SU, `MULH_SU,
							 //`FDIV, `FSQRT,/* `FEXP, `FLOG,*/ `DIV_S, `DIV_U, `REM_S, `REM_U,
							 `FMIN, `FMAX, `FEQ, `FLT, `FLE, `FNE, `FCVT_W_S, `FCVT_WU_S, `FCVT_S_W, `FCVT_S_WU};
						 sqb_operand_a_i inside{[32'h0000_0000:32'hFFFF_FFFF]};
						 sqb_operand_b_i inside{[32'h0000_0000:32'hFFFF_FFFF]};
						 sqb_operand_c_i inside{[32'h0000_0000:32'hFFFF_FFFF]};
						 sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
						 sqb_fn_i dist {0:/10, 1:/90};
				 		 sqb_user_i inside{[8'h00:8'hFF]};
						 sqb_num_wait_clk == 1;
						 sqb_test_final == 0;
						 sqb_handshake_i dist {0:/80, 1:/20};})
					`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

					begin
						`uvm_info(get_name(), "sequence 3 starts", UVM_FULL)
						seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
					end
				end

				begin
					`uvm_info(get_name(), "random stall starts", UVM_FULL)
					m_fpu_agent_cfg.fpu_vif.stall_gen_rand(30, $urandom_range(1, 2));
				end
			join_any
			disable fork;
		end

		if (!seq_final.randomize() with
			{sub_num_seq_item == 1;
			 sqb_num_wait_clk == 1;
			 sqb_test_final   == 1;})
		`uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

		`uvm_info(get_name(), "sequence final starts", UVM_FULL)
		seq_final.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

		phase.drop_objection(this, {get_name, "run_phase finishes"});
		`uvm_info(get_name(), "run_phase finishes", UVM_FULL)
	endtask
endclass
