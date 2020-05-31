//==================================================================================================
// Owner:    Thien.Nguyen
// Filename: fpu_test_input_flush_fmul
// History:  10/24/2019 Create new version
//==================================================================================================

class fpu_test_input_flush_fmul extends fpu_test_base;
        `uvm_component_utils(fpu_test_input_flush_fmul)

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

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +subnormal, B: +normal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SN_FINITE_P};
                                  sqb_operand_b_i inside {`NO_FINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +subnormal, B: -normal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SN_FINITE_P};
                                  sqb_operand_b_i inside {`NO_FINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +subnormal, B: +0, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SN_FINITE_P};
                                  sqb_operand_b_i inside {`ZERO_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +subnormal, B: -0, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SN_FINITE_P};
                                  sqb_operand_b_i inside {`ZERO_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +subnormal, B: +inf, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SN_FINITE_P};
                                  sqb_operand_b_i inside {`INFINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +subnormal, B: -inf, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SN_FINITE_P};
                                  sqb_operand_b_i inside {`INFINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +subnormal, B: qNaN, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SN_FINITE_P};
                                  sqb_operand_b_i inside {`QNAN_P, `QNAN_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +subnormal, B: sNaN, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SN_FINITE_P};
                                  sqb_operand_b_i inside {`SNAN_P, `SNAN_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +subnormal, B: +subnormal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SN_FINITE_P};
                                  sqb_operand_b_i inside {`SN_FINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +subnormal, B: -subnormal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SN_FINITE_P};
                                  sqb_operand_b_i inside {`SN_FINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -subnormal, B: +normal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SN_FINITE_M};
                                  sqb_operand_b_i inside {`NO_FINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -subnormal, B: -normal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SN_FINITE_M};
                                  sqb_operand_b_i inside {`NO_FINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -subnormal, B: +0, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SN_FINITE_M};
                                  sqb_operand_b_i inside {`ZERO_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -subnormal, B: -0, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SN_FINITE_M};
                                  sqb_operand_b_i inside {`ZERO_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -subnormal, B: +inf, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SN_FINITE_M};
                                  sqb_operand_b_i inside {`INFINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -subnormal, B: -inf, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SN_FINITE_M};
                                  sqb_operand_b_i inside {`INFINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -subnormal, B: qNaN, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SN_FINITE_M};
                                  sqb_operand_b_i inside {`QNAN_P, `QNAN_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -subnormal, B: sNaN, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SN_FINITE_M};
                                  sqb_operand_b_i inside {`SNAN_P, `SNAN_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -subnormal, B: +subnormal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SN_FINITE_M};
                                  sqb_operand_b_i inside {`SN_FINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -subnormal, B: -subnormal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SN_FINITE_M};
                                  sqb_operand_b_i inside {`SN_FINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +normal, B: +normal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`NO_FINITE_P};
                                  sqb_operand_b_i inside {`NO_FINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +normal, B: -normal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`NO_FINITE_P};
                                  sqb_operand_b_i inside {`NO_FINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +normal, B: +0, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`NO_FINITE_P};
                                  sqb_operand_b_i inside {`ZERO_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +normal, B: -0, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`NO_FINITE_P};
                                  sqb_operand_b_i inside {`ZERO_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +normal, B: +inf, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`NO_FINITE_P};
                                  sqb_operand_b_i inside {`INFINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +normal, B: -inf, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`NO_FINITE_P};
                                  sqb_operand_b_i inside {`INFINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +normal, B: qNaN, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`NO_FINITE_P};
                                  sqb_operand_b_i inside {`QNAN_P, `QNAN_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +normal, B: sNaN, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`NO_FINITE_P};
                                  sqb_operand_b_i inside {`SNAN_P, `SNAN_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +normal, B: +subnormal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`NO_FINITE_P};
                                  sqb_operand_b_i inside {`SN_FINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +normal, B: -subnormal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`NO_FINITE_P};
                                  sqb_operand_b_i inside {`SN_FINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -normal, B: +normal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`NO_FINITE_M};
                                  sqb_operand_b_i inside {`NO_FINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -normal, B: -normal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`NO_FINITE_M};
                                  sqb_operand_b_i inside {`NO_FINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -normal, B: +0, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`NO_FINITE_M};
                                  sqb_operand_b_i inside {`ZERO_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -normal, B: -0, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`NO_FINITE_M};
                                  sqb_operand_b_i inside {`ZERO_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -normal, B: +inf, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`NO_FINITE_M};
                                  sqb_operand_b_i inside {`INFINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -normal, B: -inf, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`NO_FINITE_M};
                                  sqb_operand_b_i inside {`INFINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -normal, B: qNaN, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`NO_FINITE_M};
                                  sqb_operand_b_i inside {`QNAN_P, `QNAN_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -normal, B: sNaN, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`NO_FINITE_M};
                                  sqb_operand_b_i inside {`SNAN_P, `SNAN_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -normal, B: +subnormal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`NO_FINITE_M};
                                  sqb_operand_b_i inside {`SN_FINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -normal, B: -subnormal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`NO_FINITE_M};
                                  sqb_operand_b_i inside {`SN_FINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +0, B: +normal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`ZERO_P};
                                  sqb_operand_b_i inside {`NO_FINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +0, B: -normal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`ZERO_P};
                                  sqb_operand_b_i inside {`NO_FINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +0, B: +0, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`ZERO_P};
                                  sqb_operand_b_i inside {`ZERO_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +0, B: -0, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`ZERO_P};
                                  sqb_operand_b_i inside {`ZERO_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +0, B: +inf, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`ZERO_P};
                                  sqb_operand_b_i inside {`INFINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +0, B: -inf, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`ZERO_P};
                                  sqb_operand_b_i inside {`INFINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +0, B: qNaN, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`ZERO_P};
                                  sqb_operand_b_i inside {`QNAN_P, `QNAN_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +0, B: sNaN, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`ZERO_P};
                                  sqb_operand_b_i inside {`SNAN_P, `SNAN_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +0, B: +subnormal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`ZERO_P};
                                  sqb_operand_b_i inside {`SN_FINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +0, B: -subnormal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`ZERO_P};
                                  sqb_operand_b_i inside {`SN_FINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -0, B: +normal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`ZERO_M};
                                  sqb_operand_b_i inside {`NO_FINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -0, B: -normal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`ZERO_M};
                                  sqb_operand_b_i inside {`NO_FINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -0, B: +0, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`ZERO_M};
                                  sqb_operand_b_i inside {`ZERO_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -0, B: -0, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`ZERO_M};
                                  sqb_operand_b_i inside {`ZERO_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -0, B: +inf, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`ZERO_M};
                                  sqb_operand_b_i inside {`INFINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -0, B: -inf, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`ZERO_M};
                                  sqb_operand_b_i inside {`INFINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -0, B: qNaN, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`ZERO_M};
                                  sqb_operand_b_i inside {`QNAN_P, `QNAN_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -0, B: sNaN, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`ZERO_M};
                                  sqb_operand_b_i inside {`SNAN_P, `SNAN_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -0, B: +subnormal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`ZERO_M};
                                  sqb_operand_b_i inside {`SN_FINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -0, B: -subnormal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`ZERO_M};
                                  sqb_operand_b_i inside {`SN_FINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +inf, B: +normal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`INFINITE_P};
                                  sqb_operand_b_i inside {`NO_FINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +inf, B: -normal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`INFINITE_P};
                                  sqb_operand_b_i inside {`NO_FINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +inf, B: +0, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`INFINITE_P};
                                  sqb_operand_b_i inside {`ZERO_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +inf, B: -0, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`INFINITE_P};
                                  sqb_operand_b_i inside {`ZERO_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +inf, B: +inf, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`INFINITE_P};
                                  sqb_operand_b_i inside {`INFINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +inf, B: -inf, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`INFINITE_P};
                                  sqb_operand_b_i inside {`INFINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +inf, B: qNaN, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`INFINITE_P};
                                  sqb_operand_b_i inside {`QNAN_P, `QNAN_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +inf, B: sNaN, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`INFINITE_P};
                                  sqb_operand_b_i inside {`SNAN_P, `SNAN_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +inf, B: +subnormal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`INFINITE_P};
                                  sqb_operand_b_i inside {`SN_FINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: +inf, B: -subnormal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`INFINITE_P};
                                  sqb_operand_b_i inside {`SN_FINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -inf, B: +normal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`INFINITE_M};
                                  sqb_operand_b_i inside {`NO_FINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -inf, B: -normal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`INFINITE_M};
                                  sqb_operand_b_i inside {`NO_FINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -inf, B: +0, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`INFINITE_M};
                                  sqb_operand_b_i inside {`ZERO_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -inf, B: -0, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`INFINITE_M};
                                  sqb_operand_b_i inside {`ZERO_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -inf, B: +inf, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`INFINITE_M};
                                  sqb_operand_b_i inside {`INFINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -inf, B: -inf, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`INFINITE_M};
                                  sqb_operand_b_i inside {`INFINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -inf, B: qNaN, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`INFINITE_M};
                                  sqb_operand_b_i inside {`QNAN_P, `QNAN_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -inf, B: sNaN, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`INFINITE_M};
                                  sqb_operand_b_i inside {`SNAN_P, `SNAN_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -inf, B: +subnormal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`INFINITE_M};
                                  sqb_operand_b_i inside {`SN_FINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: -inf, B: -subnormal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`INFINITE_M};
                                  sqb_operand_b_i inside {`SN_FINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: qNaN, B: +normal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`QNAN_P, `QNAN_M};
                                  sqb_operand_b_i inside {`NO_FINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: qNaN, B: -normal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`QNAN_P, `QNAN_M};
                                  sqb_operand_b_i inside {`NO_FINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: qNaN, B: +0, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`QNAN_P, `QNAN_M};
                                  sqb_operand_b_i inside {`ZERO_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: qNaN, B: -0, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`QNAN_P, `QNAN_M};
                                  sqb_operand_b_i inside {`ZERO_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: qNaN, B: +inf, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`QNAN_P, `QNAN_M};
                                  sqb_operand_b_i inside {`INFINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: qNaN, B: -inf, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`QNAN_P, `QNAN_M};
                                  sqb_operand_b_i inside {`INFINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: qNaN, B: qNaN, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`QNAN_P, `QNAN_M};
                                  sqb_operand_b_i inside {`QNAN_P, `QNAN_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: qNaN, B: sNaN, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`QNAN_P, `QNAN_M};
                                  sqb_operand_b_i inside {`SNAN_P, `SNAN_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: qNaN, B: +subnormal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`QNAN_P, `QNAN_M};
                                  sqb_operand_b_i inside {`SN_FINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: qNaN, B: -subnormal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`QNAN_P, `QNAN_M};
                                  sqb_operand_b_i inside {`SN_FINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: sNaN, B: +normal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SNAN_P, `SNAN_M};
                                  sqb_operand_b_i inside {`NO_FINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: sNaN, B: -normal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SNAN_P, `SNAN_M};
                                  sqb_operand_b_i inside {`NO_FINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: sNaN, B: +0, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SNAN_P, `SNAN_M};
                                  sqb_operand_b_i inside {`ZERO_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: sNaN, B: -0, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SNAN_P, `SNAN_M};
                                  sqb_operand_b_i inside {`ZERO_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: sNaN, B: +inf, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SNAN_P, `SNAN_M};
                                  sqb_operand_b_i inside {`INFINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: sNaN, B: -inf, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SNAN_P, `SNAN_M};
                                  sqb_operand_b_i inside {`INFINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: sNaN, B: qNaN, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SNAN_P, `SNAN_M};
                                  sqb_operand_b_i inside {`QNAN_P, `QNAN_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: sNaN, B: sNaN, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SNAN_P, `SNAN_M};
                                  sqb_operand_b_i inside {`SNAN_P, `SNAN_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: sNaN, B: +subnormal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SNAN_P, `SNAN_M};
                                  sqb_operand_b_i inside {`SN_FINITE_P};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
                                  sqb_num_wait_clk inside {[1:2]};
                                  sqb_test_final == 0;
                                  sqb_handshake_i == 1;})
                             `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                             seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);

                          end

                          //Operation name: `FMUL

                          //Round mode: rand_mode
                          //FN        : 0
                          //A: sNaN, B: -subnormal, C: random
                          repeat (100) begin

                             if (!seq_srandom.randomize() with
                                  {sub_num_seq_item == 1;
                                  sqb_valid_i dist {0 :=10, 1 :=90};
                                  sqb_op_i inside {`FMUL};
                                  sqb_rm_i inside {`RNE, `RTZ, `RDN, `RUP, `RMM};
                                  sqb_fn_i inside {0};
                                  sqb_user_i inside {[8'h00:8'hFF]};
                                  sqb_operand_a_i inside {`SNAN_P, `SNAN_M};
                                  sqb_operand_b_i inside {`SN_FINITE_M};
                                  sqb_operand_c_i inside {[32'h0000_0000:32'hFFFF_FFFF]};
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

