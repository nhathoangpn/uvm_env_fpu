//==================================================================================================
// Owner:    Hoang Pham
// Filename: fpu_fcov
// History:  2019.06.21 Create new version
//==================================================================================================

`uvm_analysis_imp_decl(_fcov_seq)
`uvm_analysis_imp_decl(_fcov_seq_grs)
`uvm_analysis_imp_decl(_fcov_mon)
`uvm_analysis_imp_decl(_fcov_mon_grs)

class fpu_fcov extends uvm_component;
	`uvm_component_utils(fpu_fcov)

	`include "../fpu_top/fpu_def.svh"

	uvm_analysis_imp_fcov_seq #(fpu_seq_item, fpu_fcov) fcov_seq_exp;
	uvm_analysis_imp_fcov_seq_grs #(fpu_seq_item, fpu_fcov) fcov_seq_grs_exp;
	uvm_analysis_imp_fcov_mon #(fpu_mon_item, fpu_fcov) fcov_mon_exp;
	uvm_analysis_imp_fcov_mon_grs #(fpu_mon_item, fpu_fcov) fcov_mon_grs_exp;

	fpu_ft_opts m_fpu_ft_opts;

	int num_stall_i    = 0;
	int num_rst        = 0;
	int num_error_o    = 0;
	int queue_size     = 0;
	int in_queue_size  = 0;
	int out_queue_size = 0;
	int cur_queue_diff = 0;
	int num_error      = 0;
	int num_log_err    = 0;
	int pos_error_o    = 0;

	bit [(`OP_W + `RM_W + `FN_W + `OPD_W*3 + `USRI_W) - 1 : 0] in_queue[$];
	bit [(`OP_W + `RM_W + `FN_W + `OPD_W*3 + `USRI_W) - 1 : 0] in_queue_grs[$];
	bit [(`RS_W + `FF_W + `IF_W    + `USRO_W + 11) - 1 : 0] out_queue[$];
	bit [(`RS_W + `FF_W + `IF_W    + `USRO_W + 11) - 1 : 0] out_queue_grs[$]; //11 bits for GRS
	bit [(`OP_W + `RM_W + `FN_W + `OPD_W*3 + `USRI_W) - 1 : 0] iq_item;
	bit [(`OP_W + `RM_W + `FN_W + `OPD_W*3 + `USRI_W) - 1 : 0] iq_item_grs;
	bit [(`RS_W + `FF_W + `IF_W    + `USRO_W + 11) - 1 : 0] oq_item;
	bit [(`RS_W + `FF_W + `IF_W    + `USRO_W + 11) - 1 : 0] oq_item_grs; //11 bits for GRS

	bit [`VLDI_W - 1 : 0] valid_i; 
//LV 	bit [`OP_W   - 1 : 0] op_i;
	bit [`OPD_W  - 1 : 0] operand_a_i;
	bit [`OPD_W  - 1 : 0] operand_b_i;
	bit [`OPD_W  - 1 : 0] operand_c_i;
//LV 	bit [`RM_W   - 1 : 0] rm_i;
	bit [`FN_W   - 1 : 0] fn_i;
	bit [`USRI_W - 1 : 0] user_i;
	bit [`STLL_W - 1 : 0] stall_i; 
	bit [`RDY_W  - 1 : 0] ready_o; 
	bit [`VLDO_W   - 1 : 0] valid_o;
	bit [`RS_W   - 1 : 0] result_o;
//LV 	bit [`FF_W   - 1 : 0] fflags_o;
//LV 	bit [`IF_W   - 1 : 0] iflags_o;
	bit [`ERR_W   - 1 : 0] error_o;
	bit [`USRO_W - 1 : 0] user_o;
	bit	guard_bit_arith;
	bit	round_bit_arith;
	bit	sticky_bit_arith;
	bit	guard_bit_spmath;
	bit	round_bit_spmath;
	bit	sticky_bit_spmath;
	bit	guard_bit_cmpcnv_i2f;
	bit	round_bit_cmpcnv_i2f;
	bit	sticky_bit_cmpcnv_i2f;
	bit	fraction_0_cmpcnv_f2i;
	bit	fraction_1_cmpcnv_f2i;

	typedef enum logic [`OP_W-1:0] {
             fadd = `FADD, fsub = `FSUB, fmul = `FMUL, fmadd = `FMADD, fmsub = `FMSUB, fmnadd = `FMNADD, fmnsub = `FMNSUB,
						 fdiv = `FDIV, fsqrt = `FSQRT, fexp = `FEXP, flog = `FLOG,
						 fcvt_w_s = `FCVT_W_S , fcvt_wu_s = `FCVT_WU_S, fcvt_s_w = `FCVT_S_W , fcvt_s_wu = `FCVT_S_WU ,
						 fmin = `FMIN, fmax = `FMAX, feq = `FEQ, flt = `FLT, fle = `FLE, fne = `FNE,
						 add = `ADD, add_u = `ADD_U, sub = `SUB, sub_u = `SUB_U, mul = `MUL, mulh = `MULH, mul_u = `MUL_U, mulh_u = `MULH_U, mul_su = `MUL_SU, mulh_su = `MULH_SU, madd = `MADD, mnadd = `MNADD, msub = `MSUB, mnsub = `MNSUB,
						 div_s = `DIV_S, div_u = `DIV_U, rem_s = `REM_S, rem_u =`REM_U
							} opcode;
	typedef enum logic [`RM_W-1:0] {rne = `RNE, rtz = `RTZ, rdn = `RDN, rup = `RUP, rmm = `RMM} round_mode;
	typedef enum logic [`FF_W-1:0] {ff_de = `FF_DE, ff_nv = `FF_NV, ff_dz = `FF_DZ, ff_of = `FF_OF, ff_uf = `FF_UF, ff_nx = `FF_NX} fflags;
	typedef enum logic [`IF_W-1:0] {if_ze = `IF_ZE, if_dz = `IF_DZ, if_sn = `IF_SN, if_of = `IF_OF} iflags;

	opcode op_i;
	round_mode rm_i;
	fflags fflags_o;
	iflags iflags_o;

	// define covergroup...
	`include "fpu_fcov_define_bbox.inc"
	`include "fpu_fcov_define_wbox.inc"

	function new(string name, uvm_component parent);
		super.new(name, parent);
		// create covergroup...
		cg_FPU_Flags_Coverage = new();
		cg_Flags_analysis_DE = new();
		cg_Flags_analysis_NV_fadd_fsub = new();
		cg_Flags_analysis_NV_fmul = new();
		cg_Flags_analysis_NV_fmadd_fmsub_fmnadd_fmnsub = new();
		cg_Flags_analysis_NV_fdiv = new();
		cg_Flags_analysis_NV_fsqrt_flog = new();
		cg_Flags_analysis_NV_fexp = new();
		cg_Flags_analysis_NV_feq_fne_fmin_fmax = new();
		cg_Flags_analysis_NV_flt_fle = new();
		cg_Flags_analysis_NV_fcvt_w_s = new();
		cg_Flags_analysis_NV_fcvt_wu_s = new();
		cg_Flags_analysis_DZ_fdiv_flog = new();
		cg_Flags_analysis_OF = new();
		cg_Flags_analysis_UF = new();
		cg_Flags_analysis_NX = new();

		cg_Round_modes_Coverage = new();
		//hoang.pham cg_Result_format_Coverage = new();
		cg_Result_format_Arith = new();
		cg_Result_format_Arith_fmadd_fmnadd_fmsub_fmnsub = new();

		cg_Result_format_SM = new();
		cg_Result_format_Cmp_Cvt = new();

		cg_NaN_propagation_Coverage = new();
		cg_NaN_prop_analysis = new();

		cg_Pipeline_nonpipe_Coverage = new();
		cg_Input_combination_coverage = new();
		cg_GRS_arith_comb_Coverage = new();
		cg_GRS_spmath_comb_Coverage = new();
		cg_GRS_cmpcnv_i2f_comb_Coverage = new();
		cg_GRS_cmpcnv_f2i_comb_Coverage = new();
	endfunction

	function void build_phase(uvm_phase phase);
		fcov_seq_exp = new("fcov_seq_exp", this);
		fcov_seq_grs_exp = new("fcov_seq_grs_exp", this);
		fcov_mon_exp = new("fcov_mon_exp", this);
		fcov_mon_grs_exp = new("fcov_mon_grs_exp", this);

		if (!uvm_config_db #(fpu_ft_opts)::get(this, "", "fpu_ft_opts", m_fpu_ft_opts))
			`uvm_fatal("SCB_CONFIG", "cannot get fpu_ft_opts from config database")
	endfunction

	function void write_fcov_seq(fpu_seq_item seq_item);
		iq_item = {seq_item.op_i,
							 seq_item.rm_i,
							 seq_item.fn_i,
							 seq_item.operand_a_i,
							 seq_item.operand_b_i,
							 seq_item.operand_c_i,
							 seq_item.user_i};
		`uvm_info(get_name(),
							$sformatf("\ninput_item: op = %h, rm = %h, fn = %h, op_a = %h, op_b = %h, op_c = %h, usi = %h, rst = %b",
							seq_item.op_i, seq_item.rm_i, seq_item.fn_i, seq_item.operand_a_i, seq_item.operand_b_i, seq_item.operand_c_i, seq_item.user_i, seq_item.rst),
							UVM_FULL)

		if (seq_item.rst) begin
			if (seq_item.valid_i && seq_item.ready_o) begin
				in_queue.push_back(iq_item);
			end
			if (seq_item.valid_o) begin
				cur_queue_diff = in_queue.size() - out_queue.size() - 1;
			end else begin
				cur_queue_diff = in_queue.size() - out_queue.size();
			end
			for (int i = 0; i < cur_queue_diff; i++) begin
				in_queue.pop_back();
				num_rst = num_rst + 1;
			end
		end else begin
			in_queue.push_back(iq_item);
		end
		// execute covergroup...
	endfunction

	function void write_fcov_seq_grs(fpu_seq_item seq_item_grs);
		iq_item_grs = {seq_item_grs.op_i,
							 seq_item_grs.rm_i,
							 seq_item_grs.fn_i,
							 seq_item_grs.operand_a_i,
							 seq_item_grs.operand_b_i,
							 seq_item_grs.operand_c_i,
							 seq_item_grs.user_i};
		`uvm_info(get_name(),
							$sformatf("\ninput_item: op = %h, rm = %h, fn = %h, op_a = %h, op_b = %h, op_c = %h, usi = %h, rst = %b",
							seq_item_grs.op_i, seq_item_grs.rm_i, seq_item_grs.fn_i, seq_item_grs.operand_a_i, seq_item_grs.operand_b_i, seq_item_grs.operand_c_i, seq_item_grs.user_i, seq_item_grs.rst),
							UVM_FULL)

		if (seq_item_grs.rst) begin
			if (seq_item_grs.valid_i && seq_item_grs.ready_o) begin
				in_queue_grs.push_back(iq_item_grs);
			end
			if (seq_item_grs.valid_o) begin
				cur_queue_diff = in_queue_grs.size() - out_queue_grs.size() - 1;
			end else begin
				cur_queue_diff = in_queue_grs.size() - out_queue_grs.size();
			end
			for (int i = 0; i < cur_queue_diff; i++) begin
				in_queue_grs.pop_back();
				num_rst = num_rst + 1;
			end
		end else begin
			in_queue_grs.push_back(iq_item_grs);
		end
		// execute covergroup...
	endfunction

	function void write_fcov_mon(fpu_mon_item mon_item);
		oq_item = {mon_item.result_o,
							 mon_item.fflags_o,
							 mon_item.iflags_o,
			  			 mon_item.user_o,
			  			 mon_item.guard_bit_arith,
			  			 mon_item.round_bit_arith,
			  			 mon_item.sticky_bit_arith,
			  			 mon_item.guard_bit_spmath,
			  			 mon_item.round_bit_spmath,
			  			 mon_item.sticky_bit_spmath,
			  			 mon_item.guard_bit_cmpcnv_i2f,
			  			 mon_item.round_bit_cmpcnv_i2f,
			  			 mon_item.sticky_bit_cmpcnv_i2f,
			  			 mon_item.fraction_0_cmpcnv_f2i,
			  			 mon_item.fraction_1_cmpcnv_f2i};
		`uvm_info(get_name(),
			  $sformatf("\noutput_item: res = %h, ff = %h, if = %h, uso = %h, stall = %b, rst =%b, guard_bit_arith = %b, round_bit_arith = %b, sticky_bit_arith = %b, guard_bit_spmath = %b, round_bit_spmath = %b, sticky_bit_spmath = %b, guard_bit_cmpcnv_i2f = %b, round_bit_cmpcnv_i2f = %b, sticky_bit_cmpcnv_i2f = %b, fraction_0_cmpcnv_f2i = %b, fraction_1_cmpcnv_f2i = %b",
				    mon_item.result_o, mon_item.fflags_o, mon_item.iflags_o, mon_item.user_o, mon_item.stall_i, mon_item.rst, mon_item.guard_bit_arith, mon_item.round_bit_arith, mon_item.sticky_bit_arith, mon_item.guard_bit_spmath, mon_item.round_bit_spmath, mon_item.sticky_bit_spmath, mon_item.guard_bit_cmpcnv_i2f, mon_item.round_bit_cmpcnv_i2f, mon_item.sticky_bit_cmpcnv_i2f, mon_item.fraction_0_cmpcnv_f2i, mon_item.fraction_1_cmpcnv_f2i),
							UVM_FULL)

		if (mon_item.rst) begin
			if (!mon_item.error_o) begin
				out_queue.push_back(oq_item);
			end
			cur_queue_diff = in_queue.size() - out_queue.size();
			for (int i = 0; i < cur_queue_diff; i++) begin
				in_queue.pop_back();
				num_rst = num_rst + 1;
			end
		end else begin
			if (mon_item.stall_i) begin
        num_stall_i = num_stall_i + 1;
			end else if (mon_item.error_o) begin
				pos_error_o = out_queue.size();
				if (in_queue.size() > out_queue.size()) begin
					in_queue.delete(pos_error_o);
					num_error_o = num_error_o + 1;
				end
      end else begin
        out_queue.push_back(oq_item);
      end
		end
		//execute covergroup...
	endfunction

	function void write_fcov_mon_grs(fpu_mon_item mon_item_grs);
		oq_item_grs = {mon_item_grs.result_o,
							 mon_item_grs.fflags_o,
							 mon_item_grs.iflags_o,
			  			 mon_item_grs.user_o,
			  			 mon_item_grs.guard_bit_arith,
			  			 mon_item_grs.round_bit_arith,
			  			 mon_item_grs.sticky_bit_arith,
			  			 mon_item_grs.guard_bit_spmath,
			  			 mon_item_grs.round_bit_spmath,
			  			 mon_item_grs.sticky_bit_spmath,
			  			 mon_item_grs.guard_bit_cmpcnv_i2f,
			  			 mon_item_grs.round_bit_cmpcnv_i2f,
			  			 mon_item_grs.sticky_bit_cmpcnv_i2f,
			  			 mon_item_grs.fraction_0_cmpcnv_f2i,
			  			 mon_item_grs.fraction_1_cmpcnv_f2i};
		`uvm_info(get_name(),
			  $sformatf("\noutput_item: res = %h, ff = %h, if = %h, uso = %h, stall = %b, rst =%b, guard_bit_arith = %b, round_bit_arith = %b, sticky_bit_arith = %b, guard_bit_spmath = %b, round_bit_spmath = %b, sticky_bit_spmath = %b, guard_bit_cmpcnv_i2f = %b, round_bit_cmpcnv_i2f = %b, sticky_bit_cmpcnv_i2f = %b, fraction_0_cmpcnv_f2i = %b, fraction_1_cmpcnv_f2i = %b",
				    mon_item_grs.result_o, mon_item_grs.fflags_o, mon_item_grs.iflags_o, mon_item_grs.user_o, mon_item_grs.stall_i, mon_item_grs.rst, mon_item_grs.guard_bit_arith, mon_item_grs.round_bit_arith, mon_item_grs.sticky_bit_arith, mon_item_grs.guard_bit_spmath, mon_item_grs.round_bit_spmath, mon_item_grs.sticky_bit_spmath, mon_item_grs.guard_bit_cmpcnv_i2f, mon_item_grs.round_bit_cmpcnv_i2f, mon_item_grs.sticky_bit_cmpcnv_i2f, mon_item_grs.fraction_0_cmpcnv_f2i, mon_item_grs.fraction_1_cmpcnv_f2i),
							UVM_FULL)

		if (mon_item_grs.rst) begin
			if (!mon_item_grs.error_o) begin
				out_queue_grs.push_back(oq_item_grs);
			end
			cur_queue_diff = in_queue.size() - out_queue_grs.size();
			for (int i = 0; i < cur_queue_diff; i++) begin
				in_queue.pop_back();
				num_rst = num_rst + 1;
			end
		end else begin
			if (mon_item_grs.stall_i) begin
        num_stall_i = num_stall_i + 1;
			end else if (mon_item_grs.error_o) begin
				pos_error_o = out_queue_grs.size();
				if (in_queue.size() > out_queue_grs.size()) begin
					in_queue.delete(pos_error_o);
					num_error_o = num_error_o + 1;
				end
      end else begin
        out_queue_grs.push_back(oq_item_grs);
      end
		end
		//execute covergroup...
	endfunction

	function void ioqueue_to_fcov_sample();

		`uvm_info(get_name(), $sformatf("\nin queue_size = %0d", in_queue.size()), UVM_FULL)
		`uvm_info(get_name(), $sformatf("\nout queue_size = %0d", out_queue.size()), UVM_FULL)

		in_queue_size  = in_queue.size();
		out_queue_size = out_queue.size();

		queue_size = (in_queue_size <= out_queue_size) ? in_queue_size : out_queue_size;

		for (int i = 0; i < queue_size; i++) begin
			{op_i,
			 rm_i,
			 fn_i,
			 operand_a_i,
			 operand_b_i,
			 operand_c_i,
			 user_i} = in_queue.pop_front();

			{result_o,
			 fflags_o,
			 iflags_o,
			 user_o,
			 guard_bit_arith,
			 round_bit_arith,
			 sticky_bit_arith,
			 guard_bit_spmath,
			 round_bit_spmath,
			 sticky_bit_spmath,
			 guard_bit_cmpcnv_i2f,
			 round_bit_cmpcnv_i2f,
			 sticky_bit_cmpcnv_i2f,
			 fraction_0_cmpcnv_f2i,
			 fraction_1_cmpcnv_f2i} = out_queue.pop_front();

			`uvm_info(get_name(),
							$sformatf("FCOV_sample: op_i=%h rm_i=%h operand_a_i=%h operand_b_i=%h operand_c_i=%h result_o=%h fflags_o=%h iflags_o=%h user_i=%h user_o=%h fn_i=%h\n",
							op_i, rm_i, operand_a_i, operand_b_i, operand_c_i, result_o, fflags_o, iflags_o, user_i, user_o, fn_i),
							UVM_FULL)
			cg_FPU_Flags_Coverage.sample();
			cg_Flags_analysis_DE.sample();
			cg_Flags_analysis_NV_fadd_fsub.sample();
			cg_Flags_analysis_NV_fmul.sample();
			cg_Flags_analysis_NV_fmadd_fmsub_fmnadd_fmnsub.sample();
			cg_Flags_analysis_NV_fdiv.sample();
			cg_Flags_analysis_NV_fsqrt_flog.sample();
			cg_Flags_analysis_NV_fexp.sample();
			cg_Flags_analysis_NV_feq_fne_fmin_fmax.sample();
			cg_Flags_analysis_NV_flt_fle.sample();
			cg_Flags_analysis_NV_fcvt_w_s.sample();
			cg_Flags_analysis_NV_fcvt_wu_s.sample();
			cg_Flags_analysis_DZ_fdiv_flog.sample();
			cg_Flags_analysis_OF.sample();
			cg_Flags_analysis_UF.sample();
			cg_Flags_analysis_NX.sample();

			cg_Round_modes_Coverage.sample();
			//hoang.pham cg_Result_format_Coverage.sample();
			cg_Result_format_Arith.sample();
			cg_Result_format_Arith_fmadd_fmnadd_fmsub_fmnsub.sample();

			cg_Result_format_SM.sample();
			cg_Result_format_Cmp_Cvt.sample();

			cg_NaN_propagation_Coverage.sample();
			cg_NaN_prop_analysis.sample();

			cg_Pipeline_nonpipe_Coverage.sample();
			cg_Input_combination_coverage.sample();
		end
	endfunction

	function void ioqueue_to_fcov_grs_sample();

		`uvm_info(get_name(), $sformatf("\nin queue_size = %0d", in_queue_grs.size()), UVM_FULL)
		`uvm_info(get_name(), $sformatf("\nout queue_size = %0d", out_queue_grs.size()), UVM_FULL)

		in_queue_size  = in_queue_grs.size();
		out_queue_size = out_queue_grs.size();

		queue_size = (in_queue_size <= out_queue_size) ? in_queue_size : out_queue_size;

		for (int i = 0; i < queue_size; i++) begin
			{op_i,
			 rm_i,
			 fn_i,
			 operand_a_i,
			 operand_b_i,
			 operand_c_i,
			 user_i} = in_queue_grs.pop_front();

			{result_o,
			 fflags_o,
			 iflags_o,
			 user_o,
			 guard_bit_arith,
			 round_bit_arith,
			 sticky_bit_arith,
			 guard_bit_spmath,
			 round_bit_spmath,
			 sticky_bit_spmath,
			 guard_bit_cmpcnv_i2f,
			 round_bit_cmpcnv_i2f,
			 sticky_bit_cmpcnv_i2f,
			 fraction_0_cmpcnv_f2i,
			 fraction_1_cmpcnv_f2i} = out_queue_grs.pop_front();

			`uvm_info(get_name(),
							$sformatf("FCOV_GRS_sample: op_i=%h rm_i=%h arith_grs=%h%h%h spmath_grs=%h%h%h cmpcnv_i2f=%h%h%h cmpcnv_f2i[1:0]=%h%h\n",
							op_i, rm_i, guard_bit_arith, round_bit_arith, sticky_bit_arith, guard_bit_spmath, round_bit_spmath, sticky_bit_spmath, guard_bit_cmpcnv_i2f, round_bit_cmpcnv_i2f, sticky_bit_cmpcnv_i2f, fraction_1_cmpcnv_f2i, fraction_0_cmpcnv_f2i), 
							UVM_FULL)
			cg_GRS_arith_comb_Coverage.sample();
			cg_GRS_spmath_comb_Coverage.sample();
			cg_GRS_cmpcnv_i2f_comb_Coverage.sample();
			cg_GRS_cmpcnv_f2i_comb_Coverage.sample();
		end
	endfunction

	function void extract_phase(uvm_phase phase);
		`uvm_info(get_name(), "extract_phase starts", UVM_FULL)

		ioqueue_to_fcov_sample();
		ioqueue_to_fcov_grs_sample();

		`uvm_info(get_name(), "extract_phase finishes", UVM_FULL)
	endfunction
endclass
