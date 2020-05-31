//==================================================================================================
// Owner:    Thien.Nguyen
// Filename: fpu_test_cnv_cov_improve
// History:  10/10/2019 Create new version
//==================================================================================================

class fpu_test_cnv_cov_improve extends fpu_test_base;
        `uvm_component_utils(fpu_test_cnv_cov_improve)

        `include "../fpu_top/fpu_def.svh"
        bit [7:0]  op_i;
        bit [2:0]  rm;
        bit        fn;

        fpu_seq_base seq_srandom;
        fpu_seq_base seq_sdirect;

        function new(string name, uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task run_phase(uvm_phase phase);
                phase.phase_done.set_drain_time(this,110);
                phase.raise_objection(this, {get_name,"run_phase starts"});
                `uvm_info(get_name(), "run_phase starts", UVM_FULL)

                m_fpu_agent_cfg.fpu_vif.rst_gen_direct(1,10);

                seq_srandom = fpu_seq_base::type_id::create("seq_srandom");
                seq_sdirect = fpu_seq_base::type_id::create("seq_sdirect");

                // START FPU OPERATION TESTING

                          //Operation name: Pipeline checking all functions of ERROR_TEST_CMPCVT

                          //A: random, B: random, C: random
                          repeat (20000) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=0, 1 :=1};
                                  sqb_op_i inside {[8'b1000_0000:8'b1011_1111]};
//LV                                   sqb_op_i inside {`FMIN, `FMAX, `FEQ, `FLT, `FLE, `FNE, `FCVT_W_S, `FCVT_WU_S, `FCVT_S_W, `FCVT_S_WU};
//LV                                   sqb_op_i inside {`FCVT_W_S, `FCVT_WU_S, `FCVT_S_W, `FCVT_S_WU};
                                  sqb_op_i inside {`FCVT_S_W};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0,1};
                                  sqb_user_i inside {[8'h00:8'hFF]};
//LV                                   foreach (sqb_operand_a_i[i])
//LV 																		{sqb_operand_a_i[i] dist {0:=1, 1:=1};}
																	sqb_operand_b_i dist {
															      [32'h00000000:32'h00000001]:/1,
															      [32'h00000002:32'h00000003]:/1,
															      [32'h00000004:32'h00000007]:/1,
															      [32'h00000008:32'h0000000F]:/1,
															      [32'h00000010:32'h0000001F]:/1,
															      [32'h00000020:32'h0000003F]:/1,
															      [32'h00000040:32'h0000007F]:/1,
															      [32'h00000080:32'h000000FF]:/1,
															      [32'h00000100:32'h000001FF]:/1,
															      [32'h00000200:32'h000003FF]:/1,
															      [32'h00000400:32'h000007FF]:/1,
															      [32'h00000800:32'h00000FFF]:/1,
															      [32'h00001000:32'h00001FFF]:/1,
															      [32'h00002000:32'h00003FFF]:/1,
															      [32'h00004000:32'h00007FFF]:/1,
															      [32'h00008000:32'h0000FFFF]:/1,
															      [32'h00010000:32'h0001FFFF]:/1,
															      [32'h00020000:32'h0003FFFF]:/1,
															      [32'h00040000:32'h0007FFFF]:/1,
															      [32'h00080000:32'h000FFFFF]:/1,
															      [32'h00100000:32'h001FFFFF]:/1,
															      [32'h00200000:32'h003FFFFF]:/1,
															      [32'h00400000:32'h007FFFFF]:/1,
															      [32'h00800000:32'h00FFFFFF]:/1,
															      [32'h01000000:32'h01FFFFFF]:/1,
															      [32'h02000000:32'h03FFFFFF]:/1,
															      [32'h04000000:32'h07FFFFFF]:/1,
															      [32'h08000000:32'h0FFFFFFF]:/1,
															      [32'h10000000:32'h1FFFFFFF]:/1,
															      [32'h20000000:32'h3FFFFFFF]:/1,
															      [32'h40000000:32'h7FFFFFFF]:/1,
															      [32'h80000000:32'hFFFFFFFF]:/1
																	};
																	sqb_operand_a_i	dist {sqb_operand_b_i:=1, ((~sqb_operand_b_i) + 1):=1};
//LV                                   sqb_operand_b_i inside {[32'h0000_000:32'hFFFF_FFFF]};
                                  sqb_operand_c_i inside {[32'h0000_000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: Pipeline checking all functions of ERROR_TEST_CMPCVT

                          //A: random, B: random, C: random
                          repeat (10000) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=0, 1 :=1};
                                  sqb_op_i inside {[8'b1000_0000:8'b1011_1111]};
//LV                                   sqb_op_i inside {`FMIN, `FMAX, `FEQ, `FLT, `FLE, `FNE, `FCVT_W_S, `FCVT_WU_S, `FCVT_S_W, `FCVT_S_WU};
//LV                                   sqb_op_i inside {`FCVT_W_S, `FCVT_WU_S, `FCVT_S_W, `FCVT_S_WU};
                                  sqb_op_i inside {`FCVT_S_WU};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0,1};
                                  sqb_user_i inside {[8'h00:8'hFF]};
//LV                                   foreach (sqb_operand_a_i[i])
//LV 																		{sqb_operand_a_i[i] dist {0:=1, 1:=1};}
//LV 																	sqb_operand_a_i	dist {sqb_operand_b_i:=1, ((~sqb_operand_b_i) + 1):=0};
//LV                                   sqb_operand_b_i inside {[32'h0000_000:32'hFFFF_FFFF]};
																	sqb_operand_b_i dist {
															      [32'h00000000:32'h00000001]:/1,
															      [32'h00000002:32'h00000003]:/1,
															      [32'h00000004:32'h00000007]:/1,
															      [32'h00000008:32'h0000000F]:/1,
															      [32'h00000010:32'h0000001F]:/1,
															      [32'h00000020:32'h0000003F]:/1,
															      [32'h00000040:32'h0000007F]:/1,
															      [32'h00000080:32'h000000FF]:/1,
															      [32'h00000100:32'h000001FF]:/1,
															      [32'h00000200:32'h000003FF]:/1,
															      [32'h00000400:32'h000007FF]:/1,
															      [32'h00000800:32'h00000FFF]:/1,
															      [32'h00001000:32'h00001FFF]:/1,
															      [32'h00002000:32'h00003FFF]:/1,
															      [32'h00004000:32'h00007FFF]:/1,
															      [32'h00008000:32'h0000FFFF]:/1,
															      [32'h00010000:32'h0001FFFF]:/1,
															      [32'h00020000:32'h0003FFFF]:/1,
															      [32'h00040000:32'h0007FFFF]:/1,
															      [32'h00080000:32'h000FFFFF]:/1,
															      [32'h00100000:32'h001FFFFF]:/1,
															      [32'h00200000:32'h003FFFFF]:/1,
															      [32'h00400000:32'h007FFFFF]:/1,
															      [32'h00800000:32'h00FFFFFF]:/1,
															      [32'h01000000:32'h01FFFFFF]:/1,
															      [32'h02000000:32'h03FFFFFF]:/1,
															      [32'h04000000:32'h07FFFFFF]:/1,
															      [32'h08000000:32'h0FFFFFFF]:/1,
															      [32'h10000000:32'h1FFFFFFF]:/1,
															      [32'h20000000:32'h3FFFFFFF]:/1,
															      [32'h40000000:32'h7FFFFFFF]:/1,
															      [32'h80000000:32'hFFFFFFFF]:/1
																	};
																	sqb_operand_a_i	dist {sqb_operand_b_i:=1, ((~sqb_operand_b_i) + 1):=0};
                                  sqb_operand_c_i inside {[32'h0000_000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: Pipeline checking all functions of ERROR_TEST_CMPCVT

                          //A: random, B: random, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=0, 1 :=1};
                                  sqb_op_i inside {[8'b1000_0000:8'b1011_1111]};
                                  sqb_op_i inside {`FCVT_W_S, `FCVT_WU_S};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0,1};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i[31] dist {0 :=1, 1 :=1};
																	sqb_operand_a_i[30:23] inside {[156:159]};
																	sqb_operand_a_i[22:0]	== {23{1'b0}};
                                  sqb_operand_b_i inside {[32'h0000_000:32'hFFFF_FFFF]};
                                  sqb_operand_c_i inside {[32'h0000_000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                // FINISH FPU OPERATION TESTING
                if (!seq_srandom.randomize() with
                        {sub_num_seq_item == 1;
                        sqb_valid_i == 1;
                        sqb_op_i  == `FLE;
                        sqb_operand_a_i == 32'h4F00_0001;
                        sqb_operand_b_i == 32'h4F00_0001;
                        sqb_operand_c_i == 32'h4F00_0001;
                        sqb_rm_i inside{`RNE, `RTZ, `RDN, `RUP, `RMM};
                        sqb_fn_i == 0;
                        sqb_user_i == 8'h00;
                        sqb_num_wait_clk == 1;
                        sqb_test_final == 1;
                        sqb_handshake_i == 1;})
                `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                phase.drop_objection(this, {get_name,"run_phase finishes"});
                `uvm_info(get_name(), "run_phase finishes", UVM_FULL)
        endtask
endclass

