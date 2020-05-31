//==================================================================================================
// Owner:    Thien.Nguyen
// Filename: fpu_test_flt
// History:  10/24/2019 Create new version
//==================================================================================================

class fpu_test_flt extends fpu_test_base;
        `uvm_component_utils(fpu_test_flt)

        `include "../fpu_top/fpu_def.svh"
        bit [7:0]  op_i;
        bit [2:0]  rm;
        bit        fn;
        bit [31:0] op_a_range_0_s, op_a_range_0_e, op_a_range_1_s, op_a_range_1_e;
        bit [31:0] op_b_range_0_s, op_b_range_0_e, op_b_range_1_s, op_b_range_1_e;
        bit [31:0] op_c_range_0_s, op_c_range_0_e, op_c_range_1_s, op_c_range_1_e;

        fpu_seq_base seq_srandom;
        fpu_seq_base seq_sdirect;

        function new(string name, uvm_component parent);
                super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task fpu_calc(int num=1);
                repeat (num) begin
                   if ((op_a_range_1_s == 0) && (op_a_range_1_e == 0)) begin op_a_range_1_s = op_a_range_0_s; op_a_range_1_e = op_a_range_0_e; end
                   if ((op_b_range_1_s == 0) && (op_b_range_1_e == 0)) begin op_b_range_1_s = op_b_range_0_s; op_b_range_1_e = op_b_range_0_e; end
                   if ((op_c_range_1_s == 0) && (op_c_range_1_e == 0)) begin op_c_range_1_s = op_c_range_0_s; op_c_range_1_e = op_c_range_0_e; end

                   if (!seq_srandom.randomize() with
                        {sub_num_seq_item == 1;
                        sqb_valid_i dist {0 :=10, 1 :=90};
                        sqb_op_i == op_i;
                        sqb_rm_i == rm;
                        sqb_fn_i == fn;
                        sqb_user_i inside {[8'h00:8'hFF]};
                        sqb_operand_a_i inside {[op_a_range_0_s:op_a_range_0_e],[op_a_range_1_s:op_a_range_1_e]};
                        sqb_operand_b_i inside {[op_b_range_0_s:op_b_range_0_e],[op_b_range_1_s:op_b_range_1_e]};
                        sqb_operand_c_i inside {[op_c_range_0_s:op_c_range_0_e],[op_c_range_1_s:op_c_range_1_e]};
                        sqb_num_wait_clk inside {[1:2]};
                        sqb_test_final == 0;
                        sqb_handshake_i == 1;})
                   `uvm_error("RANDOM SEQUENCE", "randomization failure for sequence")

                   op_a_range_1_s = 0; op_a_range_1_e = 0;
                   op_b_range_1_s = 0; op_b_range_1_e = 0;
                   op_c_range_1_s = 0; op_c_range_1_e = 0;

                   seq_srandom.start(m_fpu_env.m_fpu_agent.m_fpu_sqr);
                end
        endtask

        task run_phase(uvm_phase phase);
                phase.phase_done.set_drain_time(this,110);
                phase.raise_objection(this, {get_name,"run_phase starts"});
                `uvm_info(get_name(), "run_phase starts", UVM_FULL)

                m_fpu_agent_cfg.fpu_vif.rst_gen_direct(1,10);

                seq_srandom = fpu_seq_base::type_id::create("seq_srandom");
                seq_sdirect = fpu_seq_base::type_id::create("seq_sdirect");

                // START FPU OPERATION TESTING

                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +normal, B: +normal, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(1000);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(1000);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(1000);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(1000);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(1000);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +normal, B: -normal, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(1000);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(1000);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(1000);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(1000);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(1000);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +normal, B: +0, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +normal, B: -0, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +normal, B: +inf, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +normal, B: -inf, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +normal, B: qNaN, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +normal, B: sNaN, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_P_S;
                               op_a_range_0_e = `NO_FINITE_P_E;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -normal, B: +normal, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(1000);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(1000);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(1000);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(1000);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(1000);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -normal, B: -normal, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(1000);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(1000);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(1000);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(1000);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(1000);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -normal, B: +0, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -normal, B: -0, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -normal, B: +inf, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -normal, B: -inf, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -normal, B: qNaN, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -normal, B: sNaN, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `NO_FINITE_M_S;
                               op_a_range_0_e = `NO_FINITE_M_E;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +0, B: +normal, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +0, B: -normal, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +0, B: +0, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +0, B: -0, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +0, B: +inf, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +0, B: -inf, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +0, B: qNaN, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +0, B: sNaN, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `ZERO_P;
                               op_a_range_0_e = `ZERO_P;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -0, B: +normal, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -0, B: -normal, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -0, B: +0, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -0, B: -0, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -0, B: +inf, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -0, B: -inf, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -0, B: qNaN, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -0, B: sNaN, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `ZERO_M;
                               op_a_range_0_e = `ZERO_M;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +inf, B: +normal, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +inf, B: -normal, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +inf, B: +0, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +inf, B: -0, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +inf, B: +inf, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +inf, B: -inf, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +inf, B: qNaN, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: +inf, B: sNaN, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_P;
                               op_a_range_0_e = `INFINITE_P;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -inf, B: +normal, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -inf, B: -normal, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -inf, B: +0, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -inf, B: -0, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -inf, B: +inf, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -inf, B: -inf, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -inf, B: qNaN, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: -inf, B: sNaN, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `INFINITE_M;
                               op_a_range_0_e = `INFINITE_M;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: qNaN, B: +normal, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: qNaN, B: -normal, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: qNaN, B: +0, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: qNaN, B: -0, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: qNaN, B: +inf, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: qNaN, B: -inf, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: qNaN, B: qNaN, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: qNaN, B: sNaN, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `QNAN_P_S;
                               op_a_range_0_e = `QNAN_P_E;
                               op_a_range_1_s = `QNAN_M_S;
                               op_a_range_1_e = `QNAN_M_E;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: sNaN, B: +normal, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `NO_FINITE_P_S;
                               op_b_range_0_e = `NO_FINITE_P_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: sNaN, B: -normal, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `NO_FINITE_M_S;
                               op_b_range_0_e = `NO_FINITE_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: sNaN, B: +0, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `ZERO_P;
                               op_b_range_0_e = `ZERO_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: sNaN, B: -0, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `ZERO_M;
                               op_b_range_0_e = `ZERO_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: sNaN, B: +inf, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `INFINITE_P;
                               op_b_range_0_e = `INFINITE_P;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: sNaN, B: -inf, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `INFINITE_M;
                               op_b_range_0_e = `INFINITE_M;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: sNaN, B: qNaN, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `QNAN_P_S;
                               op_b_range_0_e = `QNAN_P_E;
                               op_b_range_1_s = `QNAN_M_S;
                               op_b_range_1_e = `QNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


                          //Operation name: FLT
                          op_i = `FLT;
                          fn = 0;

                          //A: sNaN, B: sNaN, C: random

                               //Round mode: RNE
                               rm = `RNE;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RTZ
                               rm = `RTZ;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RDN
                               rm = `RDN;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RUP
                               rm = `RUP;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);

                               //Round mode: RMM
                               rm = `RMM;
                               //Preset operands
                               op_a_range_0_s = `SNAN_P_S;
                               op_a_range_0_e = `SNAN_P_E;
                               op_a_range_1_s = `SNAN_M_S;
                               op_a_range_1_e = `SNAN_M_E;
                               op_b_range_0_s = `SNAN_P_S;
                               op_b_range_0_e = `SNAN_P_E;
                               op_b_range_1_s = `SNAN_M_S;
                               op_b_range_1_e = `SNAN_M_E;
                               op_c_range_0_s = 32'h0000_0000;
                               op_c_range_0_e = 32'hFFFF_FFFF;
                               //Call calculation
                               fpu_calc(100);


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

