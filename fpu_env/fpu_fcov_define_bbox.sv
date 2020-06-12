//////////////////////////////////////////////////////////////
// History
// 20191205 : Fixed invert result of cr_fsub_08, cr_fsub_09, cr_fsub_19, cr_fsub_20
//////////////////////////////////////////////////////////////

	covergroup cg_FPU_Flags_Coverage; //hoang.pham
		cp_op_fadd: coverpoint op_i {bins fadd = {fadd};}
		cp_op_fsub: coverpoint op_i {bins fsub = {fsub};}
		cp_op_fmul: coverpoint op_i {bins fmul = {fmul};}
		cp_op_fmadd: coverpoint op_i {bins fmadd = {fmadd};}
		cp_op_fmsub: coverpoint op_i {bins fmsub = {fmsub};}
		cp_op_fmnadd: coverpoint op_i {bins fmnadd = {fmnadd};}
		cp_op_fmnsub: coverpoint op_i {bins fmnsub = {fmnsub};}
		cp_op_fdiv: coverpoint op_i {bins fdiv = {fdiv};}
		cp_op_fsqrt: coverpoint op_i {bins fsqrt = {fsqrt};}
		cp_op_fexp: coverpoint op_i {bins fexp = {fexp};}
		cp_op_flog: coverpoint op_i {bins flog = {flog};}
		cp_op_fcvt_w_s: coverpoint op_i {bins fcvt_w_s  = {fcvt_w_s };}
		cp_op_fcvt_wu_s: coverpoint op_i {bins fcvt_wu_s = {fcvt_wu_s};}
		cp_op_fcvt_s_w: coverpoint op_i {bins fcvt_s_w  = {fcvt_s_w };}
		cp_op_fcvt_s_wu: coverpoint op_i {bins fcvt_s_wu  = {fcvt_s_wu };}
		cp_op_fmin: coverpoint op_i {bins fmin = {fmin};}
		cp_op_fmax: coverpoint op_i {bins fmax = {fmax};}
		cp_op_feq: coverpoint op_i {bins feq = {feq};}
		cp_op_flt: coverpoint op_i {bins flt = {flt};}
		cp_op_fle: coverpoint op_i {bins fle = {fle};}
		cp_op_fne: coverpoint op_i {bins fne = {fne};}
		cp_op_add: coverpoint op_i {bins add = {add};}
		cp_op_add_u: coverpoint op_i {bins add_u = {add_u};}
		cp_op_sub: coverpoint op_i {bins sub = {sub};}
		cp_op_sub_u: coverpoint op_i {bins sub_u = {sub_u};}
		cp_op_mul: coverpoint op_i {bins mul = {mul};}
		cp_op_mulh: coverpoint op_i {bins mulh = {mulh};}
		cp_op_mul_u: coverpoint op_i {bins mul_u = {mul_u};}
		cp_op_mulh_u: coverpoint op_i {bins mulh_u = {mulh_u};}
		cp_op_mul_su: coverpoint op_i {bins mul_su = {mul_su};}
		cp_op_mulh_su: coverpoint op_i {bins mulh_su = {mulh_su};}
		cp_op_madd: coverpoint op_i {bins madd = {madd};}
		cp_op_mnadd: coverpoint op_i {bins mnadd = {mnadd};}
		cp_op_msub: coverpoint op_i {bins msub = {msub};}
		cp_op_mnsub: coverpoint op_i {bins mnsub = {mnsub};}
		cp_op_div_s: coverpoint op_i {bins div_s = {div_s};}
		cp_op_div_u: coverpoint op_i {bins div_u = {div_u};}
		cp_op_rem_s: coverpoint op_i {bins rem_s = {rem_s};}
		cp_op_rem_u: coverpoint op_i {bins rem_u = {rem_u};}

		cp_fflags_ff_de_one: coverpoint fflags_o[5] {bins ff_de = {1'b1};}
		cp_fflags_ff_nv_one: coverpoint fflags_o[4] {bins ff_nv = {1'b1};}
		cp_fflags_ff_dz_one: coverpoint fflags_o[3] {bins ff_dz = {1'b1};}
		cp_fflags_ff_of_one: coverpoint fflags_o[2] {bins ff_of = {1'b1};}
		cp_fflags_ff_uf_one: coverpoint fflags_o[1] {bins ff_uf = {1'b1};}
		cp_fflags_ff_nx_one: coverpoint fflags_o[0] {bins ff_nx = {1'b1};}

		cp_fflags_ff_de_zero: coverpoint fflags_o[5] {bins ff_de = {1'b0};}
		cp_fflags_ff_nv_zero: coverpoint fflags_o[4] {bins ff_nv = {1'b0};}
		cp_fflags_ff_dz_zero: coverpoint fflags_o[3] {bins ff_dz = {1'b0};}
		cp_fflags_ff_of_zero: coverpoint fflags_o[2] {bins ff_of = {1'b0};}
		cp_fflags_ff_uf_zero: coverpoint fflags_o[1] {bins ff_uf = {1'b0};}
		cp_fflags_ff_nx_zero: coverpoint fflags_o[0] {bins ff_nx = {1'b0};}

		cp_iflags_if_ze_one: coverpoint iflags_o[3] {bins if_ze = {1'b1};}
		cp_iflags_if_dz_one: coverpoint iflags_o[2] {bins if_dz = {1'b1};}
		cp_iflags_if_sn_one: coverpoint iflags_o[1] {bins if_sn = {1'b1};}
		cp_iflags_if_of_one: coverpoint iflags_o[0] {bins if_of = {1'b1};}

		cp_iflags_if_ze_zero: coverpoint iflags_o[3] {bins if_ze = {1'b0};}
		cp_iflags_if_dz_zero: coverpoint iflags_o[2] {bins if_dz = {1'b0};}
		cp_iflags_if_sn_zero: coverpoint iflags_o[1] {bins if_sn = {1'b0};}
		cp_iflags_if_of_zero: coverpoint iflags_o[0] {bins if_of = {1'b0};}

		cr_fadd_01_1: cross cp_op_fadd, cp_fflags_ff_de_one;
		cr_fadd_02_1: cross cp_op_fadd, cp_fflags_ff_nv_one;
		cr_fadd_04_1: cross cp_op_fadd, cp_fflags_ff_of_one;
		cr_fadd_05_1: cross cp_op_fadd, cp_fflags_ff_uf_one;
		cr_fadd_06_1: cross cp_op_fadd, cp_fflags_ff_nx_one;

		cr_fadd_01_2: cross cp_op_fadd, cp_fflags_ff_de_zero;
		cr_fadd_02_2: cross cp_op_fadd, cp_fflags_ff_nv_zero;
		cr_fadd_03_2: cross cp_op_fadd, cp_fflags_ff_dz_zero;
		cr_fadd_04_2: cross cp_op_fadd, cp_fflags_ff_of_zero;
		cr_fadd_05_2: cross cp_op_fadd, cp_fflags_ff_uf_zero;
		cr_fadd_06_2: cross cp_op_fadd, cp_fflags_ff_nx_zero;

		cr_fsub_01_1: cross cp_op_fsub, cp_fflags_ff_de_one;
		cr_fsub_02_1: cross cp_op_fsub, cp_fflags_ff_nv_one;
		cr_fsub_04_1: cross cp_op_fsub, cp_fflags_ff_of_one;
		cr_fsub_05_1: cross cp_op_fsub, cp_fflags_ff_uf_one;
		cr_fsub_06_1: cross cp_op_fsub, cp_fflags_ff_nx_one;

		cr_fsub_01_2: cross cp_op_fsub, cp_fflags_ff_de_zero;
		cr_fsub_02_2: cross cp_op_fsub, cp_fflags_ff_nv_zero;
		cr_fsub_03_2: cross cp_op_fsub, cp_fflags_ff_dz_zero;
		cr_fsub_04_2: cross cp_op_fsub, cp_fflags_ff_of_zero;
		cr_fsub_05_2: cross cp_op_fsub, cp_fflags_ff_uf_zero;
		cr_fsub_06_2: cross cp_op_fsub, cp_fflags_ff_nx_zero;

		cr_fmul_01_1: cross cp_op_fmul, cp_fflags_ff_de_one;
		cr_fmul_02_1: cross cp_op_fmul, cp_fflags_ff_nv_one;
		cr_fmul_04_1: cross cp_op_fmul, cp_fflags_ff_of_one;
		cr_fmul_05_1: cross cp_op_fmul, cp_fflags_ff_uf_one;
		cr_fmul_06_1: cross cp_op_fmul, cp_fflags_ff_nx_one;

		cr_fmul_01__2: cross cp_op_fmul, cp_fflags_ff_de_zero;
		cr_fmul_02__2: cross cp_op_fmul, cp_fflags_ff_nv_zero;
		cr_fmul_03__2: cross cp_op_fmul, cp_fflags_ff_dz_zero;
		cr_fmul_04__2: cross cp_op_fmul, cp_fflags_ff_of_zero;
		cr_fmul_05__2: cross cp_op_fmul, cp_fflags_ff_uf_zero;
		cr_fmul_06__2: cross cp_op_fmul, cp_fflags_ff_nx_zero;

		cr_fmadd_01_1: cross cp_op_fmadd, cp_fflags_ff_de_one;
		cr_fmadd_02_1: cross cp_op_fmadd, cp_fflags_ff_nv_one;
		cr_fmadd_04_1: cross cp_op_fmadd, cp_fflags_ff_of_one;
		cr_fmadd_05_1: cross cp_op_fmadd, cp_fflags_ff_uf_one;
		cr_fmadd_06_1: cross cp_op_fmadd, cp_fflags_ff_nx_one;

		cr_fmadd_01_2: cross cp_op_fmadd, cp_fflags_ff_de_zero;
		cr_fmadd_02_2: cross cp_op_fmadd, cp_fflags_ff_nv_zero;
		cr_fmadd_03_2: cross cp_op_fmadd, cp_fflags_ff_dz_zero;
		cr_fmadd_04_2: cross cp_op_fmadd, cp_fflags_ff_of_zero;
		cr_fmadd_05_2: cross cp_op_fmadd, cp_fflags_ff_uf_zero;
		cr_fmadd_06_2: cross cp_op_fmadd, cp_fflags_ff_nx_zero;

		cr_fmsub_01_1: cross cp_op_fmsub, cp_fflags_ff_de_one;
		cr_fmsub_02_1: cross cp_op_fmsub, cp_fflags_ff_nv_one;
		cr_fmsub_04_1: cross cp_op_fmsub, cp_fflags_ff_of_one;
		cr_fmsub_05_1: cross cp_op_fmsub, cp_fflags_ff_uf_one;
		cr_fmsub_06_1: cross cp_op_fmsub, cp_fflags_ff_nx_one;

		cr_fmsub_01_2: cross cp_op_fmsub, cp_fflags_ff_de_zero;
		cr_fmsub_02_2: cross cp_op_fmsub, cp_fflags_ff_nv_zero;
		cr_fmsub_03_2: cross cp_op_fmsub, cp_fflags_ff_dz_zero;
		cr_fmsub_04_2: cross cp_op_fmsub, cp_fflags_ff_of_zero;
		cr_fmsub_05_2: cross cp_op_fmsub, cp_fflags_ff_uf_zero;
		cr_fmsub_06_2: cross cp_op_fmsub, cp_fflags_ff_nx_zero;

		cr_fmnadd_01_1: cross cp_op_fmnadd, cp_fflags_ff_de_one;
		cr_fmnadd_02_1: cross cp_op_fmnadd, cp_fflags_ff_nv_one;
		cr_fmnadd_04_1: cross cp_op_fmnadd, cp_fflags_ff_of_one;
		cr_fmnadd_05_1: cross cp_op_fmnadd, cp_fflags_ff_uf_one;
		cr_fmnadd_06_1: cross cp_op_fmnadd, cp_fflags_ff_nx_one;

		cr_fmnadd_01_2: cross cp_op_fmnadd, cp_fflags_ff_de_zero;
		cr_fmnadd_02_2: cross cp_op_fmnadd, cp_fflags_ff_nv_zero;
		cr_fmnadd_03_2: cross cp_op_fmnadd, cp_fflags_ff_dz_zero;
		cr_fmnadd_04_2: cross cp_op_fmnadd, cp_fflags_ff_of_zero;
		cr_fmnadd_05_2: cross cp_op_fmnadd, cp_fflags_ff_uf_zero;
		cr_fmnadd_06_2: cross cp_op_fmnadd, cp_fflags_ff_nx_zero;

		cr_fmnsub_01_1: cross cp_op_fmnsub, cp_fflags_ff_de_one;
		cr_fmnsub_02_1: cross cp_op_fmnsub, cp_fflags_ff_nv_one;
		cr_fmnsub_04_1: cross cp_op_fmnsub, cp_fflags_ff_of_one;
		cr_fmnsub_05_1: cross cp_op_fmnsub, cp_fflags_ff_uf_one;
		cr_fmnsub_06_1: cross cp_op_fmnsub, cp_fflags_ff_nx_one;

		cr_fmnsub_01_2: cross cp_op_fmnsub, cp_fflags_ff_de_zero;
		cr_fmnsub_02_2: cross cp_op_fmnsub, cp_fflags_ff_nv_zero;
		cr_fmnsub_03_2: cross cp_op_fmnsub, cp_fflags_ff_dz_zero;
		cr_fmnsub_04_2: cross cp_op_fmnsub, cp_fflags_ff_of_zero;
		cr_fmnsub_05_2: cross cp_op_fmnsub, cp_fflags_ff_uf_zero;
		cr_fmnsub_06_2: cross cp_op_fmnsub, cp_fflags_ff_nx_zero;

		cr_fdiv_01_1: cross cp_op_fdiv, cp_fflags_ff_de_one;
		cr_fdiv_02_1: cross cp_op_fdiv, cp_fflags_ff_nv_one;
		cr_fdiv_03_1: cross cp_op_fdiv, cp_fflags_ff_dz_one;
		cr_fdiv_04_1: cross cp_op_fdiv, cp_fflags_ff_of_one;
		cr_fdiv_05_1: cross cp_op_fdiv, cp_fflags_ff_uf_one;
		cr_fdiv_06_1: cross cp_op_fdiv, cp_fflags_ff_nx_one;

		cr_fdiv_01_2: cross cp_op_fdiv, cp_fflags_ff_de_zero;
		cr_fdiv_02_2: cross cp_op_fdiv, cp_fflags_ff_nv_zero;
		cr_fdiv_03_2: cross cp_op_fdiv, cp_fflags_ff_dz_zero;
		cr_fdiv_04_2: cross cp_op_fdiv, cp_fflags_ff_of_zero;
		cr_fdiv_05_2: cross cp_op_fdiv, cp_fflags_ff_uf_zero;
		cr_fdiv_06_2: cross cp_op_fdiv, cp_fflags_ff_nx_zero;

		cr_fsqrt_01_1: cross cp_op_fsqrt, cp_fflags_ff_de_one;
		cr_fsqrt_02_1: cross cp_op_fsqrt, cp_fflags_ff_nv_one;
		//cr_fsqrt_03_1: cross cp_op_fsqrt, cp_fflags_ff_of_one;
		//cr_fsqrt_04_1: cross cp_op_fsqrt, cp_fflags_ff_uf_one;
		cr_fsqrt_05_1: cross cp_op_fsqrt, cp_fflags_ff_nx_one;

		cr_fsqrt_01_2: cross cp_op_fsqrt, cp_fflags_ff_de_zero;
		cr_fsqrt_02_2: cross cp_op_fsqrt, cp_fflags_ff_nv_zero;
		cr_fsqrt_03_2: cross cp_op_fsqrt, cp_fflags_ff_of_zero;
		cr_fsqrt_04_2: cross cp_op_fsqrt, cp_fflags_ff_uf_zero;
		cr_fsqrt_05_2: cross cp_op_fsqrt, cp_fflags_ff_nx_zero;

		cr_fexp_01_1: cross cp_op_fexp, cp_fflags_ff_de_one;
		cr_fexp_02_1: cross cp_op_fexp, cp_fflags_ff_nv_one;
		cr_fexp_03_1: cross cp_op_fexp, cp_fflags_ff_of_one;
		cr_fexp_04_1: cross cp_op_fexp, cp_fflags_ff_uf_one;
		cr_fexp_05_1: cross cp_op_fexp, cp_fflags_ff_nx_one;

		cr_fexp_01_2: cross cp_op_fexp, cp_fflags_ff_de_zero;
		cr_fexp_02_2: cross cp_op_fexp, cp_fflags_ff_nv_zero;
		cr_fexp_03_2: cross cp_op_fexp, cp_fflags_ff_of_zero;
		cr_fexp_04_2: cross cp_op_fexp, cp_fflags_ff_uf_zero;
		cr_fexp_05_2: cross cp_op_fexp, cp_fflags_ff_nx_zero;

		cr_flog_01_1: cross cp_op_flog, cp_fflags_ff_de_one;
		cr_flog_02_1: cross cp_op_flog, cp_fflags_ff_nv_one;
		cr_flog_03_1: cross cp_op_flog, cp_fflags_ff_dz_one;
		//cr_flog_04_1: cross cp_op_flog, cp_fflags_ff_of_one;
		//cr_flog_05_1: cross cp_op_flog, cp_fflags_ff_uf_one;
		cr_flog_06_1: cross cp_op_flog, cp_fflags_ff_nx_one;

		cr_flog_01_2: cross cp_op_flog, cp_fflags_ff_de_zero;
		cr_flog_02_2: cross cp_op_flog, cp_fflags_ff_nv_zero;
		cr_flog_03_2: cross cp_op_flog, cp_fflags_ff_dz_zero;
		cr_flog_04_2: cross cp_op_flog, cp_fflags_ff_of_zero;
		cr_flog_05_2: cross cp_op_flog, cp_fflags_ff_uf_zero;
		cr_flog_06_2: cross cp_op_flog, cp_fflags_ff_nx_zero;

		cr_fcvt_w_s_01_1: cross cp_op_fcvt_w_s, cp_fflags_ff_nv_one;
		cr_fcvt_w_s_02_1: cross cp_op_fcvt_w_s, cp_fflags_ff_nx_one;

		cr_fcvt_w_s_01_2: cross cp_op_fcvt_w_s, cp_fflags_ff_de_zero;
		cr_fcvt_w_s_02_2: cross cp_op_fcvt_w_s, cp_fflags_ff_nv_zero;
		cr_fcvt_w_s_03_2: cross cp_op_fcvt_w_s, cp_fflags_ff_dz_zero;
		cr_fcvt_w_s_04_2: cross cp_op_fcvt_w_s, cp_fflags_ff_of_zero;	
		cr_fcvt_w_s_05_2: cross cp_op_fcvt_w_s, cp_fflags_ff_uf_zero;
		cr_fcvt_w_s_06_2: cross cp_op_fcvt_w_s, cp_fflags_ff_nx_zero;

		cr_fcvt_wu_s_01_1: cross cp_op_fcvt_wu_s, cp_fflags_ff_nv_one;
		cr_fcvt_wu_s_02_1: cross cp_op_fcvt_wu_s, cp_fflags_ff_nx_one;

		cr_fcvt_wu_s_01_2: cross cp_op_fcvt_wu_s, cp_fflags_ff_de_zero;
		cr_fcvt_wu_s_02_2: cross cp_op_fcvt_wu_s, cp_fflags_ff_nv_zero;
		cr_fcvt_wu_s_03_2: cross cp_op_fcvt_wu_s, cp_fflags_ff_dz_zero;
		cr_fcvt_wu_s_04_2: cross cp_op_fcvt_wu_s, cp_fflags_ff_of_zero;	
		cr_fcvt_wu_s_05_2: cross cp_op_fcvt_wu_s, cp_fflags_ff_uf_zero;
		cr_fcvt_wu_s_06_2: cross cp_op_fcvt_wu_s, cp_fflags_ff_nx_zero;

		cr_fcvt_s_w_01_1: cross cp_op_fcvt_s_w, cp_fflags_ff_nx_one;

		cr_fcvt_s_w_01_2: cross cp_op_fcvt_s_w, cp_fflags_ff_de_zero;
		cr_fcvt_s_w_02_2: cross cp_op_fcvt_s_w, cp_fflags_ff_nv_zero;
		cr_fcvt_s_w_03_2: cross cp_op_fcvt_s_w, cp_fflags_ff_dz_zero;
		cr_fcvt_s_w_04_2: cross cp_op_fcvt_s_w, cp_fflags_ff_of_zero;	
		cr_fcvt_s_w_05_2: cross cp_op_fcvt_s_w, cp_fflags_ff_uf_zero;
		cr_fcvt_s_w_06_2: cross cp_op_fcvt_s_w, cp_fflags_ff_nx_zero;

		cr_fcvt_s_wu_01_1: cross cp_op_fcvt_s_wu, cp_fflags_ff_nx_one;

		cr_fcvt_s_wu_01_2: cross cp_op_fcvt_s_wu, cp_fflags_ff_de_zero;
		cr_fcvt_s_wu_02_2: cross cp_op_fcvt_s_wu, cp_fflags_ff_nv_zero;
		cr_fcvt_s_wu_03_2: cross cp_op_fcvt_s_wu, cp_fflags_ff_dz_zero;
		cr_fcvt_s_wu_04_2: cross cp_op_fcvt_s_wu, cp_fflags_ff_of_zero;	
		cr_fcvt_s_wu_05_2: cross cp_op_fcvt_s_wu, cp_fflags_ff_uf_zero;
		cr_fcvt_s_wu_06_2: cross cp_op_fcvt_s_wu, cp_fflags_ff_nx_zero;

		cr_fmin_01_1: cross cp_op_fmin, cp_fflags_ff_nv_one;

		cr_fmin_01_2: cross cp_op_fmin, cp_fflags_ff_de_zero;
		cr_fmin_02_2: cross cp_op_fmin, cp_fflags_ff_nv_zero;
		cr_fmin_03_2: cross cp_op_fmin, cp_fflags_ff_dz_zero;
		cr_fmin_04_2: cross cp_op_fmin, cp_fflags_ff_of_zero;	
		cr_fmin_05_2: cross cp_op_fmin, cp_fflags_ff_uf_zero;
		cr_fmin_06_2: cross cp_op_fmin, cp_fflags_ff_nx_zero;

		cr_fmax_01_1: cross cp_op_fmax, cp_fflags_ff_nv_one;

		cr_fmax_01_2: cross cp_op_fmax, cp_fflags_ff_de_zero;
		cr_fmax_02_2: cross cp_op_fmax, cp_fflags_ff_nv_zero;
		cr_fmax_03_2: cross cp_op_fmax, cp_fflags_ff_dz_zero;
		cr_fmax_04_2: cross cp_op_fmax, cp_fflags_ff_of_zero;	
		cr_fmax_05_2: cross cp_op_fmax, cp_fflags_ff_uf_zero;
		cr_fmax_06_2: cross cp_op_fmax, cp_fflags_ff_nx_zero;

		cr_feq_01_1: cross cp_op_feq, cp_fflags_ff_nv_one;

		cr_feq_01_2: cross cp_op_feq, cp_fflags_ff_de_zero;
		cr_feq_02_2: cross cp_op_feq, cp_fflags_ff_nv_zero;
		cr_feq_03_2: cross cp_op_feq, cp_fflags_ff_dz_zero;
		cr_feq_04_2: cross cp_op_feq, cp_fflags_ff_of_zero;	
		cr_feq_05_2: cross cp_op_feq, cp_fflags_ff_uf_zero;
		cr_feq_06_2: cross cp_op_feq, cp_fflags_ff_nx_zero;

		cr_flt_01_1: cross cp_op_flt, cp_fflags_ff_nv_one;

		cr_flt_01_2: cross cp_op_flt, cp_fflags_ff_de_zero;
		cr_flt_02_2: cross cp_op_flt, cp_fflags_ff_nv_zero;
		cr_flt_03_2: cross cp_op_flt, cp_fflags_ff_dz_zero;
		cr_flt_04_2: cross cp_op_flt, cp_fflags_ff_of_zero;	
		cr_flt_05_2: cross cp_op_flt, cp_fflags_ff_uf_zero;
		cr_flt_06_2: cross cp_op_flt, cp_fflags_ff_nx_zero;

		cr_fle_01_1: cross cp_op_fle, cp_fflags_ff_nv_one;

		cr_fle_01_2: cross cp_op_fle, cp_fflags_ff_de_zero;
		cr_fle_02_2: cross cp_op_fle, cp_fflags_ff_nv_zero;
		cr_fle_03_2: cross cp_op_fle, cp_fflags_ff_dz_zero;
		cr_fle_04_2: cross cp_op_fle, cp_fflags_ff_of_zero;	
		cr_fle_05_2: cross cp_op_fle, cp_fflags_ff_uf_zero;
		cr_fle_06_2: cross cp_op_fle, cp_fflags_ff_nx_zero;

		cr_fne_01_1: cross cp_op_fne, cp_fflags_ff_nv_one;

		cr_fne_01_2: cross cp_op_fne, cp_fflags_ff_de_zero;
		cr_fne_02_2: cross cp_op_fne, cp_fflags_ff_nv_zero;
		cr_fne_03_2: cross cp_op_fne, cp_fflags_ff_dz_zero;
		cr_fne_04_2: cross cp_op_fne, cp_fflags_ff_of_zero;	
		cr_fne_05_2: cross cp_op_fne, cp_fflags_ff_uf_zero;
		cr_fne_06_2: cross cp_op_fne, cp_fflags_ff_nx_zero;

		cr_add_01_1: cross cp_op_add, cp_iflags_if_ze_one;
		cr_add_02_1: cross cp_op_add, cp_iflags_if_sn_one;
		cr_add_03_1: cross cp_op_add, cp_iflags_if_of_one;

		cr_add_01_2: cross cp_op_add, cp_iflags_if_ze_zero;
		cr_add_02_2: cross cp_op_add, cp_iflags_if_sn_zero;
		cr_add_03_2: cross cp_op_add, cp_iflags_if_of_zero;
		cr_add_04_2: cross cp_op_add, cp_iflags_if_dz_zero;

		cr_add_u_01_1: cross cp_op_add_u, cp_iflags_if_ze_one;
		//cr_add_u_02_1: cross cp_op_add_u, cp_iflags_if_sn_one;
		cr_add_u_03_1: cross cp_op_add_u, cp_iflags_if_of_one;

		cr_add_u_01_2: cross cp_op_add_u, cp_iflags_if_ze_zero;
		cr_add_u_02_2: cross cp_op_add_u, cp_iflags_if_sn_zero;
		cr_add_u_03_2: cross cp_op_add_u, cp_iflags_if_of_zero;
		cr_add_u_04_2: cross cp_op_add_u, cp_iflags_if_dz_zero;

		cr_sub_01_1: cross cp_op_sub, cp_iflags_if_ze_one;
		cr_sub_02_1: cross cp_op_sub, cp_iflags_if_sn_one;
		cr_sub_03_1: cross cp_op_sub, cp_iflags_if_of_one;

		cr_sub_01_2: cross cp_op_sub, cp_iflags_if_ze_zero;
		cr_sub_02_2: cross cp_op_sub, cp_iflags_if_sn_zero;
		cr_sub_03_2: cross cp_op_sub, cp_iflags_if_of_zero;
		cr_sub_04_2: cross cp_op_sub, cp_iflags_if_dz_zero;

		cr_sub_u_01_1: cross cp_op_sub_u, cp_iflags_if_ze_one;
		cr_sub_u_02_1: cross cp_op_sub_u, cp_iflags_if_sn_one;
		cr_sub_u_03_1: cross cp_op_sub_u, cp_iflags_if_of_one;

		cr_sub_u_01_2: cross cp_op_sub_u, cp_iflags_if_ze_zero;
		cr_sub_u_02_2: cross cp_op_sub_u, cp_iflags_if_sn_zero;
		cr_sub_u_03_2: cross cp_op_sub_u, cp_iflags_if_of_zero;
		cr_sub_u_04_2: cross cp_op_sub_u, cp_iflags_if_dz_zero;

		cr_mul_01_1: cross cp_op_mul, cp_iflags_if_ze_one;
		cr_mul_02_1: cross cp_op_mul, cp_iflags_if_sn_one;

		cr_mul_01_2: cross cp_op_mul, cp_iflags_if_ze_zero;
		cr_mul_02_2: cross cp_op_mul, cp_iflags_if_sn_zero;
		cr_mul_03_2: cross cp_op_mul, cp_iflags_if_of_zero;
		cr_mul_04_2: cross cp_op_mul, cp_iflags_if_dz_zero;

		cr_mulh_01_1: cross cp_op_mulh, cp_iflags_if_ze_one;
		cr_mulh_02_1: cross cp_op_mulh, cp_iflags_if_sn_one;

		cr_mulh_01_2: cross cp_op_mulh, cp_iflags_if_ze_zero;
		cr_mulh_02_2: cross cp_op_mulh, cp_iflags_if_sn_zero;
		cr_mulh_03_2: cross cp_op_mulh, cp_iflags_if_of_zero;
		cr_mulh_04_2: cross cp_op_mulh, cp_iflags_if_dz_zero;

		cr_mul_u_01_1: cross cp_op_mul_u, cp_iflags_if_ze_one;
		//cr_mul_u_02_1: cross cp_op_mul_u, cp_iflags_if_sn_one;

		cr_mul_u_01_2: cross cp_op_mul_u, cp_iflags_if_ze_zero;
		cr_mul_u_02_2: cross cp_op_mul_u, cp_iflags_if_sn_zero;
		cr_mul_u_03_2: cross cp_op_mul_u, cp_iflags_if_of_zero;
		cr_mul_u_04_2: cross cp_op_mul_u, cp_iflags_if_dz_zero;

		cr_mulh_u_01_1: cross cp_op_mulh_u, cp_iflags_if_ze_one;
		//cr_mulh_u_02_1: cross cp_op_mulh_u, cp_iflags_if_sn_one;

		cr_mulh_u_01_2: cross cp_op_mulh_u, cp_iflags_if_ze_zero;
		cr_mulh_u_02_2: cross cp_op_mulh_u, cp_iflags_if_sn_zero;
		cr_mulh_u_03_2: cross cp_op_mulh_u, cp_iflags_if_of_zero;
		cr_mulh_u_04_2: cross cp_op_mulh_u, cp_iflags_if_dz_zero;

		cr_mul_su_01_1: cross cp_op_mul_su, cp_iflags_if_ze_one;
		cr_mul_su_02_1: cross cp_op_mul_su, cp_iflags_if_sn_one;

		cr_mul_su_01_2: cross cp_op_mul_su, cp_iflags_if_ze_zero;
		cr_mul_su_02_2: cross cp_op_mul_su, cp_iflags_if_sn_zero;
		cr_mul_su_03_2: cross cp_op_mul_su, cp_iflags_if_of_zero;
		cr_mul_su_04_2: cross cp_op_mul_su, cp_iflags_if_dz_zero;

		cr_mulh_su_01_1: cross cp_op_mulh_su, cp_iflags_if_ze_one;
		cr_mulh_su_02_1: cross cp_op_mulh_su, cp_iflags_if_sn_one;

		cr_mulh_su_01_2: cross cp_op_mulh_su, cp_iflags_if_ze_zero;
		cr_mulh_su_02_2: cross cp_op_mulh_su, cp_iflags_if_sn_zero;
		cr_mulh_su_03_2: cross cp_op_mulh_su, cp_iflags_if_of_zero;
		cr_mulh_su_04_2: cross cp_op_mulh_su, cp_iflags_if_dz_zero;

		cr_madd_01_1: cross cp_op_madd, cp_iflags_if_ze_one;
		cr_madd_02_1: cross cp_op_madd, cp_iflags_if_sn_one;
		cr_madd_03_1: cross cp_op_madd, cp_iflags_if_of_one;

		cr_madd_01_2: cross cp_op_madd, cp_iflags_if_ze_zero;
		cr_madd_02_2: cross cp_op_madd, cp_iflags_if_sn_zero;
		cr_madd_03_2: cross cp_op_madd, cp_iflags_if_of_zero;
		cr_madd_04_2: cross cp_op_madd, cp_iflags_if_dz_zero;

		cr_mnadd_01_1: cross cp_op_mnadd, cp_iflags_if_ze_one;
		cr_mnadd_02_1: cross cp_op_mnadd, cp_iflags_if_sn_one;
		cr_mnadd_03_1: cross cp_op_mnadd, cp_iflags_if_of_one;

		cr_mnadd_01_2: cross cp_op_mnadd, cp_iflags_if_ze_zero;
		cr_mnadd_02_2: cross cp_op_mnadd, cp_iflags_if_sn_zero;
		cr_mnadd_03_2: cross cp_op_mnadd, cp_iflags_if_of_zero;
		cr_mnadd_04_2: cross cp_op_mnadd, cp_iflags_if_dz_zero;

		cr_msub_01_1: cross cp_op_msub, cp_iflags_if_ze_one;
		cr_msub_02_1: cross cp_op_msub, cp_iflags_if_sn_one;
		cr_msub_03_1: cross cp_op_msub, cp_iflags_if_of_one;

		cr_msub_01_2: cross cp_op_msub, cp_iflags_if_ze_zero;
		cr_msub_02_2: cross cp_op_msub, cp_iflags_if_sn_zero;
		cr_msub_03_2: cross cp_op_msub, cp_iflags_if_of_zero;
		cr_msub_04_2: cross cp_op_msub, cp_iflags_if_dz_zero;

		cr_mnsub_01_1: cross cp_op_mnsub, cp_iflags_if_ze_one;
		cr_mnsub_02_1: cross cp_op_mnsub, cp_iflags_if_sn_one;
		cr_mnsub_03_1: cross cp_op_mnsub, cp_iflags_if_of_one;

		cr_mnsub_01_2: cross cp_op_mnsub, cp_iflags_if_ze_zero;
		cr_mnsub_02_2: cross cp_op_mnsub, cp_iflags_if_sn_zero;
		cr_mnsub_03_2: cross cp_op_mnsub, cp_iflags_if_of_zero;
		cr_mnsub_04_2: cross cp_op_mnsub, cp_iflags_if_dz_zero;

		cr_div_s_01_1: cross cp_op_div_s, cp_iflags_if_ze_one;
		cr_div_s_02_1: cross cp_op_div_s, cp_iflags_if_dz_one;
		cr_div_s_03_1: cross cp_op_div_s, cp_iflags_if_sn_one;
		cr_div_s_04_1: cross cp_op_div_s, cp_iflags_if_of_one;

		cr_div_s_01_2: cross cp_op_div_s, cp_iflags_if_ze_zero;
		cr_div_s_02_2: cross cp_op_div_s, cp_iflags_if_sn_zero;
		cr_div_s_03_2: cross cp_op_div_s, cp_iflags_if_of_zero;
		cr_div_s_04_2: cross cp_op_div_s, cp_iflags_if_dz_zero;

		cr_div_u_01_1: cross cp_op_div_u, cp_iflags_if_ze_one;
		cr_div_u_02_1: cross cp_op_div_u, cp_iflags_if_dz_one;

		cr_div_u_01_2: cross cp_op_div_u, cp_iflags_if_ze_zero;
		cr_div_u_02_2: cross cp_op_div_u, cp_iflags_if_sn_zero;
		cr_div_u_03_2: cross cp_op_div_u, cp_iflags_if_of_zero;
		cr_div_u_04_2: cross cp_op_div_u, cp_iflags_if_dz_zero;

		cr_rem_s_01_1: cross cp_op_rem_s, cp_iflags_if_ze_one;
		cr_rem_s_02_1: cross cp_op_rem_s, cp_iflags_if_dz_one;
		cr_rem_s_03_1: cross cp_op_rem_s, cp_iflags_if_sn_one;
		cr_rem_s_04_1: cross cp_op_rem_s, cp_iflags_if_of_one;

		cr_rem_s_01_2: cross cp_op_rem_s, cp_iflags_if_ze_zero;
		cr_rem_s_02_2: cross cp_op_rem_s, cp_iflags_if_sn_zero;
		cr_rem_s_03_2: cross cp_op_rem_s, cp_iflags_if_of_zero;
		cr_rem_s_04_2: cross cp_op_rem_s, cp_iflags_if_dz_zero;

		cr_rem_u_01_1: cross cp_op_rem_u, cp_iflags_if_ze_one;
		cr_rem_u_02_1: cross cp_op_rem_u, cp_iflags_if_dz_one;

		cr_rem_u_01_2: cross cp_op_rem_u, cp_iflags_if_ze_zero;
		cr_rem_u_02_2: cross cp_op_rem_u, cp_iflags_if_sn_zero;
		cr_rem_u_03_2: cross cp_op_rem_u, cp_iflags_if_of_zero;
		cr_rem_u_04_2: cross cp_op_rem_u, cp_iflags_if_dz_zero;

	endgroup : cg_FPU_Flags_Coverage

	//Thinh update 191026
	covergroup cg_Flags_analysis_DE;
		cp_op_1_operand: coverpoint op_i {
						bins fsqrt = {fsqrt};
						bins fexp = {fexp};
						bins flog = {flog};
					}
		cp_op_2_operand: coverpoint op_i {
						bins fadd = {fadd};
						bins fsub = {fsub};
						bins fmul = {fmul};
						bins fdiv = {fdiv};
					}
		cp_op_3_operand: coverpoint op_i {
						bins fmadd = {fmadd};
						bins fmsub = {fmsub};
						bins fmnadd = {fmnadd};
						bins fmnsub = {fmnsub};
					}

		cp_ff_de: coverpoint fflags_o[5] { 
						bins on  = {1'b1};
						bins off = {1'b0};
					}
		cp_operand_a: coverpoint operand_a_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						
		cp_operand_b: coverpoint operand_b_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						
		cp_operand_c: coverpoint operand_c_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						

		cs_op_fflags_1_operand: cross cp_op_1_operand, cp_ff_de, cp_operand_a {
					ignore_bins de_off = binsof (cp_ff_de.off) &&
							binsof (cp_operand_a) intersect {`SN_FINITE_P , `SN_FINITE_M};
					ignore_bins de_on = binsof (cp_ff_de.on) &&
							!binsof (cp_operand_a) intersect {`SN_FINITE_P , `SN_FINITE_M};
					}
		cs_op_fflags_2_operand: cross cp_op_2_operand, cp_ff_de, cp_operand_a, cp_operand_b {
					ignore_bins de_off_1 = binsof (cp_ff_de.off) &&
							binsof (cp_operand_a) intersect {`SN_FINITE_P , `SN_FINITE_M};
					ignore_bins de_off_2 = binsof (cp_ff_de.off) &&
							binsof (cp_operand_b) intersect {`SN_FINITE_P , `SN_FINITE_M} && !binsof (cp_operand_a) intersect {`SN_FINITE_P , `SN_FINITE_M};
					ignore_bins de_on = binsof (cp_ff_de.on) &&
							!binsof (cp_operand_a) intersect {`SN_FINITE_P , `SN_FINITE_M} && !binsof (cp_operand_b) intersect {`SN_FINITE_P , `SN_FINITE_M};
					}
		cs_op_fflags_3_operand: cross cp_op_3_operand, cp_ff_de, cp_operand_a, cp_operand_b, cp_operand_c {
					ignore_bins de_off_1 = binsof (cp_ff_de.off) &&
							binsof (cp_operand_a) intersect {`SN_FINITE_P , `SN_FINITE_M};
					ignore_bins de_off_2 = binsof (cp_ff_de.off) &&
							binsof (cp_operand_b) intersect {`SN_FINITE_P , `SN_FINITE_M} && !binsof (cp_operand_a) intersect {`SN_FINITE_P , `SN_FINITE_M};
					ignore_bins de_off_3 = binsof (cp_ff_de.off) &&
							binsof (cp_operand_c) intersect {`SN_FINITE_P , `SN_FINITE_M} && !binsof (cp_operand_b) intersect {`SN_FINITE_P , `SN_FINITE_M} && !binsof (cp_operand_a) intersect {`SN_FINITE_P , `SN_FINITE_M};
					ignore_bins de_on_1 = binsof (cp_ff_de.on) &&
							!binsof (cp_operand_a) intersect {`SN_FINITE_P , `SN_FINITE_M} && !binsof (cp_operand_b) intersect {`SN_FINITE_P , `SN_FINITE_M} && !binsof (cp_operand_c) intersect {`SN_FINITE_P , `SN_FINITE_M};
					}
	endgroup : cg_Flags_analysis_DE

	//Thinh update 191026
	covergroup cg_Flags_analysis_NV_fadd_fsub;
		cp_op: coverpoint op_i {
						bins fadd = {fadd};
						bins fsub = {fsub};
					}
		cp_ff_nv: coverpoint fflags_o[4] { 
						bins on  = {1'b1};
						bins off = {1'b0};
					}
		cp_operand_a: coverpoint operand_a_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						
		cp_operand_b: coverpoint operand_b_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						

		cs_op_fflags_operand: cross cp_op, cp_ff_nv, cp_operand_a, cp_operand_b {
					ignore_bins nv_off_1 = binsof (cp_ff_nv.off) &&
							(binsof (cp_operand_a) intersect {`SNAN_M , `SNAN_P} || binsof (cp_operand_b) intersect {`SNAN_M , `SNAN_P});
					ignore_bins nv_off_2 = binsof (cp_ff_nv.off) && binsof (cp_op.fadd) &&
							((binsof (cp_operand_a.INFINITE_M) && binsof (cp_operand_b.INFINITE_P)) ||
							(binsof (cp_operand_a.INFINITE_P) && binsof (cp_operand_b.INFINITE_M)));
					ignore_bins nv_off_3 = binsof (cp_ff_nv.off) && binsof (cp_op.fsub) &&
							((binsof (cp_operand_a.INFINITE_P) && binsof (cp_operand_b.INFINITE_P)) ||
							(binsof (cp_operand_a.INFINITE_M) && binsof (cp_operand_b.INFINITE_M)));
					ignore_bins nv_on_1 = binsof (cp_ff_nv.on) &&
							!binsof (cp_operand_a) intersect {`SNAN_M , `SNAN_P};
					ignore_bins nv_on_2 = binsof (cp_ff_nv.on) &&
							!binsof (cp_operand_b) intersect {`SNAN_M , `SNAN_P};
					}
	endgroup : cg_Flags_analysis_NV_fadd_fsub

	//Thinh update 191026
	covergroup cg_Flags_analysis_NV_fmul;
		cp_op: coverpoint op_i {
						bins fmul = {fmul};
					}
		cp_ff_nv: coverpoint fflags_o[4] { 
						bins on  = {1'b1};
						bins off = {1'b0};
					}
		cp_operand_a: coverpoint operand_a_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						
		cp_operand_b: coverpoint operand_b_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						

		cs_op_fflags_operand: cross cp_op, cp_ff_nv, cp_operand_a, cp_operand_b {
					ignore_bins nv_off_1 = binsof (cp_ff_nv.off) &&
							(binsof (cp_operand_a) intersect {`SNAN_M , `SNAN_P} || binsof (cp_operand_b) intersect {`SNAN_M , `SNAN_P});
					ignore_bins nv_off_2 = binsof (cp_ff_nv.off) &&
							binsof (cp_operand_a) intersect {`ZERO_P , `ZERO_M , `SN_FINITE_P , `SN_FINITE_M} && binsof (cp_operand_b) intersect {`INFINITE_P , `INFINITE_M};
					ignore_bins nv_off_3 = binsof (cp_ff_nv.off) &&
							binsof (cp_operand_b) intersect {`ZERO_P , `ZERO_M , `SN_FINITE_P , `SN_FINITE_M} && binsof (cp_operand_a) intersect {`INFINITE_P , `INFINITE_M};
					ignore_bins nv_on_1 = binsof (cp_ff_nv.on) &&
							!binsof (cp_operand_a) intersect {`SNAN_M , `SNAN_P};
					ignore_bins nv_on_2 = binsof (cp_ff_nv.on) &&
							!binsof (cp_operand_b) intersect {`SNAN_M , `SNAN_P};
					}
	endgroup : cg_Flags_analysis_NV_fmul

	covergroup cg_Flags_analysis_NV_fmadd_fmsub_fmnadd_fmnsub;
		cp_op: coverpoint op_i {
						bins fmadd = {fmadd};
						bins fmsub = {fmsub};
						bins fmnadd = {fmnadd};
						bins fmnsub = {fmnsub};
					}
		cp_ff_nv: coverpoint fflags_o[4] { 
						bins on  = {1'b1};
						bins off = {1'b0};
					}
		cp_operand_a: coverpoint operand_a_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						
		cp_operand_b: coverpoint operand_b_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						
		cp_operand_c: coverpoint operand_c_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						

		cs_op_fflags_operand: cross cp_op, cp_ff_nv, cp_operand_a, cp_operand_b, cp_operand_c {
					ignore_bins nv_off_1 = binsof (cp_ff_nv.off) &&
							(binsof (cp_operand_a) intersect {`SNAN_M , `SNAN_P} || binsof (cp_operand_b) intersect {`SNAN_M , `SNAN_P} || binsof (cp_operand_c) intersect {`SNAN_M , `SNAN_P});
					ignore_bins nv_off_2 = binsof (cp_ff_nv.off) &&
							binsof (cp_operand_a) intersect {`ZERO_P , `ZERO_M , `SN_FINITE_P , `SN_FINITE_M} && binsof (cp_operand_b) intersect {`INFINITE_P , `INFINITE_M};
					ignore_bins nv_off_3 = binsof (cp_ff_nv.off) &&
							binsof (cp_operand_b) intersect {`ZERO_P , `ZERO_M , `SN_FINITE_P , `SN_FINITE_M} && binsof (cp_operand_a) intersect {`INFINITE_P , `INFINITE_M};
					ignore_bins nv_off_fmadd_01 = binsof(cp_op.fmadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.NO_FINITE_M) && binsof(cp_operand_b.INFINITE_M ) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmadd_02 = binsof(cp_op.fmadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.NO_FINITE_M) && binsof(cp_operand_b.INFINITE_P ) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmadd_03 = binsof(cp_op.fmadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.NO_FINITE_P) && binsof(cp_operand_b.INFINITE_M ) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmadd_04 = binsof(cp_op.fmadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.NO_FINITE_P) && binsof(cp_operand_b.INFINITE_P ) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmadd_05 = binsof(cp_op.fmadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_M ) && binsof(cp_operand_b.NO_FINITE_M) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmadd_06 = binsof(cp_op.fmadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_M ) && binsof(cp_operand_b.NO_FINITE_P) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmadd_07 = binsof(cp_op.fmadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_M ) && binsof(cp_operand_b.INFINITE_M ) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmadd_08 = binsof(cp_op.fmadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_M ) && binsof(cp_operand_b.INFINITE_P ) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmadd_09 = binsof(cp_op.fmadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_P ) && binsof(cp_operand_b.NO_FINITE_M) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmadd_10 = binsof(cp_op.fmadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_P ) && binsof(cp_operand_b.NO_FINITE_P) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmadd_11 = binsof(cp_op.fmadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_P ) && binsof(cp_operand_b.INFINITE_M ) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmadd_12 = binsof(cp_op.fmadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_P ) && binsof(cp_operand_b.INFINITE_P ) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmnadd_01 = binsof(cp_op.fmnadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.NO_FINITE_M) && binsof(cp_operand_b.INFINITE_M ) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmnadd_02 = binsof(cp_op.fmnadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.NO_FINITE_M) && binsof(cp_operand_b.INFINITE_P ) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmnadd_03 = binsof(cp_op.fmnadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.NO_FINITE_P) && binsof(cp_operand_b.INFINITE_M ) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmnadd_04 = binsof(cp_op.fmnadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.NO_FINITE_P) && binsof(cp_operand_b.INFINITE_P ) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmnadd_05 = binsof(cp_op.fmnadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_M ) && binsof(cp_operand_b.NO_FINITE_M) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmnadd_06 = binsof(cp_op.fmnadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_M ) && binsof(cp_operand_b.NO_FINITE_P) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmnadd_07 = binsof(cp_op.fmnadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_M ) && binsof(cp_operand_b.INFINITE_M ) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmnadd_08 = binsof(cp_op.fmnadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_M ) && binsof(cp_operand_b.INFINITE_P ) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmnadd_09 = binsof(cp_op.fmnadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_P ) && binsof(cp_operand_b.NO_FINITE_M) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmnadd_10 = binsof(cp_op.fmnadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_P ) && binsof(cp_operand_b.NO_FINITE_P) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmnadd_11 = binsof(cp_op.fmnadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_P ) && binsof(cp_operand_b.INFINITE_M ) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmnadd_12 = binsof(cp_op.fmnadd) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_P ) && binsof(cp_operand_b.INFINITE_P ) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmsub_01 = binsof(cp_op.fmsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.NO_FINITE_M) && binsof(cp_operand_b.INFINITE_M ) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmsub_02 = binsof(cp_op.fmsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.NO_FINITE_M) && binsof(cp_operand_b.INFINITE_P ) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmsub_03 = binsof(cp_op.fmsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.NO_FINITE_P) && binsof(cp_operand_b.INFINITE_M ) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmsub_04 = binsof(cp_op.fmsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.NO_FINITE_P) && binsof(cp_operand_b.INFINITE_P ) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmsub_05 = binsof(cp_op.fmsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_M ) && binsof(cp_operand_b.NO_FINITE_M) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmsub_06 = binsof(cp_op.fmsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_M ) && binsof(cp_operand_b.NO_FINITE_P) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmsub_07 = binsof(cp_op.fmsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_M ) && binsof(cp_operand_b.INFINITE_M ) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmsub_08 = binsof(cp_op.fmsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_M ) && binsof(cp_operand_b.INFINITE_P ) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmsub_09 = binsof(cp_op.fmsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_P ) && binsof(cp_operand_b.NO_FINITE_M) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmsub_10 = binsof(cp_op.fmsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_P ) && binsof(cp_operand_b.NO_FINITE_P) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmsub_11 = binsof(cp_op.fmsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_P ) && binsof(cp_operand_b.INFINITE_M ) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmsub_12 = binsof(cp_op.fmsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_P ) && binsof(cp_operand_b.INFINITE_P ) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmnsub_01 = binsof(cp_op.fmnsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.NO_FINITE_M) && binsof(cp_operand_b.INFINITE_M ) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmnsub_02 = binsof(cp_op.fmnsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.NO_FINITE_M) && binsof(cp_operand_b.INFINITE_P ) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmnsub_03 = binsof(cp_op.fmnsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.NO_FINITE_P) && binsof(cp_operand_b.INFINITE_M ) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmnsub_04 = binsof(cp_op.fmnsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.NO_FINITE_P) && binsof(cp_operand_b.INFINITE_P ) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmnsub_05 = binsof(cp_op.fmnsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_M ) && binsof(cp_operand_b.NO_FINITE_M) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmnsub_06 = binsof(cp_op.fmnsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_M ) && binsof(cp_operand_b.NO_FINITE_P) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmnsub_07 = binsof(cp_op.fmnsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_M ) && binsof(cp_operand_b.INFINITE_M ) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmnsub_08 = binsof(cp_op.fmnsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_M ) && binsof(cp_operand_b.INFINITE_P ) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmnsub_09 = binsof(cp_op.fmnsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_P ) && binsof(cp_operand_b.NO_FINITE_M) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmnsub_10 = binsof(cp_op.fmnsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_P ) && binsof(cp_operand_b.NO_FINITE_P) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_off_fmnsub_11 = binsof(cp_op.fmnsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_P ) && binsof(cp_operand_b.INFINITE_M ) && binsof(cp_operand_c.INFINITE_M); 
					ignore_bins nv_off_fmnsub_12 = binsof(cp_op.fmnsub) && binsof(cp_ff_nv.off) && binsof(cp_operand_a.INFINITE_P ) && binsof(cp_operand_b.INFINITE_P ) && binsof(cp_operand_c.INFINITE_P); 
					ignore_bins nv_on_1 = binsof (cp_ff_nv.on) &&
							!binsof (cp_operand_a) intersect {`SNAN_M , `SNAN_P};
					ignore_bins nv_on_2 = binsof (cp_ff_nv.on) &&
							!binsof (cp_operand_b) intersect {`SNAN_M , `SNAN_P};
					ignore_bins nv_on_3 = binsof (cp_ff_nv.on) &&
							!binsof (cp_operand_c) intersect {`SNAN_M , `SNAN_P};
					ignore_bins nv_on_4 = binsof (cp_ff_nv.on) &&
							binsof (cp_operand_a.SNAN_P) && binsof (cp_operand_b.SNAN_M) && binsof (cp_operand_a.SNAN_M);
					}
	endgroup : cg_Flags_analysis_NV_fmadd_fmsub_fmnadd_fmnsub

	//Thinh update 191026
	covergroup cg_Flags_analysis_NV_fdiv;
		cp_op: coverpoint op_i {
						bins fdiv = {fdiv};
					}
		cp_ff_nv: coverpoint fflags_o[4] { 
						bins on  = {1'b1};
						bins off = {1'b0};
					}
		cp_operand_a: coverpoint operand_a_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						
		cp_operand_b: coverpoint operand_b_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						

		cs_op_fflags_operand: cross cp_op, cp_ff_nv, cp_operand_a, cp_operand_b{
					ignore_bins nv_off_1 = binsof (cp_ff_nv.off) &&
							(binsof (cp_operand_a) intersect {`SNAN_M , `SNAN_P} || binsof (cp_operand_b) intersect {`SNAN_M , `SNAN_P});
					ignore_bins nv_off_2 = binsof (cp_ff_nv.off) &&
							binsof (cp_operand_a) intersect {`ZERO_P , `ZERO_M , `SN_FINITE_P , `SN_FINITE_M} && binsof (cp_operand_b) intersect {`ZERO_P , `ZERO_M , `SN_FINITE_P , `SN_FINITE_M};
					ignore_bins nv_off_3 = binsof (cp_ff_nv.off) &&
							binsof (cp_operand_b) intersect {`INFINITE_P , `INFINITE_M} && binsof (cp_operand_a) intersect {`INFINITE_P , `INFINITE_M};
					ignore_bins nv_on_1 = binsof (cp_ff_nv.on) &&
							!binsof (cp_operand_a) intersect {`SNAN_M , `SNAN_P};
					ignore_bins nv_on_2 = binsof (cp_ff_nv.on) &&
							!binsof (cp_operand_b) intersect {`SNAN_M , `SNAN_P};
					}
	endgroup : cg_Flags_analysis_NV_fdiv

	//Thinh update 191026
	covergroup cg_Flags_analysis_NV_fsqrt_flog;
		cp_op: coverpoint op_i {
						bins fsqrt = {fsqrt};
						bins flog = {flog};
					}
		cp_ff_nv: coverpoint fflags_o[4] { 
						bins on  = {1'b1};
						bins off = {1'b0};
					}
		cp_operand_a: coverpoint operand_a_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						


		cs_op_fflags_operand: cross cp_op, cp_ff_nv, cp_operand_a {
					ignore_bins nv_off_1 = binsof (cp_ff_nv.off) &&
							binsof (cp_operand_a) intersect {`SNAN_M , `SNAN_P};
					ignore_bins nv_off_2 = binsof (cp_ff_nv.off) &&
							binsof (cp_operand_a) intersect {`NO_FINITE_M , `INFINITE_M , `SN_FINITE_M};
					ignore_bins nv_on_1 = binsof (cp_ff_nv.on) &&
							!binsof (cp_operand_a) intersect {`SNAN_M , `SNAN_P};
					ignore_bins nv_on_2 = binsof (cp_ff_nv.on) &&
							!binsof (cp_operand_a) intersect {`NO_FINITE_M , `INFINITE_M , `SN_FINITE_M};
					}
	endgroup : cg_Flags_analysis_NV_fsqrt_flog

	//Thinh update 191026
	covergroup cg_Flags_analysis_NV_fexp;
		cp_op: coverpoint op_i {
						bins fexp = {fexp};
					}
		cp_ff_nv: coverpoint fflags_o[4] { 
						bins on  = {1'b1};
						bins off  = {1'b0};
					}
		cp_operand_a: coverpoint operand_a_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}

		cs_op_fflags_operand: cross cp_op, cp_ff_nv, cp_operand_a {
					ignore_bins nv_on = binsof (cp_ff_nv.on) &&
							binsof (cp_operand_a) intersect {`SN_FINITE_M , `SN_FINITE_P , `NO_FINITE_M , `NO_FINITE_P , `INFINITE_M , `INFINITE_P , `ZERO_M , `ZERO_P , `QNAN_M , `QNAN_P};
					ignore_bins nv_off = binsof (cp_ff_nv.off) &&
							binsof (cp_operand_a) intersect {`SNAN_M , `SNAN_P};
					}						
	endgroup : cg_Flags_analysis_NV_fexp

	//Thinh update 191026
	covergroup cg_Flags_analysis_NV_feq_fne_fmin_fmax;
		cp_op: coverpoint op_i {
						bins fmin = {fmin};
						bins fmax = {fmax};
						bins feq = {feq};
						bins fne = {fne};
					}
		cp_ff_nv: coverpoint fflags_o[4] { 
						bins on  = {1'b1};
						bins off  = {1'b0};
					}
		cp_operand_a: coverpoint operand_a_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						
		cp_operand_b: coverpoint operand_b_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						

		cs_op_fflags_operand: cross cp_op, cp_ff_nv, cp_operand_a, cp_operand_b {
					ignore_bins nv_off_1 = binsof (cp_ff_nv.off) &&
							binsof (cp_operand_a) intersect {`SN_FINITE_M , `SN_FINITE_P , `NO_FINITE_M , `NO_FINITE_P , `INFINITE_M , `INFINITE_P , `ZERO_M , `ZERO_P , `QNAN_M , `QNAN_P} &&
							binsof (cp_operand_b) intersect {`SNAN_M , `SNAN_P};
					ignore_bins nv_off_2 = binsof (cp_ff_nv.off) &&
							binsof (cp_operand_a) intersect {`SNAN_M , `SNAN_P};
					ignore_bins nv_on = binsof (cp_ff_nv.on) &&
							binsof (cp_operand_a) intersect {`SN_FINITE_M , `SN_FINITE_P , `NO_FINITE_M , `NO_FINITE_P , `INFINITE_M , `INFINITE_P , `ZERO_M , `ZERO_P , `QNAN_M , `QNAN_P} &&
							binsof (cp_operand_b) intersect {`SN_FINITE_M , `SN_FINITE_P , `NO_FINITE_M , `NO_FINITE_P , `INFINITE_M , `INFINITE_P , `ZERO_M , `ZERO_P , `QNAN_M , `QNAN_P};
					}
	endgroup : cg_Flags_analysis_NV_feq_fne_fmin_fmax

	//Thinh update 191026
	covergroup cg_Flags_analysis_NV_flt_fle;
		cp_op: coverpoint op_i {
						bins flt = {flt};
						bins fle = {fle};
					}
		cp_ff_nv: coverpoint fflags_o[4] { 
						bins on  = {1'b1};
						bins off  = {1'b0};
					}
		cp_operand_a: coverpoint operand_a_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						
		cp_operand_b: coverpoint operand_b_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						

		cs_op_fflags_operand: cross cp_op, cp_ff_nv, cp_operand_a, cp_operand_b {
					ignore_bins nv_off_1 = binsof (cp_ff_nv.off) &&
							binsof (cp_operand_a) intersect {`SN_FINITE_M , `SN_FINITE_P , `NO_FINITE_M , `NO_FINITE_P , `INFINITE_M , `INFINITE_P , `ZERO_M , `ZERO_P} &&
							binsof (cp_operand_b) intersect {`SNAN_M , `SNAN_P , `QNAN_M , `QNAN_P};
					ignore_bins nv_off_2 = binsof (cp_ff_nv.off) &&
							binsof (cp_operand_a) intersect {`SNAN_M , `SNAN_P , `QNAN_M , `QNAN_P};
					ignore_bins nv_on = binsof (cp_ff_nv.on) &&
							binsof (cp_operand_a) intersect {`SN_FINITE_M , `SN_FINITE_P , `NO_FINITE_M , `NO_FINITE_P , `INFINITE_M , `INFINITE_P , `ZERO_M , `ZERO_P} &&
							binsof (cp_operand_b) intersect {`SN_FINITE_M , `SN_FINITE_P , `NO_FINITE_M , `NO_FINITE_P , `INFINITE_M , `INFINITE_P , `ZERO_M , `ZERO_P};
					}
	endgroup : cg_Flags_analysis_NV_flt_fle

	//Thinh update 191026
	covergroup cg_Flags_analysis_NV_fcvt_w_s;
		cp_op: coverpoint op_i {
						bins fcvt_w_s  = {fcvt_w_s };
					}
		cp_ff_nv: coverpoint fflags_o[4] { 
						bins on  = {1'b1};
						bins off  = {1'b0};
					}
		cp_operand_a: coverpoint operand_a_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}
		cp_operand_a_out_of_range: coverpoint operand_a_i {
						bins out_of_range_p = {[32'h4F00_0000:32'h7F7F_FFFF]};
						bins out_of_range_m = {[32'hCF00_0001:32'hFF7F_FFFF]};
					}

		cs_op_fflags_operand_w_s_1: cross cp_op, cp_ff_nv, cp_operand_a {
					ignore_bins nv_off = binsof (cp_ff_nv.off) &&
							binsof (cp_operand_a) intersect {`INFINITE_M , `INFINITE_P , `SNAN_M , `SNAN_P , `QNAN_M , `QNAN_P};
					ignore_bins nv_on = binsof (cp_ff_nv.on) &&
							binsof (cp_operand_a) intersect {`SN_FINITE_M , `SN_FINITE_P , `ZERO_M , `ZERO_P};
					}
		cs_op_fflags_operand_w_s_2: cross cp_op, cp_ff_nv, cp_operand_a_out_of_range {
					ignore_bins nv_off = binsof (cp_ff_nv.off);
					}
	endgroup : cg_Flags_analysis_NV_fcvt_w_s

	//Thinh update 191026
	covergroup cg_Flags_analysis_NV_fcvt_wu_s;
		cp_op: coverpoint op_i {
						bins fcvt_wu_s = {fcvt_wu_s};
					}
		cp_ff_nv: coverpoint fflags_o[4] { 
						bins on  = {1'b1};
						bins off  = {1'b0};
					}
		cp_operand_a: coverpoint operand_a_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}
		cp_out_of_range: coverpoint operand_a_i {
						bins out_of_range = {[32'h4F80_0000:32'h7F7F_FFFF]};
					}

		cs_op_fflags_operand_wu_s_1: cross cp_op, cp_ff_nv, cp_operand_a {
					ignore_bins nv_off = binsof (cp_ff_nv.off) &&
							binsof (cp_operand_a) intersect {`INFINITE_M , `INFINITE_P, `QNAN_M , `QNAN_P , `SNAN_M , `SNAN_P};
					ignore_bins nv_on = binsof (cp_ff_nv.on) &&
							binsof (cp_operand_a) intersect {`SN_FINITE_P , `ZERO_M , `ZERO_P};
					}
		cs_op_fflags_operand_wu_s_2: cross cp_op, cp_ff_nv, cp_out_of_range {
					ignore_bins nv_off = binsof (cp_ff_nv.off);
					}
	endgroup : cg_Flags_analysis_NV_fcvt_wu_s

	covergroup cg_Flags_analysis_DZ_fdiv_flog;
		cp_op_fdiv: coverpoint op_i {
						bins fdiv = {fdiv};
					}
		cp_op_flog: coverpoint op_i {
						bins flog = {flog};
					}
		cp_ff_dz: coverpoint fflags_o[3] { 
						bins on  = {1'b1};
						bins off = {1'b0};
					}
		cp_operand_a: coverpoint operand_a_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						
		cp_operand_b: coverpoint operand_b_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						

		cs_op_fflags_operand_flog: cross cp_op_flog, cp_ff_dz, cp_operand_a {
					ignore_bins dz_off = binsof (cp_ff_dz.off) &&
							binsof (cp_operand_a) intersect {`SN_FINITE_M , `SN_FINITE_P , `ZERO_M , `ZERO_P};
					ignore_bins dz_on = binsof (cp_ff_dz.on) &&
							!binsof (cp_operand_a) intersect {`SN_FINITE_M , `SN_FINITE_P , `ZERO_M , `ZERO_P};
					}
		cs_op_fflags_operand_fdiv: cross cp_op_fdiv, cp_ff_dz, cp_operand_a, cp_operand_b {
					ignore_bins dz_off = binsof (cp_ff_dz.off) &&
							binsof (cp_operand_a) intersect {`NO_FINITE_M , `NO_FINITE_P} && binsof (cp_operand_b) intersect {`SN_FINITE_M , `SN_FINITE_P , `ZERO_M , `ZERO_P};
					ignore_bins dz_on_1 = binsof (cp_ff_dz.on) &&
							!binsof (cp_operand_a) intersect {`NO_FINITE_M , `NO_FINITE_P};
					ignore_bins dz_on_2 = binsof (cp_ff_dz.on) &&
							binsof (cp_operand_a) intersect {`NO_FINITE_M , `NO_FINITE_P} && !binsof (cp_operand_b) intersect {`SN_FINITE_M , `SN_FINITE_P , `ZERO_M , `ZERO_P};
					}
	endgroup : cg_Flags_analysis_DZ_fdiv_flog

	covergroup cg_Flags_analysis_OF;
		cp_op_1_operand: coverpoint op_i {
						bins fsqrt = {fsqrt};
						bins fexp = {fexp};
						bins flog = {flog};
					}
		cp_op_2_operand: coverpoint op_i {
						bins fmul = {fmul};
						bins fdiv = {fdiv};
						bins fadd = {fadd};
						bins fsub = {fsub};
					}
		cp_op_3_operand: coverpoint op_i {
						bins fmadd = {fmadd};
						bins fmsub = {fmsub};
						bins fmnadd = {fmnadd};
						bins fmnsub = {fmnsub};
					}
		cp_ff_of: coverpoint fflags_o[2] { 
						bins on  = {1'b1};
						bins off = {1'b0};
					}
		cp_operand_a: coverpoint operand_a_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						
		cp_operand_b: coverpoint operand_b_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						
		cp_operand_c: coverpoint operand_c_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						

		cs_op_fflags_1_operand: cross cp_op_1_operand, cp_ff_of, cp_operand_a {
					ignore_bins of_on_flog_fsqrt = binsof (cp_ff_of.on) && binsof (cp_op_1_operand) intersect {flog, fsqrt};
					ignore_bins of_on_fexp = binsof (cp_ff_of.on) && binsof (cp_op_1_operand.fexp) && !binsof (cp_operand_a) intersect {`NO_FINITE_P};
					}						
		cs_op_fflags_2_operand: cross cp_op_2_operand, cp_ff_of, cp_operand_a, cp_operand_b {
					ignore_bins of_on_1 = binsof (cp_ff_of.on) && !binsof (cp_operand_a) intersect {`NO_FINITE_M , `NO_FINITE_P};
					ignore_bins of_on_2 = binsof (cp_ff_of.on) && binsof (cp_operand_a) intersect {`NO_FINITE_M , `NO_FINITE_P} && !binsof (cp_operand_b) intersect {`NO_FINITE_M , `NO_FINITE_P};
					ignore_bins of_on_3 = binsof (cp_ff_of.on) && binsof (cp_op_2_operand.fsub) &&
							(binsof (cp_operand_a) intersect {`NO_FINITE_M} && binsof (cp_operand_b) intersect {`NO_FINITE_M} ||
							binsof (cp_operand_a) intersect {`NO_FINITE_P} && binsof (cp_operand_b) intersect {`NO_FINITE_P});
					ignore_bins of_on_4 = binsof (cp_ff_of.on) && binsof (cp_op_2_operand.fadd) &&
							(binsof (cp_operand_a) intersect {`NO_FINITE_M} && binsof (cp_operand_b) intersect {`NO_FINITE_P} ||
							binsof (cp_operand_a) intersect {`NO_FINITE_P} && binsof (cp_operand_b) intersect {`NO_FINITE_M});
					}						
		cs_op_fflags_3_operand: cross cp_op_3_operand, cp_ff_of, cp_operand_a, cp_operand_b, cp_operand_c{
					ignore_bins of_on_1 = binsof (cp_ff_of.on) && !binsof (cp_operand_a) intersect {`NO_FINITE_M , `NO_FINITE_P};
					ignore_bins of_on_2 = binsof (cp_ff_of.on) && binsof (cp_operand_a) intersect {`NO_FINITE_M , `NO_FINITE_P} && !binsof (cp_operand_b) intersect {`NO_FINITE_M , `NO_FINITE_P};
					ignore_bins of_on_3 = binsof (cp_ff_of.on) && binsof (cp_operand_a) intersect {`NO_FINITE_M , `NO_FINITE_P} && binsof (cp_operand_b) intersect {`NO_FINITE_M , `NO_FINITE_P} &&
								binsof (cp_operand_c) intersect {`INFINITE_M , `INFINITE_P, `QNAN_M , `QNAN_P , `SNAN_M , `SNAN_P};
					}
	endgroup : cg_Flags_analysis_OF

	covergroup cg_Flags_analysis_UF;
		cp_op_1_operand: coverpoint op_i {
						bins fsqrt = {fsqrt};
						bins fexp = {fexp};
						bins flog = {flog};
					}
		cp_op_2_operand: coverpoint op_i {
						bins fmul = {fmul};
						bins fdiv = {fdiv};
						bins fadd = {fadd};
						bins fsub = {fsub};
					}
		cp_op_3_operand: coverpoint op_i {
						bins fmadd = {fmadd};
						bins fmsub = {fmsub};
						bins fmnadd = {fmnadd};
						bins fmnsub = {fmnsub};
					}
		cp_ff_uf: coverpoint fflags_o[1] { 
						bins on  = {1'b1};
						bins off = {1'b0};
					}
		cp_operand_a: coverpoint operand_a_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						
		cp_operand_b: coverpoint operand_b_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						
		cp_operand_c: coverpoint operand_c_i {
						bins SNAN_P   = {`SNAN_P};
						bins SNAN_M   = {`SNAN_M};
						bins QNAN_P   = {`QNAN_P};
						bins QNAN_M   = {`QNAN_M};
						bins ZERO_P = {`ZERO_P};
						bins ZERO_M = {`ZERO_M};
						bins INFINITE_P = {`INFINITE_P};
						bins INFINITE_M = {`INFINITE_M};
						bins NO_FINITE_P = {`NO_FINITE_P};
						bins NO_FINITE_M = {`NO_FINITE_M};
						bins SN_FINITE_P = {`SN_FINITE_P};
						bins SN_FINITE_M = {`SN_FINITE_M};
					}						

		cs_op_fflags_1_operand: cross cp_op_1_operand, cp_ff_uf, cp_operand_a {
					ignore_bins of_on_flog_fsqrt = binsof (cp_ff_uf.on) && binsof (cp_op_1_operand) intersect {flog, fsqrt};
					ignore_bins of_on_fexp = binsof (cp_ff_uf.on) && binsof (cp_op_1_operand.fexp) && !binsof (cp_operand_a) intersect {`NO_FINITE_M};
					}						
		cs_op_fflags_2_operand: cross cp_op_2_operand, cp_ff_uf, cp_operand_a, cp_operand_b {
					ignore_bins of_on_1 = binsof (cp_ff_uf.on) && !binsof (cp_operand_a) intersect {`NO_FINITE_M , `NO_FINITE_P};
					ignore_bins of_on_2 = binsof (cp_ff_uf.on) && binsof (cp_operand_a) intersect {`NO_FINITE_M , `NO_FINITE_P} && !binsof (cp_operand_b) intersect {`NO_FINITE_M , `NO_FINITE_P};
					ignore_bins of_on_3 = binsof (cp_ff_uf.on) && binsof (cp_op_2_operand.fadd) &&
							(binsof (cp_operand_a) intersect {`NO_FINITE_M} && binsof (cp_operand_b) intersect {`NO_FINITE_M} ||
							binsof (cp_operand_a) intersect {`NO_FINITE_P} && binsof (cp_operand_b) intersect {`NO_FINITE_P});
					ignore_bins of_on_4 = binsof (cp_ff_uf.on) && binsof (cp_op_2_operand.fsub) &&
							(binsof (cp_operand_a) intersect {`NO_FINITE_M} && binsof (cp_operand_b) intersect {`NO_FINITE_P} ||
							binsof (cp_operand_a) intersect {`NO_FINITE_P} && binsof (cp_operand_b) intersect {`NO_FINITE_M});
					}						
		cs_op_fflags_3_operand: cross cp_op_3_operand, cp_ff_uf, cp_operand_a, cp_operand_b, cp_operand_c{
					ignore_bins uf_on_01 = binsof (cp_ff_uf.on) && !binsof (cp_operand_a) intersect {`NO_FINITE_M , `NO_FINITE_P};
					ignore_bins uf_on_02 = binsof (cp_ff_uf.on) && binsof (cp_operand_a) intersect {`NO_FINITE_M , `NO_FINITE_P} && !binsof (cp_operand_b) intersect {`NO_FINITE_M , `NO_FINITE_P};
					ignore_bins uf_on_03 = binsof (cp_ff_uf.on) && binsof (cp_operand_a) intersect {`NO_FINITE_M , `NO_FINITE_P} && binsof (cp_operand_b) intersect {`NO_FINITE_M , `NO_FINITE_P} &&
						    	   	binsof (cp_operand_c) intersect {`INFINITE_M , `INFINITE_P, `QNAN_M , `QNAN_P , `SNAN_M , `SNAN_P};
					ignore_bins uf_on_04 = binsof (cp_op_3_operand.fmnsub) 	&& binsof (cp_ff_uf.on) && binsof (cp_operand_a.NO_FINITE_M) && binsof (cp_operand_b.NO_FINITE_M) && binsof (cp_operand_c.NO_FINITE_M);
					ignore_bins uf_on_05 = binsof (cp_op_3_operand.fmnsub) 	&& binsof (cp_ff_uf.on) && binsof (cp_operand_a.NO_FINITE_M) && binsof (cp_operand_b.NO_FINITE_P) && binsof (cp_operand_c.NO_FINITE_P);
					ignore_bins uf_on_06 = binsof (cp_op_3_operand.fmnsub) 	&& binsof (cp_ff_uf.on) && binsof (cp_operand_a.NO_FINITE_P) && binsof (cp_operand_b.NO_FINITE_M) && binsof (cp_operand_c.NO_FINITE_P);
					ignore_bins uf_on_07 = binsof (cp_op_3_operand.fmnsub) 	&& binsof (cp_ff_uf.on) && binsof (cp_operand_a.NO_FINITE_P) && binsof (cp_operand_b.NO_FINITE_P) && binsof (cp_operand_c.NO_FINITE_M);
					ignore_bins uf_on_08 = binsof (cp_op_3_operand.fmnadd) 	&& binsof (cp_ff_uf.on) && binsof (cp_operand_a.NO_FINITE_M) && binsof (cp_operand_b.NO_FINITE_M) && binsof (cp_operand_c.NO_FINITE_P);
					ignore_bins uf_on_09 = binsof (cp_op_3_operand.fmnadd) 	&& binsof (cp_ff_uf.on) && binsof (cp_operand_a.NO_FINITE_M) && binsof (cp_operand_b.NO_FINITE_P) && binsof (cp_operand_c.NO_FINITE_M);
					ignore_bins uf_on_10 = binsof (cp_op_3_operand.fmnadd) 	&& binsof (cp_ff_uf.on) && binsof (cp_operand_a.NO_FINITE_P) && binsof (cp_operand_b.NO_FINITE_M) && binsof (cp_operand_c.NO_FINITE_M);
					ignore_bins uf_on_11 = binsof (cp_op_3_operand.fmnadd) 	&& binsof (cp_ff_uf.on) && binsof (cp_operand_a.NO_FINITE_P) && binsof (cp_operand_b.NO_FINITE_P) && binsof (cp_operand_c.NO_FINITE_P);
					ignore_bins uf_on_12 = binsof (cp_op_3_operand.fmsub )	&& binsof (cp_ff_uf.on) && binsof (cp_operand_a.NO_FINITE_M) && binsof (cp_operand_b.NO_FINITE_M) && binsof (cp_operand_c.NO_FINITE_M);
					ignore_bins uf_on_13 = binsof (cp_op_3_operand.fmsub )	&& binsof (cp_ff_uf.on) && binsof (cp_operand_a.NO_FINITE_M) && binsof (cp_operand_b.NO_FINITE_P) && binsof (cp_operand_c.NO_FINITE_P);
					ignore_bins uf_on_14 = binsof (cp_op_3_operand.fmsub )	&& binsof (cp_ff_uf.on) && binsof (cp_operand_a.NO_FINITE_P) && binsof (cp_operand_b.NO_FINITE_M) && binsof (cp_operand_c.NO_FINITE_P);
					ignore_bins uf_on_15 = binsof (cp_op_3_operand.fmsub )	&& binsof (cp_ff_uf.on) && binsof (cp_operand_a.NO_FINITE_P) && binsof (cp_operand_b.NO_FINITE_P) && binsof (cp_operand_c.NO_FINITE_M);
					ignore_bins uf_on_16 = binsof (cp_op_3_operand.fmadd )	&& binsof (cp_ff_uf.on) && binsof (cp_operand_a.NO_FINITE_M) && binsof (cp_operand_b.NO_FINITE_M) && binsof (cp_operand_c.NO_FINITE_P);
					ignore_bins uf_on_17 = binsof (cp_op_3_operand.fmadd )	&& binsof (cp_ff_uf.on) && binsof (cp_operand_a.NO_FINITE_M) && binsof (cp_operand_b.NO_FINITE_P) && binsof (cp_operand_c.NO_FINITE_M);
					ignore_bins uf_on_18 = binsof (cp_op_3_operand.fmadd )	&& binsof (cp_ff_uf.on) && binsof (cp_operand_a.NO_FINITE_P) && binsof (cp_operand_b.NO_FINITE_M) && binsof (cp_operand_c.NO_FINITE_M);
					ignore_bins uf_on_19 = binsof (cp_op_3_operand.fmadd )	&& binsof (cp_ff_uf.on) && binsof (cp_operand_a.NO_FINITE_P) && binsof (cp_operand_b.NO_FINITE_P) && binsof (cp_operand_c.NO_FINITE_P);
					}
	endgroup : cg_Flags_analysis_UF

	//Thinh update 191028
	covergroup cg_Flags_analysis_NX;
		cp_op_1_operand: coverpoint op_i {
						bins fsqrt = {fsqrt};
						bins fexp = {fexp};
						bins flog = {flog};
					}
		cp_op_2_operand: coverpoint op_i {
						bins fmul = {fmul};
						bins fdiv = {fdiv};
						bins fadd = {fadd};
						bins fsub = {fsub};
					}
		cp_op_3_operand: coverpoint op_i {
						bins fmadd = {fmadd};
						bins fmsub = {fmsub};
						bins fmnadd = {fmnadd};
						bins fmnsub = {fmnsub};
					}

		cp_ff_nx_on: coverpoint fflags_o[0] { 
						bins on  = {1'b1};
					}
		cp_ff_nx_off: coverpoint fflags_o[0] { 
						bins off = {1'b0};
					}
		cp_ff_nv_on: coverpoint fflags_o[4] { 
						bins on = {1'b1};
					}						
		cp_ff_nv_off: coverpoint fflags_o[4] { 
						bins off = {1'b0};
					}						
		cp_ff_dz_on: coverpoint fflags_o[3] { 
						bins on = {1'b1};
					}						
		cp_ff_dz_off: coverpoint fflags_o[3] { 
						bins off = {1'b0};
					}

		cp_operand_a_sn: coverpoint operand_a_i {
						bins subnormal_p = {`SN_FINITE_P};
						bins subnormal_m = {`SN_FINITE_M};
					}
		cp_operand_a_other: coverpoint operand_a_i {
						bins zero_p = {`ZERO_P};
						bins zero_m = {`ZERO_M};
						bins infinite_p = {`INFINITE_P};
						bins infinite_m = {`INFINITE_M};
						bins normal_p = {`NO_FINITE_P};
						bins normal_m = {`NO_FINITE_M};
					}						
		cp_operand_b_sn: coverpoint operand_b_i {
						bins subnormal_p = {`SN_FINITE_P};
						bins subnormal_m = {`SN_FINITE_M};
					}						
		cp_operand_b_other: coverpoint operand_b_i {
						bins zero_p = {`ZERO_P};
						bins zero_m = {`ZERO_M};
						bins infinite_p = {`INFINITE_P};
						bins infinite_m = {`INFINITE_M};
						bins normal_p = {`NO_FINITE_P};
						bins normal_m = {`NO_FINITE_M};
					}						
		cp_operand_c_sn: coverpoint operand_c_i {
						bins subnormal_p = {`SN_FINITE_P};
						bins subnormal_m = {`SN_FINITE_M};
					}						
		cp_operand_c_other: coverpoint operand_c_i {
						bins zero_p = {`ZERO_P};
						bins zero_m = {`ZERO_M};
						bins infinite_p = {`INFINITE_P};
						bins infinite_m = {`INFINITE_M};
						bins normal_p = {`NO_FINITE_P};
						bins normal_m = {`NO_FINITE_M};
					}

		//Cross of 1 operand
		cs_op_fflags_operand_a_1: cross cp_op_1_operand, cp_ff_nx_on, cp_operand_a_sn {
						ignore_bins sn_flog = binsof (cp_op_1_operand) intersect {flog}; // flog(Subnormal)=Inf -> No NX flag
						ignore_bins sn_m_fsqrt = binsof (cp_op_1_operand) intersect {fsqrt} && // fsqrt(-Subnormal)=-0 -> No NX flag
									binsof (cp_operand_a_sn) intersect {`SN_FINITE_M};
						}
		cs_op_fflags_operand_a_2: cross cp_op_1_operand, cp_ff_nx_on, cp_operand_a_other {
						ignore_bins normal_m_flog_fsqrt = binsof (cp_op_1_operand) intersect {fsqrt, flog} && // fsqrt(-Normal)=flog(-Normal)=NaN -> No NX flag
									binsof (cp_operand_a_other) intersect {`NO_FINITE_M};
						ignore_bins zero_inf_flog_fsqrt = binsof (cp_op_1_operand) && // Spmath of Zero/Inf does not raise NX flag
									binsof (cp_operand_a_other) intersect {`ZERO_P, `ZERO_M, `INFINITE_P, `INFINITE_M};
						}
		cs_op_fflags_operand_a_3: cross cp_op_1_operand, cp_ff_nx_off, cp_operand_a_other {
						ignore_bins minus_normal_fexp = binsof (cp_op_1_operand) intersect {fexp} && // When result is exact, NX of RTL&C is mismatched, ignore this case - TinhHo confirmed
									binsof (cp_operand_a_other) intersect {`NO_FINITE_M};
						}
		////////////////////////////////////////////////////////////////

		//Cross of 2 operands
		cs_op_fflags_operand_ab_01: cross cp_op_2_operand, cp_ff_nx_on, cp_operand_a_sn, cp_operand_b_sn {
						ignore_bins sn_div_sn_dz_on = binsof (cp_op_2_operand) intersect {fdiv}; // Subnormal/Subnormal = NaN
						}
		cs_op_fflags_operand_ab_02: cross cp_op_2_operand, cp_ff_nx_on, cp_operand_a_sn, cp_ff_nv_off;
		cs_op_fflags_operand_ab_03: cross cp_op_2_operand, cp_ff_nx_off, cp_operand_a_sn, cp_ff_nv_off;
		cs_op_fflags_operand_ab_04: cross cp_op_2_operand, cp_ff_nx_on, cp_operand_a_sn, cp_ff_dz_off;
		cs_op_fflags_operand_ab_05: cross cp_op_2_operand, cp_ff_nx_off, cp_operand_a_sn, cp_ff_dz_off;
		cs_op_fflags_operand_ab_06: cross cp_op_2_operand, cp_ff_nx_on, cp_operand_a_sn, cp_ff_nv_off, cp_ff_dz_off;
		cs_op_fflags_operand_ab_07: cross cp_op_2_operand, cp_ff_nx_off, cp_operand_a_sn, cp_ff_nv_off, cp_ff_dz_off;
		cs_op_fflags_operand_ab_08: cross cp_op_2_operand, cp_ff_nx_on, cp_operand_b_sn, cp_ff_nv_off;
		cs_op_fflags_operand_ab_09: cross cp_op_2_operand, cp_ff_nx_off, cp_operand_b_sn, cp_ff_nv_off;
		cs_op_fflags_operand_ab_10: cross cp_op_2_operand, cp_ff_nx_on, cp_operand_b_sn, cp_ff_dz_off;
		cs_op_fflags_operand_ab_11: cross cp_op_2_operand, cp_ff_nx_off, cp_operand_b_sn, cp_ff_dz_off;
		cs_op_fflags_operand_ab_12: cross cp_op_2_operand, cp_ff_nx_on, cp_operand_b_sn, cp_ff_nv_off, cp_ff_dz_off;
		cs_op_fflags_operand_ab_13: cross cp_op_2_operand, cp_ff_nx_off, cp_operand_b_sn, cp_ff_nv_off, cp_ff_dz_off;
		cs_op_fflags_operand_ab_14: cross cp_op_2_operand, cp_ff_nx_on, cp_operand_a_other, cp_operand_b_other {
						ignore_bins no_div_inf_zero_fdiv = binsof (cp_op_2_operand) intersect {fdiv} && // Normal/Inf=Zero, Normal/Zero=Inf -> No NX flag
										binsof (cp_operand_a_other) intersect {`NO_FINITE_P, `NO_FINITE_M} &&
										binsof (cp_operand_b_other) intersect {`ZERO_P, `ZERO_M, `INFINITE_P, `INFINITE_M};
						ignore_bins inf_zero_div_fdiv = binsof (cp_op_2_operand) intersect {fdiv} && // 0/B=0/NaN, Inf/B=Inf/NaN -> No NX flag
										binsof (cp_operand_a_other) intersect {`ZERO_P, `ZERO_M, `INFINITE_P, `INFINITE_M};
						ignore_bins no_div_inf_zero_fmul = binsof (cp_op_2_operand) intersect {fmul} && // Normal.0=0, Normal.Inf=Inf -> No NX flag
										binsof (cp_operand_a_other) intersect {`NO_FINITE_P, `NO_FINITE_M} &&
										binsof (cp_operand_b_other) intersect {`ZERO_P, `ZERO_M, `INFINITE_P, `INFINITE_M};
						ignore_bins inf_zero_div_fmul = binsof (cp_op_2_operand) intersect {fmul} && // 0.Normal=0, Inf.Normal=Inf -> No NX flag
										binsof (cp_operand_a_other) intersect {`ZERO_P, `ZERO_M, `INFINITE_P, `INFINITE_M};
						ignore_bins no_div_inf_zero_fadd_fsub = binsof (cp_op_2_operand) intersect {fadd, fsub} && // Normal +- Inf = Inf, A +- 0 = A -> No NX flag
										binsof (cp_operand_a_other) intersect {`NO_FINITE_P, `NO_FINITE_M} &&
										binsof (cp_operand_b_other) intersect {`ZERO_P, `ZERO_M, `INFINITE_P, `INFINITE_M};
						ignore_bins inf_zero_div_fadd_fsub = binsof (cp_op_2_operand) intersect {fadd, fsub} && // Inf +- Normal = Inf, 0 +- B = B -> No NX flag
										binsof (cp_operand_a_other) intersect {`ZERO_P, `ZERO_M, `INFINITE_P, `INFINITE_M};
						}
		cs_op_fflags_operand_ab_15: cross cp_op_2_operand, cp_ff_nx_off, cp_operand_a_other, cp_operand_b_other;
		////////////////////////////////////////////////////////////////

		//Cross of 3 operands
		cs_op_fflags_operand_abc_01: cross cp_op_3_operand, cp_ff_nx_on, cp_operand_a_sn, cp_operand_b_sn, cp_operand_c_sn;
		cs_op_fflags_operand_abc_02: cross cp_op_3_operand, cp_ff_nx_on, cp_operand_a_sn, cp_ff_nv_off;
		cs_op_fflags_operand_abc_03: cross cp_op_3_operand, cp_ff_nx_off, cp_operand_a_sn, cp_ff_nv_off;
		cs_op_fflags_operand_abc_04: cross cp_op_3_operand, cp_ff_nx_on, cp_operand_a_sn, cp_ff_dz_off;
		cs_op_fflags_operand_abc_05: cross cp_op_3_operand, cp_ff_nx_off, cp_operand_a_sn, cp_ff_dz_off;
		cs_op_fflags_operand_abc_06: cross cp_op_3_operand, cp_ff_nx_on, cp_operand_a_sn, cp_ff_nv_off, cp_ff_dz_off;
		cs_op_fflags_operand_abc_07: cross cp_op_3_operand, cp_ff_nx_off, cp_operand_a_sn, cp_ff_nv_off, cp_ff_dz_off;
		cs_op_fflags_operand_abc_08: cross cp_op_3_operand, cp_ff_nx_on, cp_operand_b_sn, cp_ff_nv_off;
		cs_op_fflags_operand_abc_09: cross cp_op_3_operand, cp_ff_nx_off, cp_operand_b_sn, cp_ff_nv_off;
		cs_op_fflags_operand_abc_10: cross cp_op_3_operand, cp_ff_nx_on, cp_operand_b_sn, cp_ff_dz_off;
		cs_op_fflags_operand_abc_11: cross cp_op_3_operand, cp_ff_nx_off, cp_operand_b_sn, cp_ff_dz_off;
		cs_op_fflags_operand_abc_12: cross cp_op_3_operand, cp_ff_nx_on, cp_operand_b_sn, cp_ff_nv_off, cp_ff_dz_off;
		cs_op_fflags_operand_abc_13: cross cp_op_3_operand, cp_ff_nx_off, cp_operand_b_sn, cp_ff_nv_off, cp_ff_dz_off;
		cs_op_fflags_operand_abc_14: cross cp_op_3_operand, cp_ff_nx_on, cp_operand_c_sn, cp_ff_nv_off;
		cs_op_fflags_operand_abc_15: cross cp_op_3_operand, cp_ff_nx_off, cp_operand_c_sn, cp_ff_nv_off;
		cs_op_fflags_operand_abc_16: cross cp_op_3_operand, cp_ff_nx_on, cp_operand_c_sn, cp_ff_dz_off;
		cs_op_fflags_operand_abc_17: cross cp_op_3_operand, cp_ff_nx_off, cp_operand_c_sn, cp_ff_dz_off;
		cs_op_fflags_operand_abc_18: cross cp_op_3_operand, cp_ff_nx_on, cp_operand_c_sn, cp_ff_nv_off, cp_ff_dz_off;
		cs_op_fflags_operand_abc_19: cross cp_op_3_operand, cp_ff_nx_off, cp_operand_c_sn, cp_ff_nv_off, cp_ff_dz_off;
		cs_op_fflags_operand_abc_20: cross cp_op_3_operand, cp_ff_nx_on, cp_operand_a_other, cp_operand_b_other, cp_operand_c_other { // A/B/C=Inf->Re=Inf, A/B=0->Re=C -> No NX flag
						ignore_bins a_no_b_no_c_inf = binsof (cp_op_3_operand) &&
										binsof (cp_operand_a_other) intersect {`NO_FINITE_P, `NO_FINITE_M} &&
										binsof (cp_operand_b_other) intersect {`NO_FINITE_P, `NO_FINITE_M} &&
										binsof (cp_operand_c_other) intersect {`INFINITE_P, `INFINITE_M};
						ignore_bins a_no_b_no_zero = binsof (cp_op_3_operand) &&
										binsof (cp_operand_a_other) intersect {`NO_FINITE_P, `NO_FINITE_M} &&
										binsof (cp_operand_b_other) intersect {`ZERO_P, `ZERO_M, `INFINITE_P, `INFINITE_M};
						ignore_bins a_no_zero = binsof (cp_op_3_operand) &&
										binsof (cp_operand_a_other) intersect {`ZERO_P, `ZERO_M, `INFINITE_P, `INFINITE_M};
					}
		cs_op_fflags_operand_abc_21: cross cp_op_3_operand, cp_ff_nx_off, cp_operand_a_other, cp_operand_b_other, cp_operand_c_other;
		////////////////////////////////////////////////////////////////
	endgroup : cg_Flags_analysis_NX

	covergroup cg_Round_modes_Coverage;
		cp_op: coverpoint op_i {
						bins fadd = {fadd};
						bins fsub = {fsub};
						bins fmul = {fmul};
						bins fmadd = {fmadd};
						bins fmsub = {fmsub};
						bins fmnadd = {fmnadd};
						bins fmnsub = {fmnsub};
						bins fdiv = {fdiv};
						bins fsqrt = {fsqrt};
						bins fexp = {fexp};
						bins flog = {flog};
						
						bins fcvt_w_s  = {fcvt_w_s };
						bins fcvt_wu_s = {fcvt_wu_s};
						bins fcvt_s_w  = {fcvt_s_w };
						bins fcvt_s_wu  = {fcvt_s_wu };
					}

		cp_rm: coverpoint rm_i {
						bins rne = {rne};
						bins rtz = {rtz};
						bins rdn = {rdn};
						bins rup = {rup};
						bins rmm = {rmm};
					}

		cp_fn: coverpoint fn_i {
						bins on = {1'b1};
						bins off ={1'b0};
					}

		cs_op_rm_fn: cross cp_op, cp_rm, cp_fn {
						bins arith_f_wo_fn = (binsof (cp_op) intersect {[fadd:fmnsub]} && 
																  binsof (cp_rm) intersect {rne, rtz, rdn, rup, rmm});
						bins arith_f_w_fn = (binsof (cp_op) intersect {[fadd:fmnsub]} && 
																 binsof (cp_rm) intersect {rtz, rdn, rup})
						        			    ||(binsof (cp_op) intersect {[fadd:fmnsub]} && 
																 binsof (cp_rm) intersect {rne, rmm} &&
																 binsof (cp_fn));

						bins smath_f_wo_fn = (binsof (cp_op) intersect {[fdiv:flog]} && 
																  binsof (cp_rm) intersect {rne, rtz, rdn, rup, rmm});
						bins smath_f_w_fn = (binsof (cp_op) intersect {[fdiv:flog]} && 
																 binsof (cp_rm) intersect {rtz, rdn, rup})
						        			    ||(binsof (cp_op) intersect {[fdiv:flog]} && 
																 binsof (cp_rm) intersect {rne, rmm} &&
																 binsof (cp_fn));

						bins cmpcnv_f = (binsof (cp_op) intersect {fcvt_w_s, fcvt_wu_s} && 
														 binsof (cp_rm) intersect {rne, rtz, rdn, rup, rmm});
					}
	endgroup : cg_Round_modes_Coverage

	//covergroup cg_Result_format_Coverage; //hoang.pham
	//	cp_op: coverpoint op_i {
	//					bins fadd = {fadd};
	//					bins fsub = {fsub};
	//					bins fmul = {fmul};
	//					bins fmadd = {fmadd};
	//					bins fmsub = {fmsub};
	//					bins fmnadd = {fmnadd};
	//					bins fmnsub = {fmnsub};
	//					bins fdiv = {fdiv};
	//					bins fsqrt = {fsqrt};
	//					bins fexp = {fexp};
	//					bins flog = {flog};
	//					
	//					bins fcvt_w_s  = {fcvt_w_s };
	//					bins fcvt_wu_s = {fcvt_wu_s};
	//					
	//					bins fmin = {fmin};
	//					bins fmax = {fmax};
	//					bins feq = {feq};
	//					bins flt = {flt};
	//					bins fle = {fle};
	//					bins fne = {fne};
	//				}
	//	cp_operand_a: coverpoint operand_a_i {
	//					bins no_finite_p = {`NO_FINITE_P};
	//					bins no_finite_m = {`NO_FINITE_M};
	//					bins zero_p = {`ZERO_P};
	//					bins zero_m = {`ZERO_M};
	//					bins infinite_p = {`INFINITE_P};
	//					bins infinite_m = {`INFINITE_M};
	//					bins qnan = {`QNAN_P, `QNAN_M};
	//					bins snan = {`SNAN_P, `SNAN_M};
	//				}						
	//	cp_operand_b: coverpoint operand_b_i {
	//					bins no_finite_p = {`NO_FINITE_P};
	//					bins no_finite_m = {`NO_FINITE_M};
	//					bins zero_p = {`ZERO_P};
	//					bins zero_m = {`ZERO_M};
	//					bins infinite_p = {`INFINITE_P};
	//					bins infinite_m = {`INFINITE_M};
	//					bins qnan = {`QNAN_P, `QNAN_M};
	//					bins snan = {`SNAN_P, `SNAN_M};
	//				}						
	//	cp_operand_c: coverpoint operand_c_i {
	//					bins no_finite_p = {`NO_FINITE_P};
	//					bins no_finite_m = {`NO_FINITE_M};
	//					bins zero_p = {`ZERO_P};
	//					bins zero_m = {`ZERO_M};
	//					bins infinite_p = {`INFINITE_P};
	//					bins infinite_m = {`INFINITE_M};
	//					bins qnan = {`QNAN_P, `QNAN_M};
	//					bins snan = {`SNAN_P, `SNAN_M};
	//				}						
	//	cp_result_o: coverpoint result_o {
	//					bins no_finite_p = {`NO_FINITE_P};
	//					bins no_finite_m = {`NO_FINITE_M};
	//					bins zero_p = {`ZERO_P};
	//					bins zero_m = {`ZERO_M};
	//					bins infinite_p = {`INFINITE_P};
	//					bins infinite_m = {`INFINITE_M};
	//					bins cnan = {`CNAN};
	//				}
	//	cp_result_o_cmp: coverpoint result_o {
	//					bins zero = {32'h0000_0000};
	//					bins one  = {32'h0000_0001};
	//				}
	//	cs_op_operand: cross cp_op, cp_operand_a, cp_operand_b, cp_operand_c, cp_result_o, cp_result_o_cmp{
	//					bins arith_f_operand_ab  =  (binsof (cp_op) intersect {[fadd:fmul]} && 
	//   										  				 	  	 binsof (cp_result_o) && 
	//   										  				 	  	 binsof (cp_operand_a) && 
	//   										  				 	  	 binsof (cp_operand_b)); 
	//					bins arith_f_operand_abc =  (binsof (cp_op) intersect {[fmadd:fmnsub]} && 
	//   										  				 	  	 binsof (cp_result_o) && 
	//   										  						   binsof (cp_operand_a) && 
	//   										  						   binsof (cp_operand_b) && 
	//   										  						   binsof (cp_operand_c)); 

	//					bins smath_f_operand_ab  =  (binsof (cp_op) intersect {fdiv} && 
	//   										  				 	  	 binsof (cp_result_o) && 
	//   										  				 	  	 binsof (cp_operand_a) && 
	//   										  				 	  	 binsof (cp_operand_b)); 
	//					bins smath_f_operand_a   =  (binsof (cp_op) intersect {fsqrt, fexp, flog} && 
	//   										  				 	  	 binsof (cp_result_o) && 
	//   										  				 	  	 binsof (cp_operand_a)); 

	//					bins cmpcnv_f_operand_a  =  (binsof (cp_op) intersect {fcvt_w_s, fcvt_wu_s} && 
	//   										  				 	  	 binsof (cp_operand_a)); 
	//					bins cmpcnv_f_operand_ab =  (binsof (cp_op) intersect {[fmin:fne]} && 
	//   										  				 	  	 binsof (cp_result_o_cmp) && 
	//   										  				 	  	 binsof (cp_operand_a) && 
	//   										  				 	  	 binsof (cp_operand_b)); 
	//				}
	//endgroup : cg_Result_format_Coverage

	//Thinh update 191026
	covergroup cg_NaN_propagation_Coverage;
		cp_op_3_operand: coverpoint op_i {
						bins fmadd = {fmadd};
						bins fmsub = {fmsub};
						bins fmnadd = {fmnadd};
						bins fmnsub = {fmnsub};
					}
		cp_op_2_operand: coverpoint op_i {
						bins fadd = {fadd};
						bins fsub = {fsub};
						bins fmul = {fmul};
						bins fdiv = {fdiv};
						
						bins fmin = {fmin};
						bins fmax = {fmax};
					}
		cp_op_1_operand: coverpoint op_i {
						bins fsqrt = {fsqrt};
						bins fexp = {fexp};
						bins flog = {flog};
					}
						
		cp_operand_a_nan: coverpoint operand_a_i {
						bins qnan_p = {`QNAN_P};
						bins qnan_m = {`QNAN_M};
						bins snan_p = {`SNAN_P};
						bins snan_m = {`SNAN_M};
					}

		cp_operand_a_not_nan: coverpoint operand_a_i {
						bins zero_p = {`ZERO_P};
						bins zero_m = {`ZERO_M};
						bins infinite_p = {`INFINITE_P};
						bins infinite_m = {`INFINITE_M};
						bins normal_p = {`NO_FINITE_P};
						bins normal_m = {`NO_FINITE_M};
						bins subnormal_p = {`SN_FINITE_P};
						bins subnormal_m = {`SN_FINITE_M};
					}						

		cp_operand_b_nan: coverpoint operand_b_i {
						bins qnan_p = {`QNAN_P};
						bins qnan_m = {`QNAN_M};
						bins snan_p = {`SNAN_P};
						bins snan_m = {`SNAN_M};
					}						

		cp_operand_b_not_nan: coverpoint operand_b_i {
						bins zero_p = {`ZERO_P};
						bins zero_m = {`ZERO_M};
						bins infinite_p = {`INFINITE_P};
						bins infinite_m = {`INFINITE_M};
						bins normal_p = {`NO_FINITE_P};
						bins normal_m = {`NO_FINITE_M};
						bins subnormal_p = {`SN_FINITE_P};
						bins subnormal_m = {`SN_FINITE_M};
					}						

		cp_operand_c_nan: coverpoint operand_c_i {
						bins qnan_p = {`QNAN_P};
						bins qnan_m = {`QNAN_M};
						bins snan_p = {`SNAN_P};
						bins snan_m = {`SNAN_M};
					}

		cp_operand_c_not_nan: coverpoint operand_c_i {
						bins zero_p = {`ZERO_P};
						bins zero_m = {`ZERO_M};
						bins infinite_p = {`INFINITE_P};
						bins infinite_m = {`INFINITE_M};
						bins normal_p = {`NO_FINITE_P};
						bins normal_m = {`NO_FINITE_M};
						bins subnormal_p = {`SN_FINITE_P};
						bins subnormal_m = {`SN_FINITE_M};
					}						

		cp_result_o: coverpoint result_o {
						bins cnan = {`CNAN};
					}
		cs_op_1_operand: cross cp_op_1_operand, cp_operand_a_nan, cp_result_o;
		cs_op_2_operand_1: cross cp_op_2_operand, cp_operand_a_not_nan, cp_operand_b_nan, cp_result_o {
						ignore_bins fmin_fmax_other_vs_nan = binsof (cp_op_2_operand) intersect {fmin, fmax}; // fmin/fmax(A,NaN)=A. Covered by cg_Result_format_Cmp_Cvt
						}
		cs_op_2_operand_2: cross cp_op_2_operand, cp_operand_a_nan, cp_operand_b_not_nan, cp_result_o {
						ignore_bins fmin_fmax_nan_vs_other = binsof (cp_op_2_operand) intersect {fmin, fmax}; // fmin/fmax(NaN,B)=B. Covered by cg_Result_format_Cmp_Cvt
						}
		cs_op_2_operand_3: cross cp_op_2_operand, cp_operand_a_nan, cp_operand_b_nan, cp_result_o;
		cs_op_3_operand_1: cross cp_op_3_operand, cp_operand_a_not_nan, cp_operand_b_not_nan, cp_operand_c_nan, cp_result_o;
		cs_op_3_operand_2: cross cp_op_3_operand, cp_operand_a_not_nan, cp_operand_b_nan, cp_operand_c_not_nan, cp_result_o;
		cs_op_3_operand_3: cross cp_op_3_operand, cp_operand_a_not_nan, cp_operand_b_nan, cp_operand_c_nan, cp_result_o;
		cs_op_3_operand_4: cross cp_op_3_operand, cp_operand_a_nan, cp_operand_b_not_nan, cp_operand_c_not_nan, cp_result_o;
		cs_op_3_operand_5: cross cp_op_3_operand, cp_operand_a_nan, cp_operand_b_not_nan, cp_operand_c_nan, cp_result_o;
		cs_op_3_operand_6: cross cp_op_3_operand, cp_operand_a_nan, cp_operand_b_nan, cp_operand_c_not_nan, cp_result_o;
		cs_op_3_operand_7: cross cp_op_3_operand, cp_operand_a_nan, cp_operand_b_nan, cp_operand_c_nan, cp_result_o;
	endgroup : cg_NaN_propagation_Coverage

	covergroup cg_NaN_prop_analysis; //hoang.pham
		cp_op_fadd: coverpoint op_i {bins fadd = {fadd};}
		cp_op_fsub: coverpoint op_i {bins fsub = {fsub};}
		cp_op_fmul: coverpoint op_i {bins fmul = {fmul};}
		cp_op_fmadd: coverpoint op_i {bins fmadd = {fmadd};}
		cp_op_fmsub: coverpoint op_i {bins fmsub = {fmsub};}
		cp_op_fmnadd: coverpoint op_i {bins fmnadd = {fmnadd};}
		cp_op_fmnsub: coverpoint op_i {bins fmnsub = {fmnsub};}
		cp_op_fdiv: coverpoint op_i {bins fdiv = {fdiv};}
		cp_op_fsqrt: coverpoint op_i {bins fsqrt = {fsqrt};}
		cp_op_fexp: coverpoint op_i {bins fexp = {fexp};}
		cp_op_flog: coverpoint op_i {bins flog = {flog};}
		cp_op_fmin: coverpoint op_i {bins fmin = {fmin};}
		cp_op_fmax: coverpoint op_i {bins fmax = {fmax};}

		cp_operand_a_infinite_p: coverpoint operand_a_i {bins infinite_p = {`INFINITE_P};}
		cp_operand_a_infinite_m: coverpoint operand_a_i {bins infinite_m = {`INFINITE_M};}
		cp_operand_a_normal_p: coverpoint operand_a_i {bins normal_p = {`NO_FINITE_P};}
		cp_operand_a_normal_m: coverpoint operand_a_i {bins normal_m = {`NO_FINITE_M};}
		cp_operand_a_qnan_p: coverpoint operand_a_i {bins qnan_p = {`QNAN_P};}
		cp_operand_a_qnan_m: coverpoint operand_a_i {bins qnan_m = {`QNAN_M};}
		cp_operand_a_snan_p: coverpoint operand_a_i {bins snan_p = {`SNAN_P};}
		cp_operand_a_snan_m: coverpoint operand_a_i {bins snan_m = {`SNAN_M};}
		cp_operand_a_zero_p: coverpoint operand_a_i {bins zero_p = {`ZERO_P};}
		cp_operand_a_zero_m: coverpoint operand_a_i {bins zero_m = {`ZERO_M};}

		cp_operand_b_infinite_p: coverpoint operand_b_i {bins infinite_p = {`INFINITE_P};}
		cp_operand_b_infinite_m: coverpoint operand_b_i {bins infinite_m = {`INFINITE_M};}
		cp_operand_b_normal_p: coverpoint operand_b_i {bins normal_p = {`NO_FINITE_P};}
		cp_operand_b_normal_m: coverpoint operand_b_i {bins normal_m = {`NO_FINITE_M};}
		cp_operand_b_qnan_p: coverpoint operand_b_i {bins qnan_p = {`QNAN_P};}
		cp_operand_b_qnan_m: coverpoint operand_b_i {bins qnan_m = {`QNAN_M};}
		cp_operand_b_snan_p: coverpoint operand_b_i {bins snan_p = {`SNAN_P};}
		cp_operand_b_snan_m: coverpoint operand_b_i {bins snan_m = {`SNAN_M};}
		cp_operand_b_zero_p: coverpoint operand_b_i {bins zero_p = {`ZERO_P};}
		cp_operand_b_zero_m: coverpoint operand_b_i {bins zero_m = {`ZERO_M};}

		cp_operand_c_infinite_p: coverpoint operand_c_i {bins infinite_p = {`INFINITE_P};}
		cp_operand_c_infinite_m: coverpoint operand_c_i {bins infinite_m = {`INFINITE_M};}
		cp_operand_c_normal_p: coverpoint operand_c_i {bins normal_p = {`NO_FINITE_P};}
		cp_operand_c_normal_m: coverpoint operand_c_i {bins normal_m = {`NO_FINITE_M};}
		cp_operand_c_qnan_p: coverpoint operand_c_i {bins qnan_p = {`QNAN_P};}
		cp_operand_c_qnan_m: coverpoint operand_c_i {bins qnan_m = {`QNAN_M};}
		cp_operand_c_snan_p: coverpoint operand_c_i {bins snan_p = {`SNAN_P};}
		cp_operand_c_snan_m: coverpoint operand_c_i {bins snan_m = {`SNAN_M};}
		cp_operand_c_zero_p: coverpoint operand_c_i {bins zero_p = {`ZERO_P};}
		cp_operand_c_zero_m: coverpoint operand_c_i {bins zero_m = {`ZERO_M};}

		cp_result_o_cnan: coverpoint result_o {bins cnan = {`CNAN};}

		cr_fadd_01: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_infinite_p;
		//cr_fsub_01: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_infinite_p;

		cr_fadd_02: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_infinite_m;
		//cr_fsub_02: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_infinite_m;

		cr_fadd_03_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_p;
		cr_fadd_03_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_m;
		cr_fsub_03_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_p;
		cr_fsub_03_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_m;

		cr_fadd_04_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_p;
		cr_fadd_04_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_m;

		cr_fsub_04_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_p;
		cr_fsub_04_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_m;

		cr_fadd_05_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_b_qnan_p;
		cr_fadd_05_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_b_qnan_m;

		cr_fsub_05_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_b_qnan_p;
		cr_fsub_05_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_b_qnan_m;

		cr_fadd_06_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_b_snan_p;
		cr_fadd_06_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_b_snan_m;

		cr_fsub_06_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_b_snan_p;
		cr_fsub_06_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_b_snan_m;

		cr_fmul_01_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p;
		cr_fmul_01_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p;

		cr_fmul_02_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m;
		cr_fmul_02_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m;

		cr_fmul_03_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p;
		cr_fmul_03_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m;

		cr_fmul_04_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p;
		cr_fmul_04_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m;

		cr_fmul_05_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_p;
		cr_fmul_05_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_m;

		cr_fmul_06_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_p;
		cr_fmul_06_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_m;

		cr_fmul_07_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_b_qnan_p;
		cr_fmul_07_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_b_qnan_m;

		cr_fmul_08_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_b_snan_p;
		cr_fmul_08_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_b_snan_m;


		cr_fmadd_01_1: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_normal_p;
		cr_fmadd_01_2: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_normal_m;
		cr_fmadd_01_3: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_normal_p;
		cr_fmadd_01_4: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_normal_m;
		cr_fmadd_01_5: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_normal_p;
		cr_fmadd_01_6: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_normal_m;
		cr_fmadd_01_7: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_normal_p;
		cr_fmadd_01_8: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_normal_m;
		cr_fmsub_01_1: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_normal_p;
		cr_fmsub_01_2: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_normal_m;
		cr_fmsub_01_3: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_normal_p;
		cr_fmsub_01_4: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_normal_m;
		cr_fmsub_01_5: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_normal_p;
		cr_fmsub_01_6: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_normal_m;
		cr_fmsub_01_7: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_normal_p;
		cr_fmsub_01_8: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_normal_m;
		cr_fmnadd_01_1: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_normal_p;
		cr_fmnadd_01_2: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_normal_m;
		cr_fmnadd_01_3: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_normal_p;
		cr_fmnadd_01_4: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_normal_m;
		cr_fmnadd_01_5: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_normal_p;
		cr_fmnadd_01_6: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_normal_m;
		cr_fmnadd_01_7: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_normal_p;
		cr_fmnadd_01_8: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_normal_m;
		cr_fmnsub_01_1: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_normal_p;
		cr_fmnsub_01_2: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_normal_m;
		cr_fmnsub_01_3: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_normal_p;
		cr_fmnsub_01_4: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_normal_m;
		cr_fmnsub_01_5: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_normal_p;
		cr_fmnsub_01_6: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_normal_m;
		cr_fmnsub_01_7: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_normal_p;
		cr_fmnsub_01_8: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_normal_m;

		cr_fmadd_02_1: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_zero_p;
		cr_fmadd_02_2: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_zero_m;
		cr_fmadd_02_3: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_zero_p;
		cr_fmadd_02_4: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_zero_m;
		cr_fmadd_02_5: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_zero_p;
		cr_fmadd_02_6: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_zero_m;
		cr_fmadd_02_7: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_zero_p;
		cr_fmadd_02_8: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_zero_m;
		cr_fmsub_02_1: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_zero_p;
		cr_fmsub_02_2: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_zero_m;
		cr_fmsub_02_3: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_zero_p;
		cr_fmsub_02_4: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_zero_m;
		cr_fmsub_02_5: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_zero_p;
		cr_fmsub_02_6: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_zero_m;
		cr_fmsub_02_7: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_zero_p;
		cr_fmsub_02_8: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_zero_m;
		cr_fmnadd_02_1: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_zero_p;
		cr_fmnadd_02_2: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_zero_m;
		cr_fmnadd_02_3: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_zero_p;
		cr_fmnadd_02_4: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_zero_m;
		cr_fmnadd_02_5: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_zero_p;
		cr_fmnadd_02_6: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_zero_m;
		cr_fmnadd_02_7: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_zero_p;
		cr_fmnadd_02_8: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_zero_m;
		cr_fmnsub_02_1: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_zero_p;
		cr_fmnsub_02_2: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_zero_m;
		cr_fmnsub_02_3: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_zero_p;
		cr_fmnsub_02_4: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_zero_m;
		cr_fmnsub_02_5: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_zero_p;
		cr_fmnsub_02_6: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_zero_m;
		cr_fmnsub_02_7: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_zero_p;
		cr_fmnsub_02_8: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_zero_m;

		cr_fmadd_03_1:  cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_infinite_p;
		cr_fmadd_03_2:  cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_infinite_m;
		cr_fmadd_03_3:  cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_infinite_p;
		cr_fmadd_03_4:  cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_infinite_m;
		cr_fmadd_03_5:  cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_infinite_p;
		cr_fmadd_03_6:  cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_infinite_m;
		cr_fmadd_03_7:  cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_infinite_p;
		cr_fmadd_03_8:  cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_infinite_m;
		cr_fmsub_03_1:  cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_infinite_p;
		cr_fmsub_03_2:  cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_infinite_m;
		cr_fmsub_03_3:  cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_infinite_p;
		cr_fmsub_03_4:  cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_infinite_m;
		cr_fmsub_03_5:  cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_infinite_p;
		cr_fmsub_03_6:  cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_infinite_m;
		cr_fmsub_03_7:  cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_infinite_p;
		cr_fmsub_03_8:  cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_infinite_m;
		cr_fmnadd_03_1:  cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_infinite_p;
		cr_fmnadd_03_2:  cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_infinite_m;
		cr_fmnadd_03_3:  cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_infinite_p;
		cr_fmnadd_03_4:  cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_infinite_m;
		cr_fmnadd_03_5:  cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_infinite_p;
		cr_fmnadd_03_6:  cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_infinite_m;
		cr_fmnadd_03_7:  cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_infinite_p;
		cr_fmnadd_03_8:  cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_infinite_m;
		cr_fmnsub_03_1:  cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_infinite_p;
		cr_fmnsub_03_2:  cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_operand_c_infinite_m;
		cr_fmnsub_03_3:  cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_infinite_p;
		cr_fmnsub_03_4:  cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_operand_c_infinite_m;
		cr_fmnsub_03_5:  cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_infinite_p;
		cr_fmnsub_03_6:  cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_operand_c_infinite_m;
		cr_fmnsub_03_7:  cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_infinite_p;
		cr_fmnsub_03_8:  cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_operand_c_infinite_m;

		cr_fmadd_04_1: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_normal_p;
		cr_fmadd_04_2: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_normal_m;
		cr_fmadd_04_3: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_normal_p;
		cr_fmadd_04_4: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_normal_m;
		cr_fmsub_04_1: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_normal_p;
		cr_fmsub_04_2: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_normal_m;
		cr_fmsub_04_3: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_normal_p;
		cr_fmsub_04_4: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_normal_m;
		cr_fmnadd_04_1: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_normal_p;
		cr_fmnadd_04_2: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_normal_m;
		cr_fmnadd_04_3: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_normal_p;
		cr_fmnadd_04_4: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_normal_m;
		cr_fmnsub_04_1: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_normal_p;
		cr_fmnsub_04_2: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_normal_m;
		cr_fmnsub_04_3: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_normal_p;
		cr_fmnsub_04_4: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_normal_m;

		cr_fmadd_05_1: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_zero_p;
		cr_fmadd_05_2: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_zero_m;
		cr_fmadd_05_3: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_zero_p;
		cr_fmadd_05_4: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_zero_m;
		cr_fmsub_05_1: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_zero_p;
		cr_fmsub_05_2: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_zero_m;
		cr_fmsub_05_3: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_zero_p;
		cr_fmsub_05_4: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_zero_m;
		cr_fmnadd_05_1: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_zero_p;
		cr_fmnadd_05_2: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_zero_m;
		cr_fmnadd_05_3: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_zero_p;
		cr_fmnadd_05_4: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_zero_m;
		cr_fmnsub_05_1: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_zero_p;
		cr_fmnsub_05_2: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_zero_m;
		cr_fmnsub_05_3: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_zero_p;
		cr_fmnsub_05_4: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_zero_m;

		cr_fmadd_06_1: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_infinite_p;
		cr_fmadd_06_2: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_infinite_m;
		cr_fmadd_06_3: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_infinite_p;
		cr_fmadd_06_4: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_infinite_m;
		cr_fmsub_06_1: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_infinite_p;
		cr_fmsub_06_2: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_infinite_m;
		cr_fmsub_06_3: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_infinite_p;
		cr_fmsub_06_4: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_infinite_m;
		cr_fmnadd_06_1: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_infinite_p;
		cr_fmnadd_06_2: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_infinite_m;
		cr_fmnadd_06_3: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_infinite_p;
		cr_fmnadd_06_4: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_infinite_m;
		cr_fmnsub_06_1: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_infinite_p;
		cr_fmnsub_06_2: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_operand_c_infinite_m;
		cr_fmnsub_06_3: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_infinite_p;
		cr_fmnsub_06_4: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_operand_c_infinite_m;

		cr_fmadd_07: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_infinite_p;
		//cr_fmsub_07: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_infinite_p;
		cr_fmnadd_07: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_infinite_p;
		//cr_fmnsub_07: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_infinite_p;

		cr_fmadd_08: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_infinite_p;
		//cr_fmsub_08: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_infinite_p;
		cr_fmnadd_08: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_infinite_p;
		//cr_fmnsub_08: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_infinite_p;

		cr_fmadd_09: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_infinite_m;
		//cr_fmsub_09: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_infinite_m;
		cr_fmnadd_09: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_infinite_m;
		//cr_fmnsub_09: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_infinite_m;

		cr_fmadd_10: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_infinite_m;
		//cr_fmsub_10: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_infinite_m;
		cr_fmnadd_10: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_infinite_m;
		//cr_fmnsub_10: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_infinite_m;

		cr_fmadd_11_1: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_normal_p;
		cr_fmadd_11_2: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_normal_m;
		cr_fmadd_11_3: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_normal_p;
		cr_fmadd_11_4: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_normal_m;
		cr_fmsub_11_1: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_normal_p;
		cr_fmsub_11_2: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_normal_m;
		cr_fmsub_11_3: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_normal_p;
		cr_fmsub_11_4: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_normal_m;
		cr_fmnadd_11_1: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_normal_p;
		cr_fmnadd_11_2: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_normal_m;
		cr_fmnadd_11_3: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_normal_p;
		cr_fmnadd_11_4: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_normal_m;
		cr_fmnsub_11_1: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_normal_p;
		cr_fmnsub_11_2: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_normal_m;
		cr_fmnsub_11_3: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_normal_p;
		cr_fmnsub_11_4: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_normal_m;

		cr_fmadd_12_1: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_zero_p;
		cr_fmadd_12_2: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_zero_m;
		cr_fmadd_12_3: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_zero_p;
		cr_fmadd_12_4: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_zero_m;
		cr_fmsub_12_1: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_zero_p;
		cr_fmsub_12_2: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_zero_m;
		cr_fmsub_12_3: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_zero_p;
		cr_fmsub_12_4: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_zero_m;
		cr_fmnadd_12_1: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_zero_p;
		cr_fmnadd_12_2: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_zero_m;
		cr_fmnadd_12_3: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_zero_p;
		cr_fmnadd_12_4: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_zero_m;
		cr_fmnsub_12_1: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_zero_p;
		cr_fmnsub_12_2: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_zero_m;
		cr_fmnsub_12_3: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_zero_p;
		cr_fmnsub_12_4: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_zero_m;

		cr_fmadd_13: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_infinite_p;
		//cr_fmsub_13: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_infinite_p;
		cr_fmnadd_13: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_infinite_p;
		cr_fmnsub_13: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_infinite_p;

		cr_fmadd_14_1: cross cp_op_fmadd,  cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_infinite_p;
		cr_fmadd_14_2: cross cp_op_fmadd,  cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_infinite_p;
		cr_fmsub_14_1: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_infinite_p;
		cr_fmsub_14_2: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_infinite_p;
		cr_fmnadd_14_1: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_infinite_p;
		cr_fmnadd_14_2: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_infinite_p;
		cr_fmnsub_14_1: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_infinite_p;
		cr_fmnsub_14_2: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_infinite_p;

		cr_fmadd_15: cross cp_op_fmadd,  cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_infinite_p;
		//cr_fmsub_15: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_infinite_p;
		cr_fmnadd_15: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_infinite_p;
		//cr_fmnsub_15: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_infinite_p;

		cr_fmadd_16: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_infinite_m;
		//cr_fmsub_16: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_infinite_m;
		cr_fmnadd_16: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_infinite_m;
		//cr_fmnsub_16: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_infinite_m;

		cr_fmadd_17_1: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_infinite_m;
		cr_fmadd_17_2: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_infinite_m;
		cr_fmsub_17_1: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_infinite_m;
		cr_fmsub_17_2: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_infinite_m;
		cr_fmnadd_17_1: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_infinite_m;
		cr_fmnadd_17_2: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_infinite_m;
		cr_fmnsub_17_1: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_operand_c_infinite_m;
		cr_fmnsub_17_2: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_operand_c_infinite_m;

		cr_fmadd_18: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_infinite_m;
		//cr_fmsub_18: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_infinite_m;
		cr_fmnadd_18: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_infinite_m;
		//cr_fmnsub_18: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_infinite_m;

		cr_fmadd_19: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_infinite_p;
		//cr_fmsub_19: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_infinite_p;
		cr_fmnadd_19: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_infinite_p;
		//cr_fmnsub_19: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_infinite_p;

		cr_fmadd_20: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_infinite_m;
		//cr_fmsub_20: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_infinite_m;
		cr_fmnadd_20: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_infinite_m;
		//cr_fmnsub_20: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_infinite_m;

		cr_fmadd_21: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_infinite_p;
		//cr_fmsub_21: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_infinite_p;
		cr_fmnadd_21: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_infinite_p;
		//cr_fmnsub_21: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_infinite_p;

		cr_fmadd_22: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_infinite_m;
		//cr_fmsub_22: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_infinite_m;
		cr_fmnadd_22: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_infinite_m;
		//cr_fmnsub_22: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_infinite_m;

		cr_fmadd_23_1: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_qnan_p;
		cr_fmadd_23_2: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_qnan_m;
		cr_fmsub_23_1: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_qnan_p;
		cr_fmsub_23_2: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_qnan_m;
		cr_fmnadd_23_1: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_qnan_p;
		cr_fmnadd_23_2: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_qnan_m;
		cr_fmnsub_23_1: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_qnan_p;
		cr_fmnsub_23_2: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_qnan_m;

		cr_fmadd_24_1: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_snan_p;
		cr_fmadd_24_2: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_a_snan_m;
		cr_fmsub_24_1: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_snan_p;
		cr_fmsub_24_2: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_a_snan_m;
		cr_fmnadd_24_1: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_snan_p;
		cr_fmnadd_24_2: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_a_snan_m;
		cr_fmnsub_24_1: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_snan_p;
		cr_fmnsub_24_2: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_a_snan_m;

		cr_fmadd_25_1: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_b_qnan_p;
		cr_fmadd_25_2: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_b_qnan_m;
		cr_fmsub_25_1: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_b_qnan_p;
		cr_fmsub_25_2: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_b_qnan_m;
		cr_fmnadd_25_1: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_b_qnan_p;
		cr_fmnadd_25_2: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_b_qnan_m;
		cr_fmnsub_25_1: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_b_qnan_p;
		cr_fmnsub_25_2: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_b_qnan_m;

		cr_fmadd_26_1: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_b_snan_p;
		cr_fmadd_26_2: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_b_snan_m;
		cr_fmsub_26_1: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_b_snan_p;
		cr_fmsub_26_2: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_b_snan_m;
		cr_fmnadd_26_1: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_b_snan_p;
		cr_fmnadd_26_2: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_b_snan_m;
		cr_fmnsub_26_1: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_b_snan_p;
		cr_fmnsub_26_2: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_b_snan_m;

		cr_fmadd_27_1: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_c_qnan_p;
		cr_fmadd_27_2: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_c_qnan_m;
		cr_fmsub_27_1: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_c_qnan_p;
		cr_fmsub_27_2: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_c_qnan_m;
		cr_fmnadd_27_1: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_c_qnan_p;
		cr_fmnadd_27_2: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_c_qnan_m;
		cr_fmnsub_27_1: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_c_qnan_p;
		cr_fmnsub_27_2: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_c_qnan_m;

		cr_fmadd_28_1: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_c_snan_p;
		cr_fmadd_28_2: cross cp_op_fmadd, cp_result_o_cnan, cp_operand_c_snan_m;
		cr_fmsub_28_1: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_c_snan_p;
		cr_fmsub_28_2: cross cp_op_fmsub, cp_result_o_cnan, cp_operand_c_snan_m;
		cr_fmnadd_28_1: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_c_snan_p;
		cr_fmnadd_28_2: cross cp_op_fmnadd, cp_result_o_cnan, cp_operand_c_snan_m;
		cr_fmnsub_28_1: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_c_snan_p;
		cr_fmnsub_28_2: cross cp_op_fmnsub, cp_result_o_cnan, cp_operand_c_snan_m;

		cr_fdiv_01_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_zero_p;
		cr_fdiv_01_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_zero_m;
		cr_fdiv_01_3: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_zero_p;
		cr_fdiv_01_4: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_zero_m;

		cr_fdiv_02_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_infinite_p;
		cr_fdiv_02_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_infinite_m;
		cr_fdiv_02_3: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_infinite_p;
		cr_fdiv_02_4: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_infinite_m;

		cr_fdiv_03_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_p;
		cr_fdiv_03_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_m;

		cr_fdiv_04_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_p;
		cr_fdiv_04_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_m;

		cr_fdiv_05_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_b_qnan_p;
		cr_fdiv_05_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_b_qnan_m;

		cr_fdiv_06_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_b_snan_p;
		cr_fdiv_06_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_b_snan_m;

		cr_fsqrt_01: cross cp_op_fsqrt, cp_result_o_cnan, cp_operand_a_normal_m;

		cr_fsqrt_02: cross cp_op_fsqrt, cp_result_o_cnan, cp_operand_a_infinite_m;

		cr_fsqrt_03_1: cross cp_op_fsqrt, cp_result_o_cnan, cp_operand_a_qnan_p;
		cr_fsqrt_03_2: cross cp_op_fsqrt, cp_result_o_cnan, cp_operand_a_qnan_m;

		cr_fsqrt_04_1: cross cp_op_fsqrt, cp_result_o_cnan, cp_operand_a_snan_p;
		cr_fsqrt_04_2: cross cp_op_fsqrt, cp_result_o_cnan, cp_operand_a_snan_m;

		cr_fexp_01_1: cross cp_op_fexp, cp_result_o_cnan, cp_operand_a_qnan_p;
		cr_fexp_01_2: cross cp_op_fexp, cp_result_o_cnan, cp_operand_a_qnan_m;

		cr_fexp_02_1: cross cp_op_fexp, cp_result_o_cnan, cp_operand_a_snan_p;
		cr_fexp_02_2: cross cp_op_fexp, cp_result_o_cnan, cp_operand_a_snan_m;

		cr_flog_01: cross cp_op_flog, cp_result_o_cnan, cp_operand_a_normal_m;

		cr_flog_02: cross cp_op_flog, cp_result_o_cnan, cp_operand_a_infinite_m;

		cr_flog_03_1: cross cp_op_flog, cp_result_o_cnan, cp_operand_a_qnan_p;
		cr_flog_03_2: cross cp_op_flog, cp_result_o_cnan, cp_operand_a_qnan_m;

		cr_flog_04_1: cross cp_op_flog, cp_result_o_cnan, cp_operand_a_snan_p;
		cr_flog_04_2: cross cp_op_flog, cp_result_o_cnan, cp_operand_a_snan_m;

		cr_fmax_01_1: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_qnan_p;
		cr_fmax_01_2: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_qnan_m;
		cr_fmax_01_3: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_qnan_p;
		cr_fmax_01_4: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_qnan_m;
		cr_fmin_01_1: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_qnan_p;
		cr_fmin_01_2: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_qnan_m;
		cr_fmin_01_3: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_qnan_p;
		cr_fmin_01_4: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_qnan_m;

		cr_fmax_02_1: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_snan_p;
		cr_fmax_02_2: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_snan_m;
		cr_fmin_02_1: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_snan_p;
		cr_fmin_02_2: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_snan_m;

		cr_fmax_03_1: cross cp_op_fmax, cp_result_o_cnan, cp_operand_b_snan_p;
		cr_fmax_03_2: cross cp_op_fmax, cp_result_o_cnan, cp_operand_b_snan_m;
		cr_fmin_03_1: cross cp_op_fmin, cp_result_o_cnan, cp_operand_b_snan_p;
		cr_fmin_03_2: cross cp_op_fmin, cp_result_o_cnan, cp_operand_b_snan_m;
	endgroup : cg_NaN_prop_analysis

	covergroup cg_Result_format_Arith; //hoang.pham
		cp_op_fadd: coverpoint op_i {bins fadd = {fadd};}
		cp_op_fsub: coverpoint op_i {bins fsub = {fsub};}
		cp_op_fmul: coverpoint op_i {bins fmul = {fmul};}
		cp_op_fmadd: coverpoint op_i {bins fmadd = {fmadd};}
		cp_op_fmsub: coverpoint op_i {bins fmsub = {fmsub};}
		cp_op_fmnadd: coverpoint op_i {bins fmnadd = {fmnadd};}
		cp_op_fmnsub: coverpoint op_i {bins fmnsub = {fmnsub};}

		cp_operand_a_infinite_p: coverpoint operand_a_i {bins infinite_p = {`INFINITE_P};}
		cp_operand_a_infinite_m: coverpoint operand_a_i {bins infinite_m = {`INFINITE_M};}
		cp_operand_a_normal_p: coverpoint operand_a_i {bins normal_p = {`NO_FINITE_P};}
		cp_operand_a_normal_m: coverpoint operand_a_i {bins normal_m = {`NO_FINITE_M};}
		cp_operand_a_qnan_p: coverpoint operand_a_i {bins qnan_p = {`QNAN_P};}
		cp_operand_a_qnan_m: coverpoint operand_a_i {bins qnan_m = {`QNAN_M};}
		cp_operand_a_snan_p: coverpoint operand_a_i {bins snan_p = {`SNAN_P};}
		cp_operand_a_snan_m: coverpoint operand_a_i {bins snan_m = {`SNAN_M};}
		cp_operand_a_zero_p: coverpoint operand_a_i {bins zero_p = {`ZERO_P};}
		cp_operand_a_zero_m: coverpoint operand_a_i {bins zero_m = {`ZERO_M};}

		cp_operand_b_infinite_p: coverpoint operand_b_i {bins infinite_p = {`INFINITE_P};}
		cp_operand_b_infinite_m: coverpoint operand_b_i {bins infinite_m = {`INFINITE_M};}
		cp_operand_b_normal_p: coverpoint operand_b_i {bins normal_p = {`NO_FINITE_P};}
		cp_operand_b_normal_m: coverpoint operand_b_i {bins normal_m = {`NO_FINITE_M};}
		cp_operand_b_qnan_p: coverpoint operand_b_i {bins qnan_p = {`QNAN_P};}
		cp_operand_b_qnan_m: coverpoint operand_b_i {bins qnan_m = {`QNAN_M};}
		cp_operand_b_snan_p: coverpoint operand_b_i {bins snan_p = {`SNAN_P};}
		cp_operand_b_snan_m: coverpoint operand_b_i {bins snan_m = {`SNAN_M};}
		cp_operand_b_zero_p: coverpoint operand_b_i {bins zero_p = {`ZERO_P};}
		cp_operand_b_zero_m: coverpoint operand_b_i {bins zero_m = {`ZERO_M};}

		cp_operand_c_infinite_p: coverpoint operand_c_i {bins infinite_p = {`INFINITE_P};}
		cp_operand_c_infinite_m: coverpoint operand_c_i {bins infinite_m = {`INFINITE_M};}
		cp_operand_c_normal_p: coverpoint operand_c_i {bins normal_p = {`NO_FINITE_P};}
		cp_operand_c_normal_m: coverpoint operand_c_i {bins normal_m = {`NO_FINITE_M};}
		cp_operand_c_qnan_p: coverpoint operand_c_i {bins qnan_p = {`QNAN_P};}
		cp_operand_c_qnan_m: coverpoint operand_c_i {bins qnan_m = {`QNAN_M};}
		cp_operand_c_snan_p: coverpoint operand_c_i {bins snan_p = {`SNAN_P};}
		cp_operand_c_snan_m: coverpoint operand_c_i {bins snan_m = {`SNAN_M};}
		cp_operand_c_zero_p: coverpoint operand_c_i {bins zero_p = {`ZERO_P};}
		cp_operand_c_zero_m: coverpoint operand_c_i {bins zero_m = {`ZERO_M};}

		cp_result_o_cnan: coverpoint result_o {bins cnan = {`CNAN};}
		cp_result_o_infinite_p: coverpoint result_o {bins infinite_p = {`INFINITE_P};}
		cp_result_o_infinite_m: coverpoint result_o {bins infinite_m = {`INFINITE_M};}
		cp_result_o_normal_p: coverpoint result_o {bins normal_p = {`NO_FINITE_P};}
		cp_result_o_normal_m: coverpoint result_o {bins normal_m = {`NO_FINITE_M};}
		cp_result_o_zero_p: coverpoint result_o {bins zero_p = {`ZERO_P};}
		cp_result_o_zero_m: coverpoint result_o {bins zero_m = {`ZERO_M};}

		cr_fadd_01: cross cp_op_fadd, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_normal_p; 
		cr_fadd_02: cross cp_op_fadd, cp_result_o_infinite_p, cp_operand_a_normal_p, cp_operand_b_normal_p; 
		cr_fadd_03: cross cp_op_fadd, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_normal_m; 
		cr_fadd_04: cross cp_op_fadd, cp_result_o_normal_m, cp_operand_a_normal_p, cp_operand_b_normal_m; 
		cr_fadd_05: cross cp_op_fadd, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_normal_m; 
		cr_fadd_06: cross cp_op_fadd, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_zero_p; 
		cr_fadd_07: cross cp_op_fadd, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_zero_m; 
		cr_fadd_08: cross cp_op_fadd, cp_result_o_infinite_p, cp_operand_a_normal_p, cp_operand_b_infinite_p; 
		cr_fadd_09: cross cp_op_fadd, cp_result_o_infinite_m, cp_operand_a_normal_p, cp_operand_b_infinite_m; 
		cr_fadd_10_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_qnan_p;
		cr_fadd_10_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_qnan_m; 
		cr_fadd_11_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_snan_p; 
		cr_fadd_11_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_snan_m; 
		cr_fadd_12: cross cp_op_fadd, cp_result_o_normal_p, cp_operand_a_normal_m, cp_operand_b_normal_p; 
		cr_fadd_13: cross cp_op_fadd, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_normal_p; 
		cr_fadd_14: cross cp_op_fadd, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_normal_p; 
		cr_fadd_15: cross cp_op_fadd, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_normal_m; 
		cr_fadd_17: cross cp_op_fadd, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_zero_p; 
		cr_fadd_18: cross cp_op_fadd, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_zero_m; 
		cr_fadd_19: cross cp_op_fadd, cp_result_o_infinite_p, cp_operand_a_normal_m, cp_operand_b_infinite_p; 
		cr_fadd_20: cross cp_op_fadd, cp_result_o_infinite_m, cp_operand_a_normal_m, cp_operand_b_infinite_m; 
		cr_fadd_21_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_qnan_p; 
		cr_fadd_21_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_qnan_m; 
		cr_fadd_22_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_snan_p; 
		cr_fadd_22_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_snan_m; 
		cr_fadd_23: cross cp_op_fadd, cp_result_o_normal_p, cp_operand_a_zero_p, cp_operand_b_normal_p; 
		cr_fadd_24: cross cp_op_fadd, cp_result_o_normal_m, cp_operand_a_zero_p, cp_operand_b_normal_m; 
		cr_fadd_25: cross cp_op_fadd, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_zero_p; 
		cr_fadd_26: cross cp_op_fadd, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_zero_m; 
		cr_fadd_27: cross cp_op_fadd, cp_result_o_infinite_p, cp_operand_a_zero_p, cp_operand_b_infinite_p; 
		cr_fadd_28: cross cp_op_fadd, cp_result_o_infinite_m, cp_operand_a_zero_p, cp_operand_b_infinite_m; 
		cr_fadd_29_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_qnan_p; 
		cr_fadd_29_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_qnan_m; 
		cr_fadd_30_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_snan_p; 
		cr_fadd_30_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_snan_m; 
		cr_fadd_31: cross cp_op_fadd, cp_result_o_normal_p, cp_operand_a_zero_m, cp_operand_b_normal_p; 
		cr_fadd_32: cross cp_op_fadd, cp_result_o_normal_m, cp_operand_a_zero_m, cp_operand_b_normal_m; 
		cr_fadd_33: cross cp_op_fadd, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_zero_p; 
		cr_fadd_35: cross cp_op_fadd, cp_result_o_infinite_p, cp_operand_a_zero_m, cp_operand_b_infinite_p; 
		cr_fadd_36: cross cp_op_fadd, cp_result_o_infinite_m, cp_operand_a_zero_m, cp_operand_b_infinite_m; 
		cr_fadd_37_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_qnan_p; 
		cr_fadd_37_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_qnan_m; 
		cr_fadd_38_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_snan_p; 
		cr_fadd_38_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_snan_m; 
		cr_fadd_39: cross cp_op_fadd, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_normal_p; 
		cr_fadd_40: cross cp_op_fadd, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_normal_m; 
		cr_fadd_41: cross cp_op_fadd, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_zero_p; 
		cr_fadd_42: cross cp_op_fadd, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_zero_m; 
		cr_fadd_43: cross cp_op_fadd, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_infinite_p; 
		cr_fadd_44: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_infinite_m; 
		cr_fadd_45_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_qnan_p; 
		cr_fadd_45_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_qnan_m; 
		cr_fadd_46_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_snan_p; 
		cr_fadd_46_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_snan_m; 
		cr_fadd_47: cross cp_op_fadd, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_normal_p; 
		cr_fadd_48: cross cp_op_fadd, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_normal_m; 
		cr_fadd_49: cross cp_op_fadd, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_zero_p; 
		cr_fadd_50: cross cp_op_fadd, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_zero_m; 
		cr_fadd_51: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_infinite_p; 
		cr_fadd_52: cross cp_op_fadd, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_infinite_m; 
		cr_fadd_53_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_qnan_p; 
		cr_fadd_53_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_qnan_m; 
		cr_fadd_54_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_snan_p; 
		cr_fadd_54_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_snan_m; 
		cr_fadd_55_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_normal_p; 
		cr_fadd_55_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_normal_p; 
		cr_fadd_56_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_normal_m; 
		cr_fadd_56_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_normal_m; 
		cr_fadd_57_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_zero_p; 
		cr_fadd_57_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_zero_p; 
		cr_fadd_58_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_zero_m; 
		cr_fadd_58_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_zero_m; 
		cr_fadd_59_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_infinite_p; 
		cr_fadd_59_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_infinite_p; 
		cr_fadd_60_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_infinite_m; 
		cr_fadd_60_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_infinite_m; 
		cr_fadd_61_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_qnan_p; 
		cr_fadd_61_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_qnan_p; 
		cr_fadd_61_3: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_qnan_m; 
		cr_fadd_61_4: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_qnan_m; 
		cr_fadd_62_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_snan_p; 
		cr_fadd_62_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_snan_p; 
		cr_fadd_62_3: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_snan_m; 
		cr_fadd_62_4: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_snan_m; 
		cr_fadd_63_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_normal_p; 
		cr_fadd_63_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_normal_p; 
		cr_fadd_64_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_normal_m; 
		cr_fadd_64_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_normal_m; 
		cr_fadd_65_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_zero_p; 
		cr_fadd_65_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_zero_p; 
		cr_fadd_66_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_zero_m; 
		cr_fadd_66_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_zero_m; 
		cr_fadd_67_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_infinite_p; 
		cr_fadd_67_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_infinite_p; 
		cr_fadd_68_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_infinite_m; 
		cr_fadd_68_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_infinite_m; 
		cr_fadd_69_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_qnan_p; 
		cr_fadd_69_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_qnan_p; 
		cr_fadd_69_3: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_qnan_m; 
		cr_fadd_69_4: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_qnan_m; 
		cr_fadd_70_1: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_snan_p; 
		cr_fadd_70_2: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_snan_p; 
		cr_fadd_70_3: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_snan_m; 
		cr_fadd_70_4: cross cp_op_fadd, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_snan_m; 

		cr_fsub_01: cross cp_op_fsub, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_normal_p; 
		cr_fsub_02: cross cp_op_fsub, cp_result_o_normal_m, cp_operand_a_normal_p, cp_operand_b_normal_p; 
		cr_fsub_03: cross cp_op_fsub, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_normal_p; 
		cr_fsub_04: cross cp_op_fsub, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_normal_m; 
		cr_fsub_05: cross cp_op_fsub, cp_result_o_infinite_p, cp_operand_a_normal_p, cp_operand_b_normal_m; 
		cr_fsub_06: cross cp_op_fsub, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_zero_p; 
		cr_fsub_07: cross cp_op_fsub, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_zero_m; 
        cr_fsub_08: cross cp_op_fsub, cp_result_o_infinite_m, cp_operand_a_normal_p, cp_operand_b_infinite_p; 
        cr_fsub_09: cross cp_op_fsub, cp_result_o_infinite_p, cp_operand_a_normal_p, cp_operand_b_infinite_m; 
		cr_fsub_10_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_qnan_p; 
		cr_fsub_10_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_qnan_m; 
		cr_fsub_11_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_snan_p; 
		cr_fsub_11_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_snan_m; 
		cr_fsub_12: cross cp_op_fsub, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_normal_p; 
		cr_fsub_13: cross cp_op_fsub, cp_result_o_infinite_m, cp_operand_a_normal_m, cp_operand_b_normal_p; 
		cr_fsub_14: cross cp_op_fsub, cp_result_o_normal_p, cp_operand_a_normal_m, cp_operand_b_normal_m; 
		cr_fsub_15: cross cp_op_fsub, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_normal_m; 
		cr_fsub_16: cross cp_op_fsub, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_normal_m; 
		cr_fsub_17: cross cp_op_fsub, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_zero_p; 
		cr_fsub_18: cross cp_op_fsub, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_zero_m; 
        cr_fsub_19: cross cp_op_fsub, cp_result_o_infinite_m, cp_operand_a_normal_m, cp_operand_b_infinite_p; 
        cr_fsub_20: cross cp_op_fsub, cp_result_o_infinite_p, cp_operand_a_normal_m, cp_operand_b_infinite_m; 
		cr_fsub_21_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_qnan_p; 
		cr_fsub_21_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_qnan_m; 
		cr_fsub_22_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_snan_p; 
		cr_fsub_22_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_snan_m; 
		cr_fsub_23: cross cp_op_fsub, cp_result_o_normal_m, cp_operand_a_zero_p, cp_operand_b_normal_p; 
		cr_fsub_24: cross cp_op_fsub, cp_result_o_normal_p, cp_operand_a_zero_p, cp_operand_b_normal_m; 
		cr_fsub_25: cross cp_op_fsub, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_zero_p; 
		cr_fsub_26: cross cp_op_fsub, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_zero_m; 
		cr_fsub_29_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_qnan_p; 
		cr_fsub_29_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_qnan_m; 
		cr_fsub_30_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_snan_p; 
		cr_fsub_30_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_snan_m; 
		cr_fsub_31: cross cp_op_fsub, cp_result_o_normal_m, cp_operand_a_zero_m, cp_operand_b_normal_p; 
		cr_fsub_32: cross cp_op_fsub, cp_result_o_normal_p, cp_operand_a_zero_m, cp_operand_b_normal_m; 
		cr_fsub_34: cross cp_op_fsub, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_zero_m; 
		cr_fsub_37_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_qnan_p; 
		cr_fsub_37_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_qnan_m; 
		cr_fsub_38_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_snan_p; 
		cr_fsub_38_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_snan_m; 
		cr_fsub_39: cross cp_op_fsub, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_normal_p; 
		cr_fsub_40: cross cp_op_fsub, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_normal_m; 
		cr_fsub_41: cross cp_op_fsub, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_zero_p; 
		cr_fsub_42: cross cp_op_fsub, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_zero_m; 
		cr_fsub_43: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_infinite_p; 
		cr_fsub_44: cross cp_op_fsub, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_infinite_m; 
		cr_fsub_45_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_qnan_p; 
		cr_fsub_45_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_qnan_m; 
		cr_fsub_46_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_snan_p; 
		cr_fsub_46_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_snan_m; 
		cr_fsub_47: cross cp_op_fsub, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_normal_p; 
		cr_fsub_48: cross cp_op_fsub, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_normal_m; 
		cr_fsub_49: cross cp_op_fsub, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_zero_p; 
		cr_fsub_50: cross cp_op_fsub, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_zero_m; 
		cr_fsub_51: cross cp_op_fsub, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_infinite_p; 
		cr_fsub_52: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_infinite_m; 
		cr_fsub_53_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_qnan_p; 
		cr_fsub_53_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_qnan_m; 
		cr_fsub_54_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_snan_p; 
		cr_fsub_54_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_snan_m; 
		cr_fsub_55_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_normal_p; 
		cr_fsub_55_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_normal_p; 
		cr_fsub_56_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_normal_m; 
		cr_fsub_56_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_normal_m; 
		cr_fsub_57_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_zero_p; 
		cr_fsub_57_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_zero_p; 
		cr_fsub_58_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_zero_m; 
		cr_fsub_58_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_zero_m; 
		cr_fsub_59_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_infinite_p; 
		cr_fsub_59_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_infinite_p; 
		cr_fsub_60_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_infinite_m; 
		cr_fsub_60_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_infinite_m; 
		cr_fsub_61_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_qnan_p; 
		cr_fsub_61_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_qnan_p; 
		cr_fsub_61_3: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_qnan_m; 
		cr_fsub_61_4: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_qnan_m; 
		cr_fsub_62_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_snan_p; 
		cr_fsub_62_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_snan_p; 
		cr_fsub_62_3: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_snan_m; 
		cr_fsub_62_4: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_snan_m; 
		cr_fsub_63_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_normal_p; 
		cr_fsub_63_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_normal_p; 
		cr_fsub_64_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_normal_m; 
		cr_fsub_64_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_normal_m; 
		cr_fsub_65_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_zero_p; 
		cr_fsub_65_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_zero_p; 
		cr_fsub_66_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_zero_m; 
		cr_fsub_66_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_zero_m; 
		cr_fsub_67_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_infinite_p; 
		cr_fsub_67_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_infinite_p; 
		cr_fsub_68_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_infinite_m; 
		cr_fsub_68_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_infinite_m; 
		cr_fsub_69_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_qnan_p; 
		cr_fsub_69_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_qnan_p; 
		cr_fsub_69_3: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_qnan_m; 
		cr_fsub_69_4: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_qnan_m; 
		cr_fsub_70_1: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_snan_p; 
		cr_fsub_70_2: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_snan_p; 
		cr_fsub_70_3: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_snan_m; 
		cr_fsub_70_4: cross cp_op_fsub, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_snan_m; 

		cr_fmul_01: cross cp_op_fmul, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_normal_p; 
		cr_fmul_02: cross cp_op_fmul, cp_result_o_infinite_p, cp_operand_a_normal_p, cp_operand_b_normal_p; 
		cr_fmul_03: cross cp_op_fmul, cp_result_o_normal_m, cp_operand_a_normal_p, cp_operand_b_normal_m; 
		cr_fmul_04: cross cp_op_fmul, cp_result_o_infinite_m, cp_operand_a_normal_p, cp_operand_b_normal_m; 
		cr_fmul_05: cross cp_op_fmul, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_zero_p; 
		cr_fmul_06: cross cp_op_fmul, cp_result_o_zero_m, cp_operand_a_normal_p, cp_operand_b_zero_m; 
		cr_fmul_07: cross cp_op_fmul, cp_result_o_infinite_p, cp_operand_a_normal_p, cp_operand_b_infinite_p; 
		cr_fmul_08: cross cp_op_fmul, cp_result_o_infinite_m, cp_operand_a_normal_p, cp_operand_b_infinite_m; 
		cr_fmul_09_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_qnan_p; 
		cr_fmul_09_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_qnan_m; 
		cr_fmul_10_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_snan_p; 
		cr_fmul_10_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_snan_m; 
		cr_fmul_11: cross cp_op_fmul, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_normal_p; 
		cr_fmul_12: cross cp_op_fmul, cp_result_o_infinite_m, cp_operand_a_normal_m, cp_operand_b_normal_p; 
		cr_fmul_13: cross cp_op_fmul, cp_result_o_normal_p, cp_operand_a_normal_m, cp_operand_b_normal_m; 
		cr_fmul_14: cross cp_op_fmul, cp_result_o_infinite_p, cp_operand_a_normal_m, cp_operand_b_normal_m; 
		cr_fmul_15: cross cp_op_fmul, cp_result_o_zero_m, cp_operand_a_normal_m, cp_operand_b_zero_p; 
		cr_fmul_16: cross cp_op_fmul, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_zero_m; 
		cr_fmul_17: cross cp_op_fmul, cp_result_o_infinite_m, cp_operand_a_normal_m, cp_operand_b_infinite_p; 
		cr_fmul_18: cross cp_op_fmul, cp_result_o_infinite_p, cp_operand_a_normal_m, cp_operand_b_infinite_m; 
		cr_fmul_19_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_qnan_p; 
		cr_fmul_19_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_qnan_m; 
		cr_fmul_20_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_snan_p; 
		cr_fmul_20_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_snan_m; 
		cr_fmul_21: cross cp_op_fmul, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_normal_p; 
		cr_fmul_22: cross cp_op_fmul, cp_result_o_zero_m, cp_operand_a_zero_p, cp_operand_b_normal_m; 
		cr_fmul_23: cross cp_op_fmul, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_zero_p; 
		cr_fmul_24: cross cp_op_fmul, cp_result_o_zero_m, cp_operand_a_zero_p, cp_operand_b_zero_m; 
		cr_fmul_25: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_p; 
		cr_fmul_26: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_infinite_m; 
		cr_fmul_27_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_qnan_p; 
		cr_fmul_27_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_qnan_m; 
		cr_fmul_28_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_snan_p; 
		cr_fmul_28_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_snan_m; 
		cr_fmul_29: cross cp_op_fmul, cp_result_o_zero_m, cp_operand_a_zero_m, cp_operand_b_normal_p; 
		cr_fmul_30: cross cp_op_fmul, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_normal_m; 
		cr_fmul_31: cross cp_op_fmul, cp_result_o_zero_m, cp_operand_a_zero_m, cp_operand_b_zero_p; 
		cr_fmul_32: cross cp_op_fmul, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_zero_m; 
		cr_fmul_33: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_p; 
		cr_fmul_34: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_infinite_m; 
		cr_fmul_35_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_qnan_p; 
		cr_fmul_35_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_qnan_m; 
		cr_fmul_36_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_snan_p; 
		cr_fmul_36_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_snan_m; 
		cr_fmul_37: cross cp_op_fmul, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_normal_p; 
		cr_fmul_38: cross cp_op_fmul, cp_result_o_infinite_m, cp_operand_a_infinite_p, cp_operand_b_normal_m; 
		cr_fmul_39: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_p; 
		cr_fmul_40: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_zero_m; 
		cr_fmul_41: cross cp_op_fmul, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_infinite_p; 
		cr_fmul_42: cross cp_op_fmul, cp_result_o_infinite_m, cp_operand_a_infinite_p, cp_operand_b_infinite_m; 
		cr_fmul_43_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_qnan_p; 
		cr_fmul_43_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_qnan_m; 
		cr_fmul_44_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_snan_p; 
		cr_fmul_44_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_snan_m; 
		cr_fmul_45: cross cp_op_fmul, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_normal_p; 
		cr_fmul_46: cross cp_op_fmul, cp_result_o_infinite_p, cp_operand_a_infinite_m, cp_operand_b_normal_m; 
		cr_fmul_47: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_p; 
		cr_fmul_48: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_zero_m; 
		cr_fmul_49: cross cp_op_fmul, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_infinite_p; 
		cr_fmul_50: cross cp_op_fmul, cp_result_o_infinite_p, cp_operand_a_infinite_m, cp_operand_b_infinite_m; 
		cr_fmul_51_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_qnan_p; 
		cr_fmul_51_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_qnan_m; 
		cr_fmul_52_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_snan_p; 
		cr_fmul_52_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_snan_m; 
		cr_fmul_53_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_normal_p; 
		cr_fmul_53_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_normal_p; 
		cr_fmul_54_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_normal_m; 
		cr_fmul_54_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_normal_m; 
		cr_fmul_55_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_zero_p; 
		cr_fmul_55_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_zero_p; 
		cr_fmul_56_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_zero_m; 
		cr_fmul_56_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_zero_m; 
		cr_fmul_57_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_infinite_p; 
		cr_fmul_57_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_infinite_p; 
		cr_fmul_58_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_infinite_m; 
		cr_fmul_58_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_infinite_m; 
		cr_fmul_59_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_qnan_p; 
		cr_fmul_59_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_qnan_p; 
		cr_fmul_59_3: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_qnan_m; 
		cr_fmul_59_4: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_qnan_m; 
		cr_fmul_60_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_snan_p; 
		cr_fmul_60_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_snan_p; 
		cr_fmul_60_3: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_snan_m; 
		cr_fmul_60_4: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_snan_m; 
		cr_fmul_61_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_normal_p; 
		cr_fmul_61_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_normal_p; 
		cr_fmul_62_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_normal_m; 
		cr_fmul_62_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_normal_m; 
		cr_fmul_63_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_zero_p; 
		cr_fmul_63_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_zero_p; 
		cr_fmul_64_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_zero_m; 
		cr_fmul_64_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_zero_m; 
		cr_fmul_65_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_infinite_p; 
		cr_fmul_65_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_infinite_p; 
		cr_fmul_66_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_infinite_m; 
		cr_fmul_66_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_infinite_m; 
		cr_fmul_67_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_qnan_p; 
		cr_fmul_67_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_qnan_p; 
		cr_fmul_67_3: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_qnan_m; 
		cr_fmul_67_4: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_qnan_m; 
		cr_fmul_68_1: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_snan_p; 
		cr_fmul_68_2: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_snan_p; 
		cr_fmul_68_3: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_snan_m; 
		cr_fmul_68_4: cross cp_op_fmul, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_snan_m; 
	endgroup : cg_Result_format_Arith

	covergroup cg_Result_format_Arith_fmadd_fmnadd_fmsub_fmnsub; //hoang.pham
		cp_op_fmadd: coverpoint op_i{bins fmadd = {fmadd};}
		cp_op_fmsub: coverpoint op_i{bins fmsub = {fmsub};}
		cp_op_fmnadd: coverpoint op_i{bins fmnadd = {fmnadd};}
		cp_op_fmnsub: coverpoint op_i{bins fmnsub = {fmnsub};}

		cp_operand_a_infinite_p: coverpoint operand_a_i {bins infinite_p = {`INFINITE_P};}
		cp_operand_a_infinite_m: coverpoint operand_a_i {bins infinite_m = {`INFINITE_M};}
		cp_operand_a_normal_p: coverpoint operand_a_i {bins normal_p = {`NO_FINITE_P};}
		cp_operand_a_normal_m: coverpoint operand_a_i {bins normal_m = {`NO_FINITE_M};}
		cp_operand_a_qnan_p: coverpoint operand_a_i {bins qnan_p = {`QNAN_P};}
		cp_operand_a_qnan_m: coverpoint operand_a_i {bins qnan_m = {`QNAN_M};}
		cp_operand_a_snan_p: coverpoint operand_a_i {bins snan_p = {`SNAN_P};}
		cp_operand_a_snan_m: coverpoint operand_a_i {bins snan_m = {`SNAN_M};}
		cp_operand_a_zero_p: coverpoint operand_a_i {bins zero_p = {`ZERO_P};}
		cp_operand_a_zero_m: coverpoint operand_a_i {bins zero_m = {`ZERO_M};}

		cp_operand_b_infinite_p: coverpoint operand_b_i {bins infinite_p = {`INFINITE_P};}
		cp_operand_b_infinite_m: coverpoint operand_b_i {bins infinite_m = {`INFINITE_M};}
		cp_operand_b_normal_p: coverpoint operand_b_i {bins normal_p = {`NO_FINITE_P};}
		cp_operand_b_normal_m: coverpoint operand_b_i {bins normal_m = {`NO_FINITE_M};}
		cp_operand_b_qnan_p: coverpoint operand_b_i {bins qnan_p = {`QNAN_P};}
		cp_operand_b_qnan_m: coverpoint operand_b_i {bins qnan_m = {`QNAN_M};}
		cp_operand_b_snan_p: coverpoint operand_b_i {bins snan_p = {`SNAN_P};}
		cp_operand_b_snan_m: coverpoint operand_b_i {bins snan_m = {`SNAN_M};}
		cp_operand_b_zero_p: coverpoint operand_b_i {bins zero_p = {`ZERO_P};}
		cp_operand_b_zero_m: coverpoint operand_b_i {bins zero_m = {`ZERO_M};}

		cp_operand_c_infinite_p: coverpoint operand_c_i {bins infinite_p = {`INFINITE_P};}
		cp_operand_c_infinite_m: coverpoint operand_c_i {bins infinite_m = {`INFINITE_M};}
		cp_operand_c_normal_p: coverpoint operand_c_i {bins normal_p = {`NO_FINITE_P};}
		cp_operand_c_normal_m: coverpoint operand_c_i {bins normal_m = {`NO_FINITE_M};}
		cp_operand_c_qnan_p: coverpoint operand_c_i {bins qnan_p = {`QNAN_P};}
		cp_operand_c_qnan_m: coverpoint operand_c_i {bins qnan_m = {`QNAN_M};}
		cp_operand_c_snan_p: coverpoint operand_c_i {bins snan_p = {`SNAN_P};}
		cp_operand_c_snan_m: coverpoint operand_c_i {bins snan_m = {`SNAN_M};}
		cp_operand_c_zero_p: coverpoint operand_c_i {bins zero_p = {`ZERO_P};}
		cp_operand_c_zero_m: coverpoint operand_c_i {bins zero_m = {`ZERO_M};}

		cp_result_o_cnan: coverpoint result_o {bins cnan = {`CNAN};}
		cp_result_o_infinite_p: coverpoint result_o {bins infinite_p = {`INFINITE_P};}
		cp_result_o_infinite_m: coverpoint result_o {bins infinite_m = {`INFINITE_M};}
		cp_result_o_normal_p: coverpoint result_o {bins normal_p = {`NO_FINITE_P};}
		cp_result_o_normal_m: coverpoint result_o {bins normal_m = {`NO_FINITE_M};}
		cp_result_o_zero_p: coverpoint result_o {bins zero_p = {`ZERO_P};}
		cp_result_o_zero_m: coverpoint result_o {bins zero_m = {`ZERO_M};}

		//cp_sign_a_plus: coverpoint operand_a_i[31] {bins plus = {1'b0};}
		//cp_sign_a_minus: coverpoint operand_a_i[31] {bins minus = {1'b0};}

		//cp_sign_b_plus: coverpoint operand_b_i[31] {bins plus = {1'b0};}
		//cp_sign_b_minus: coverpoint operand_b_i[31] {bins minus = {1'b0};}

		//cp_sign_c_plus: coverpoint operand_c_i[31] {bins plus = {1'b0};}
		//cp_sign_c_minus: coverpoint operand_c_i[31] {bins minus = {1'b0};}

		cr_fmadd_01: cross cp_operand_a_zero_p, cp_operand_b_zero_p, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmadd_02: cross cp_operand_a_zero_m, cp_operand_b_zero_m, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmadd_03: cross cp_operand_a_normal_p, cp_operand_b_zero_p, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmadd_04: cross cp_operand_a_normal_m, cp_operand_b_zero_m, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmadd_05: cross cp_operand_a_zero_p, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmadd_06: cross cp_operand_a_zero_m, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmadd_07: cross cp_operand_a_zero_p, cp_operand_b_zero_m, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmadd_08: cross cp_operand_a_zero_m, cp_operand_b_zero_p, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmadd_09: cross cp_operand_a_normal_p, cp_operand_b_zero_m, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmadd_10: cross cp_operand_a_normal_m, cp_operand_b_zero_p, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmadd_11: cross cp_operand_a_zero_p, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmadd_12: cross cp_operand_a_zero_m, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmadd_13: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_zero_p;
		cr_fmadd_14: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_zero_p;
		cr_fmadd_15: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_zero_p;
		cr_fmadd_16: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_zero_p;
		cr_fmadd_17: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmadd_18: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmadd_19: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmadd_20: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmadd_21: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmadd_22: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmadd_23: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmadd_24: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmadd_25: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmadd_26: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmadd_27: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmadd_28: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmadd_29: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmadd_30: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmadd_31: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmadd_32: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmadd_33: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmadd_34: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmadd_35: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmadd_36: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmadd_37: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmadd_38: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmadd_39: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmadd_40: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmadd_41: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmadd_42: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmadd_43: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmadd_44: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmadd_45: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmadd_46: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmadd_47: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmadd_48: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmadd_49: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmadd_50: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmadd_51: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmadd_52: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmadd_53: cross cp_operand_a_zero_p, cp_operand_b_zero_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmadd_54: cross cp_operand_a_zero_m, cp_operand_b_zero_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmadd_55: cross cp_operand_a_normal_p, cp_operand_b_zero_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmadd_56: cross cp_operand_a_normal_m, cp_operand_b_zero_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmadd_57: cross cp_operand_a_zero_p, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmadd_58: cross cp_operand_a_zero_m, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmadd_59: cross cp_operand_a_zero_p, cp_operand_b_zero_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmadd_60: cross cp_operand_a_zero_m, cp_operand_b_zero_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmadd_61: cross cp_operand_a_normal_p, cp_operand_b_zero_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmadd_62: cross cp_operand_a_normal_m, cp_operand_b_zero_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmadd_63: cross cp_operand_a_zero_p, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmadd_64: cross cp_operand_a_zero_m, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmadd_65: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmadd_66: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmadd_67: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmadd_68: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmadd_69: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmadd_70: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmadd_71: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmadd_72: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmadd_73: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmadd_74: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmadd_75: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmadd_76: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmadd_77: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmadd_78: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmadd_79: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmadd_80: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmadd_81: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmadd_82: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmadd_83: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmadd_84: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmadd_85: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmadd_86: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmadd_87: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmadd_88: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmadd_89: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmadd_90: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmadd_91: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmadd_92: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmadd_93: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmadd_94: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmadd_95: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmadd_96: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmadd_97: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmadd_98: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmadd_99: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmadd_100: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmadd_101: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmadd_102: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmadd_103: cross cp_operand_a_zero_p, cp_operand_b_zero_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmadd_104: cross cp_operand_a_zero_m, cp_operand_b_zero_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmadd_105: cross cp_operand_a_normal_p, cp_operand_b_zero_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmadd_106: cross cp_operand_a_normal_m, cp_operand_b_zero_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmadd_107: cross cp_operand_a_zero_p, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmadd_108: cross cp_operand_a_zero_m, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmadd_109: cross cp_operand_a_zero_p, cp_operand_b_zero_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmadd_110: cross cp_operand_a_zero_m, cp_operand_b_zero_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmadd_111: cross cp_operand_a_normal_p, cp_operand_b_zero_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmadd_112: cross cp_operand_a_normal_m, cp_operand_b_zero_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmadd_113: cross cp_operand_a_zero_p, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmadd_114: cross cp_operand_a_zero_m, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmadd_115: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmadd_116: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmadd_117: cross cp_operand_a_zero_p, cp_operand_b_zero_p, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmadd_118: cross cp_operand_a_zero_m, cp_operand_b_zero_m, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmadd_119: cross cp_operand_a_normal_p, cp_operand_b_zero_p, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmadd_120: cross cp_operand_a_normal_m, cp_operand_b_zero_m, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmadd_121: cross cp_operand_a_zero_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmadd_122: cross cp_operand_a_zero_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmadd_123: cross cp_operand_a_zero_p, cp_operand_b_zero_m, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmadd_124: cross cp_operand_a_zero_m, cp_operand_b_zero_p, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmadd_125: cross cp_operand_a_normal_p, cp_operand_b_zero_m, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmadd_126: cross cp_operand_a_normal_m, cp_operand_b_zero_p, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmadd_127: cross cp_operand_a_zero_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmadd_128: cross cp_operand_a_zero_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmadd_129: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_normal_p;
		cr_fmadd_130: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_normal_p;
		cr_fmadd_131: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_normal_p;
		cr_fmadd_132: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_normal_p;
		cr_fmadd_133: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmadd_134: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmadd_135: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmadd_136: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmadd_137: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmadd_138: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmadd_139: cross cp_operand_a_zero_p, cp_operand_b_zero_p, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmadd_140: cross cp_operand_a_zero_m, cp_operand_b_zero_m, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmadd_141: cross cp_operand_a_normal_p, cp_operand_b_zero_p, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmadd_142: cross cp_operand_a_normal_m, cp_operand_b_zero_m, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmadd_143: cross cp_operand_a_zero_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmadd_144: cross cp_operand_a_zero_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmadd_145: cross cp_operand_a_zero_p, cp_operand_b_zero_m, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmadd_146: cross cp_operand_a_zero_m, cp_operand_b_zero_p, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmadd_147: cross cp_operand_a_normal_p, cp_operand_b_zero_m, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmadd_148: cross cp_operand_a_normal_m, cp_operand_b_zero_p, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmadd_149: cross cp_operand_a_zero_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmadd_150: cross cp_operand_a_zero_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmadd_151: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_normal_m;
		cr_fmadd_152: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_normal_m;
		cr_fmadd_153: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_normal_m;
		cr_fmadd_154: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_normal_m;
		cr_fmadd_155: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmadd_156: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmadd_157: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmadd_158: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmadd_159: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmadd_160: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_normal_m;
		//cr_fmadd_161: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_cnan;
		//cr_fmadd_162: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmadd_163: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmadd_164: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmadd_165: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmadd_166: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmadd_167: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmadd_168: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_infinite_p, cp_result_o_cnan;
		//cr_fmadd_169: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_cnan;
		//cr_fmadd_170: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmadd_171: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmadd_172: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmadd_173: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmadd_174: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmadd_175: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmadd_176: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmadd_177: cross cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_result_o_cnan;
		cr_fmadd_178: cross cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_result_o_cnan;
		cr_fmadd_179: cross cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_result_o_cnan;
		cr_fmadd_180: cross cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_result_o_cnan;
		cr_fmadd_181: cross cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_result_o_cnan;
		cr_fmadd_182: cross cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_result_o_cnan;
		cr_fmadd_183: cross cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_result_o_cnan;
		cr_fmadd_184: cross cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_result_o_cnan;
		cr_fmadd_185: cross cp_operand_a_qnan_p, cp_result_o_cnan;
		cr_fmadd_186: cross cp_operand_a_qnan_m, cp_result_o_cnan;
		cr_fmadd_187: cross cp_operand_a_snan_p, cp_result_o_cnan;
		cr_fmadd_188: cross cp_operand_a_snan_m, cp_result_o_cnan;
		cr_fmadd_189: cross cp_operand_b_qnan_p, cp_result_o_cnan;
		cr_fmadd_190: cross cp_operand_b_qnan_m, cp_result_o_cnan;
		cr_fmadd_191: cross cp_operand_b_snan_p, cp_result_o_cnan;
		cr_fmadd_192: cross cp_operand_b_snan_m, cp_result_o_cnan;

		cr_fmnadd_01: cross cp_operand_a_zero_p, cp_operand_b_zero_p, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmnadd_02: cross cp_operand_a_zero_m, cp_operand_b_zero_m, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmnadd_03: cross cp_operand_a_normal_p, cp_operand_b_zero_p, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmnadd_04: cross cp_operand_a_normal_m, cp_operand_b_zero_m, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmnadd_05: cross cp_operand_a_zero_p, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmnadd_06: cross cp_operand_a_zero_m, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmnadd_07: cross cp_operand_a_zero_p, cp_operand_b_zero_m, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmnadd_08: cross cp_operand_a_zero_m, cp_operand_b_zero_p, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmnadd_09: cross cp_operand_a_normal_p, cp_operand_b_zero_m, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmnadd_10: cross cp_operand_a_normal_m, cp_operand_b_zero_p, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmnadd_11: cross cp_operand_a_zero_p, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmnadd_12: cross cp_operand_a_zero_m, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmnadd_13: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_zero_p;
		cr_fmnadd_14: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_zero_p;
		cr_fmnadd_15: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_zero_p;
		cr_fmnadd_16: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_zero_p;
		cr_fmnadd_17: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmnadd_18: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmnadd_19: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmnadd_20: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmnadd_21: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmnadd_22: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmnadd_23: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmnadd_24: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmnadd_25: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmnadd_26: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmnadd_27: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmnadd_28: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmnadd_29: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmnadd_30: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmnadd_31: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmnadd_32: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmnadd_33: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmnadd_34: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmnadd_35: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmnadd_36: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmnadd_37: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmnadd_38: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmnadd_39: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmnadd_40: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmnadd_41: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmnadd_42: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmnadd_43: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmnadd_44: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmnadd_45: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmnadd_46: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmnadd_47: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmnadd_48: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmnadd_49: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnadd_50: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnadd_51: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnadd_52: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnadd_53: cross cp_operand_a_zero_p, cp_operand_b_zero_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnadd_54: cross cp_operand_a_zero_m, cp_operand_b_zero_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnadd_55: cross cp_operand_a_normal_p, cp_operand_b_zero_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnadd_56: cross cp_operand_a_normal_m, cp_operand_b_zero_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnadd_57: cross cp_operand_a_zero_p, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnadd_58: cross cp_operand_a_zero_m, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnadd_59: cross cp_operand_a_zero_p, cp_operand_b_zero_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnadd_60: cross cp_operand_a_zero_m, cp_operand_b_zero_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnadd_61: cross cp_operand_a_normal_p, cp_operand_b_zero_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnadd_62: cross cp_operand_a_normal_m, cp_operand_b_zero_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnadd_63: cross cp_operand_a_zero_p, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnadd_64: cross cp_operand_a_zero_m, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnadd_65: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmnadd_66: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmnadd_67: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmnadd_68: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmnadd_69: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmnadd_70: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmnadd_71: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmnadd_72: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmnadd_73: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmnadd_74: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmnadd_75: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmnadd_76: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmnadd_77: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmnadd_78: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmnadd_79: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmnadd_80: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmnadd_81: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmnadd_82: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmnadd_83: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmnadd_84: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmnadd_85: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmnadd_86: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmnadd_87: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmnadd_88: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmnadd_89: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmnadd_90: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmnadd_91: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmnadd_92: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmnadd_93: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmnadd_94: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmnadd_95: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmnadd_96: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmnadd_97: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmnadd_98: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmnadd_99: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnadd_100: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnadd_101: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnadd_102: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnadd_103: cross cp_operand_a_zero_p, cp_operand_b_zero_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnadd_104: cross cp_operand_a_zero_m, cp_operand_b_zero_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnadd_105: cross cp_operand_a_normal_p, cp_operand_b_zero_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnadd_106: cross cp_operand_a_normal_m, cp_operand_b_zero_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnadd_107: cross cp_operand_a_zero_p, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnadd_108: cross cp_operand_a_zero_m, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnadd_109: cross cp_operand_a_zero_p, cp_operand_b_zero_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnadd_110: cross cp_operand_a_zero_m, cp_operand_b_zero_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnadd_111: cross cp_operand_a_normal_p, cp_operand_b_zero_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnadd_112: cross cp_operand_a_normal_m, cp_operand_b_zero_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnadd_113: cross cp_operand_a_zero_p, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnadd_114: cross cp_operand_a_zero_m, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnadd_115: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmnadd_116: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmnadd_117: cross cp_operand_a_zero_p, cp_operand_b_zero_p, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmnadd_118: cross cp_operand_a_zero_m, cp_operand_b_zero_m, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmnadd_119: cross cp_operand_a_normal_p, cp_operand_b_zero_p, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmnadd_120: cross cp_operand_a_normal_m, cp_operand_b_zero_m, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmnadd_121: cross cp_operand_a_zero_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmnadd_122: cross cp_operand_a_zero_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmnadd_123: cross cp_operand_a_zero_p, cp_operand_b_zero_m, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmnadd_124: cross cp_operand_a_zero_m, cp_operand_b_zero_p, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmnadd_125: cross cp_operand_a_normal_p, cp_operand_b_zero_m, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmnadd_126: cross cp_operand_a_normal_m, cp_operand_b_zero_p, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmnadd_127: cross cp_operand_a_zero_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmnadd_128: cross cp_operand_a_zero_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmnadd_129: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_normal_p;
		cr_fmnadd_130: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_normal_p;
		cr_fmnadd_131: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_normal_p;
		cr_fmnadd_132: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_normal_p;
		cr_fmnadd_133: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmnadd_134: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmnadd_135: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmnadd_136: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmnadd_137: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmnadd_138: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmnadd_139: cross cp_operand_a_zero_p, cp_operand_b_zero_p, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmnadd_140: cross cp_operand_a_zero_m, cp_operand_b_zero_m, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmnadd_141: cross cp_operand_a_normal_p, cp_operand_b_zero_p, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmnadd_142: cross cp_operand_a_normal_m, cp_operand_b_zero_m, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmnadd_143: cross cp_operand_a_zero_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmnadd_144: cross cp_operand_a_zero_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmnadd_145: cross cp_operand_a_zero_p, cp_operand_b_zero_m, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmnadd_146: cross cp_operand_a_zero_m, cp_operand_b_zero_p, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmnadd_147: cross cp_operand_a_normal_p, cp_operand_b_zero_m, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmnadd_148: cross cp_operand_a_normal_m, cp_operand_b_zero_p, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmnadd_149: cross cp_operand_a_zero_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmnadd_150: cross cp_operand_a_zero_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmnadd_151: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_normal_m;
		cr_fmnadd_152: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_normal_m;
		cr_fmnadd_153: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_normal_m;
		cr_fmnadd_154: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_normal_m;
		cr_fmnadd_155: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmnadd_156: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmnadd_157: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmnadd_158: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmnadd_159: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmnadd_160: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_normal_m;
		//cr_fmnadd_161: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_cnan;
		//cr_fmnadd_162: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmnadd_163: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmnadd_164: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmnadd_165: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmnadd_166: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmnadd_167: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmnadd_168: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_infinite_p, cp_result_o_cnan;
		//cr_fmnadd_169: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_cnan;
		//cr_fmnadd_170: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmnadd_171: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmnadd_172: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmnadd_173: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmnadd_174: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmnadd_175: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmnadd_176: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmnadd_177: cross cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_result_o_cnan;
		cr_fmnadd_178: cross cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_result_o_cnan;
		cr_fmnadd_179: cross cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_result_o_cnan;
		cr_fmnadd_180: cross cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_result_o_cnan;
		cr_fmnadd_181: cross cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_result_o_cnan;
		cr_fmnadd_182: cross cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_result_o_cnan;
		cr_fmnadd_183: cross cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_result_o_cnan;
		cr_fmnadd_184: cross cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_result_o_cnan;
		cr_fmnadd_185: cross cp_operand_a_qnan_p, cp_result_o_cnan;
		cr_fmnadd_186: cross cp_operand_a_qnan_m, cp_result_o_cnan;
		cr_fmnadd_187: cross cp_operand_a_snan_p, cp_result_o_cnan;
		cr_fmnadd_188: cross cp_operand_a_snan_m, cp_result_o_cnan;
		cr_fmnadd_189: cross cp_operand_b_qnan_p, cp_result_o_cnan;
		cr_fmnadd_190: cross cp_operand_b_qnan_m, cp_result_o_cnan;
		cr_fmnadd_191: cross cp_operand_b_snan_p, cp_result_o_cnan;
		cr_fmnadd_192: cross cp_operand_b_snan_m, cp_result_o_cnan;

		cr_fmsub_01: cross cp_operand_a_zero_p, cp_operand_b_zero_p, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmsub_02: cross cp_operand_a_zero_m, cp_operand_b_zero_m, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmsub_03: cross cp_operand_a_normal_p, cp_operand_b_zero_p, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmsub_04: cross cp_operand_a_normal_m, cp_operand_b_zero_m, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmsub_05: cross cp_operand_a_zero_p, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmsub_06: cross cp_operand_a_zero_m, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmsub_07: cross cp_operand_a_zero_p, cp_operand_b_zero_m, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmsub_08: cross cp_operand_a_zero_m, cp_operand_b_zero_p, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmsub_09: cross cp_operand_a_normal_p, cp_operand_b_zero_m, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmsub_10: cross cp_operand_a_normal_m, cp_operand_b_zero_p, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmsub_11: cross cp_operand_a_zero_p, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmsub_12: cross cp_operand_a_zero_m, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmsub_13: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_zero_p;
		cr_fmsub_14: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_zero_p;
		cr_fmsub_15: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_zero_p;
		cr_fmsub_16: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_zero_p;
		cr_fmsub_17: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmsub_18: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmsub_19: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmsub_20: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmsub_21: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmsub_22: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmsub_23: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmsub_24: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmsub_25: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmsub_26: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmsub_27: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmsub_28: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmsub_29: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmsub_30: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmsub_31: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmsub_32: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmsub_33: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmsub_34: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmsub_35: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmsub_36: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmsub_37: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmsub_38: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmsub_39: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmsub_40: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmsub_41: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmsub_42: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmsub_43: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmsub_44: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmsub_45: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmsub_46: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmsub_47: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmsub_48: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmsub_49: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_50: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_51: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_52: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_53: cross cp_operand_a_zero_p, cp_operand_b_zero_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_54: cross cp_operand_a_zero_m, cp_operand_b_zero_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_55: cross cp_operand_a_normal_p, cp_operand_b_zero_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_56: cross cp_operand_a_normal_m, cp_operand_b_zero_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_57: cross cp_operand_a_zero_p, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_58: cross cp_operand_a_zero_m, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_59: cross cp_operand_a_zero_p, cp_operand_b_zero_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_60: cross cp_operand_a_zero_m, cp_operand_b_zero_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_61: cross cp_operand_a_normal_p, cp_operand_b_zero_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_62: cross cp_operand_a_normal_m, cp_operand_b_zero_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_63: cross cp_operand_a_zero_p, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_64: cross cp_operand_a_zero_m, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_65: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmsub_66: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmsub_67: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_68: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_69: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_70: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_71: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_72: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_73: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_74: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmsub_75: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmsub_76: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmsub_77: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmsub_78: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmsub_79: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmsub_80: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmsub_81: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmsub_82: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmsub_83: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmsub_84: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmsub_85: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmsub_86: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmsub_87: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmsub_88: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmsub_89: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmsub_90: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmsub_91: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmsub_92: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmsub_93: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmsub_94: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmsub_95: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmsub_96: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmsub_97: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmsub_98: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmsub_99: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmsub_100: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmsub_101: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmsub_102: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmsub_103: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmsub_104: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmsub_105: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmsub_106: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmsub_107: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_108: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_109: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_110: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_111: cross cp_operand_a_zero_p, cp_operand_b_zero_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_112: cross cp_operand_a_zero_m, cp_operand_b_zero_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_113: cross cp_operand_a_normal_p, cp_operand_b_zero_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_114: cross cp_operand_a_normal_m, cp_operand_b_zero_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_115: cross cp_operand_a_zero_p, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_116: cross cp_operand_a_zero_m, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_117: cross cp_operand_a_zero_p, cp_operand_b_zero_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_118: cross cp_operand_a_zero_m, cp_operand_b_zero_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_119: cross cp_operand_a_normal_p, cp_operand_b_zero_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_120: cross cp_operand_a_normal_m, cp_operand_b_zero_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_121: cross cp_operand_a_zero_p, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_122: cross cp_operand_a_zero_m, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_123: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmsub_124: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmsub_125: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_126: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_127: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_128: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_129: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_130: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_131: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_132: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmsub_133: cross cp_operand_a_zero_p, cp_operand_b_zero_p, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmsub_134: cross cp_operand_a_zero_m, cp_operand_b_zero_m, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmsub_135: cross cp_operand_a_normal_p, cp_operand_b_zero_p, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmsub_136: cross cp_operand_a_normal_m, cp_operand_b_zero_m, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmsub_137: cross cp_operand_a_zero_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmsub_138: cross cp_operand_a_zero_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmsub_139: cross cp_operand_a_zero_p, cp_operand_b_zero_m, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmsub_140: cross cp_operand_a_zero_m, cp_operand_b_zero_p, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmsub_141: cross cp_operand_a_normal_p, cp_operand_b_zero_m, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmsub_142: cross cp_operand_a_normal_m, cp_operand_b_zero_p, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmsub_143: cross cp_operand_a_zero_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmsub_144: cross cp_operand_a_zero_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmsub_145: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_normal_p;
		cr_fmsub_146: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_normal_p;
		cr_fmsub_147: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_normal_p;
		cr_fmsub_148: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_normal_p;
		cr_fmsub_149: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmsub_150: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmsub_151: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmsub_152: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmsub_153: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmsub_154: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmsub_155: cross cp_operand_a_zero_p, cp_operand_b_zero_p, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmsub_156: cross cp_operand_a_zero_m, cp_operand_b_zero_m, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmsub_157: cross cp_operand_a_normal_p, cp_operand_b_zero_p, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmsub_158: cross cp_operand_a_normal_m, cp_operand_b_zero_m, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmsub_159: cross cp_operand_a_zero_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmsub_160: cross cp_operand_a_zero_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmsub_161: cross cp_operand_a_zero_p, cp_operand_b_zero_m, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmsub_162: cross cp_operand_a_zero_m, cp_operand_b_zero_p, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmsub_163: cross cp_operand_a_normal_p, cp_operand_b_zero_m, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmsub_164: cross cp_operand_a_normal_m, cp_operand_b_zero_p, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmsub_165: cross cp_operand_a_zero_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmsub_166: cross cp_operand_a_zero_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmsub_167: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_normal_m;
		cr_fmsub_168: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_normal_m;
		cr_fmsub_169: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_normal_m;
		cr_fmsub_170: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_normal_m;
		cr_fmsub_171: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmsub_172: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmsub_173: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmsub_174: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmsub_175: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmsub_176: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_normal_m;
		//cr_fmsub_177: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_cnan;
		//cr_fmsub_178: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmsub_179: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmsub_180: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmsub_181: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmsub_182: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmsub_183: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmsub_184: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_infinite_p, cp_result_o_cnan;
		//cr_fmsub_185: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_cnan;
		//cr_fmsub_186: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmsub_187: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmsub_188: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmsub_189: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmsub_190: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmsub_191: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmsub_192: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmsub_193: cross cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_result_o_cnan;
		cr_fmsub_194: cross cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_result_o_cnan;
		cr_fmsub_195: cross cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_result_o_cnan;
		cr_fmsub_196: cross cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_result_o_cnan;
		cr_fmsub_197: cross cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_result_o_cnan;
		cr_fmsub_198: cross cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_result_o_cnan;
		cr_fmsub_199: cross cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_result_o_cnan;
		cr_fmsub_200: cross cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_result_o_cnan;
		cr_fmsub_201: cross cp_operand_a_qnan_p, cp_result_o_cnan;
		cr_fmsub_202: cross cp_operand_a_qnan_m, cp_result_o_cnan;
		cr_fmsub_203: cross cp_operand_a_snan_p, cp_result_o_cnan;
		cr_fmsub_204: cross cp_operand_a_snan_m, cp_result_o_cnan;
		cr_fmsub_205: cross cp_operand_b_qnan_p, cp_result_o_cnan;
		cr_fmsub_206: cross cp_operand_b_qnan_m, cp_result_o_cnan;
		cr_fmsub_207: cross cp_operand_b_snan_p, cp_result_o_cnan;
		cr_fmsub_208: cross cp_operand_b_snan_m, cp_result_o_cnan;

		cr_fmnsub_01: cross cp_operand_a_zero_p, cp_operand_b_zero_p, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmnsub_02: cross cp_operand_a_zero_m, cp_operand_b_zero_m, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmnsub_03: cross cp_operand_a_normal_p, cp_operand_b_zero_p, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmnsub_04: cross cp_operand_a_normal_m, cp_operand_b_zero_m, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmnsub_05: cross cp_operand_a_zero_p, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmnsub_06: cross cp_operand_a_zero_m, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_zero_p;
		cr_fmnsub_07: cross cp_operand_a_zero_p, cp_operand_b_zero_m, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmnsub_08: cross cp_operand_a_zero_m, cp_operand_b_zero_p, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmnsub_09: cross cp_operand_a_normal_p, cp_operand_b_zero_m, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmnsub_10: cross cp_operand_a_normal_m, cp_operand_b_zero_p, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmnsub_11: cross cp_operand_a_zero_p, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmnsub_12: cross cp_operand_a_zero_m, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_zero_p;
		cr_fmnsub_13: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_zero_p;
		cr_fmnsub_14: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_zero_p;
		cr_fmnsub_15: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_zero_p;
		cr_fmnsub_16: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_zero_p;
		cr_fmnsub_17: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmnsub_18: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmnsub_19: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmnsub_20: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmnsub_21: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmnsub_22: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmnsub_23: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmnsub_24: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_normal_p, cp_result_o_infinite_p;
		cr_fmnsub_25: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmnsub_26: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmnsub_27: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmnsub_28: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmnsub_29: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmnsub_30: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmnsub_31: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmnsub_32: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmnsub_33: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmnsub_34: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmnsub_35: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmnsub_36: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmnsub_37: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmnsub_38: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmnsub_39: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmnsub_40: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_zero_p, cp_result_o_infinite_p;
		cr_fmnsub_41: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmnsub_42: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmnsub_43: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmnsub_44: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmnsub_45: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmnsub_46: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmnsub_47: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmnsub_48: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_zero_m, cp_result_o_infinite_p;
		cr_fmnsub_49: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_50: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_51: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_52: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_53: cross cp_operand_a_zero_p, cp_operand_b_zero_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_54: cross cp_operand_a_zero_m, cp_operand_b_zero_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_55: cross cp_operand_a_normal_p, cp_operand_b_zero_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_56: cross cp_operand_a_normal_m, cp_operand_b_zero_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_57: cross cp_operand_a_zero_p, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_58: cross cp_operand_a_zero_m, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_59: cross cp_operand_a_zero_p, cp_operand_b_zero_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_60: cross cp_operand_a_zero_m, cp_operand_b_zero_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_61: cross cp_operand_a_normal_p, cp_operand_b_zero_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_62: cross cp_operand_a_normal_m, cp_operand_b_zero_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_63: cross cp_operand_a_zero_p, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_64: cross cp_operand_a_zero_m, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_65: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmnsub_66: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_infinite_p;
		cr_fmnsub_67: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_68: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_69: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_70: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_71: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_72: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_73: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_74: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_infinite_p, cp_result_o_infinite_p;
		cr_fmnsub_75: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmnsub_76: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmnsub_77: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmnsub_78: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmnsub_79: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmnsub_80: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmnsub_81: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmnsub_82: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmnsub_83: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmnsub_84: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmnsub_85: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmnsub_86: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmnsub_87: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmnsub_88: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmnsub_89: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmnsub_90: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_normal_m, cp_result_o_infinite_m;
		cr_fmnsub_91: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmnsub_92: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmnsub_93: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmnsub_94: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmnsub_95: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmnsub_96: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmnsub_97: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmnsub_98: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_zero_p, cp_result_o_infinite_m;
		cr_fmnsub_99: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmnsub_100: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmnsub_101: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmnsub_102: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmnsub_103: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmnsub_104: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmnsub_105: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmnsub_106: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_zero_m, cp_result_o_infinite_m;
		cr_fmnsub_107: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_108: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_109: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_110: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_111: cross cp_operand_a_zero_p, cp_operand_b_zero_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_112: cross cp_operand_a_zero_m, cp_operand_b_zero_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_113: cross cp_operand_a_normal_p, cp_operand_b_zero_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_114: cross cp_operand_a_normal_m, cp_operand_b_zero_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_115: cross cp_operand_a_zero_p, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_116: cross cp_operand_a_zero_m, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_117: cross cp_operand_a_zero_p, cp_operand_b_zero_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_118: cross cp_operand_a_zero_m, cp_operand_b_zero_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_119: cross cp_operand_a_normal_p, cp_operand_b_zero_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_120: cross cp_operand_a_normal_m, cp_operand_b_zero_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_121: cross cp_operand_a_zero_p, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_122: cross cp_operand_a_zero_m, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_123: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmnsub_124: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_infinite_m;
		cr_fmnsub_125: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_126: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_127: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_128: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_129: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_130: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_131: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_132: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_infinite_m, cp_result_o_infinite_m;
		cr_fmnsub_133: cross cp_operand_a_zero_p, cp_operand_b_zero_p, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmnsub_134: cross cp_operand_a_zero_m, cp_operand_b_zero_m, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmnsub_135: cross cp_operand_a_normal_p, cp_operand_b_zero_p, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmnsub_136: cross cp_operand_a_normal_m, cp_operand_b_zero_m, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmnsub_137: cross cp_operand_a_zero_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmnsub_138: cross cp_operand_a_zero_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmnsub_139: cross cp_operand_a_zero_p, cp_operand_b_zero_m, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmnsub_140: cross cp_operand_a_zero_m, cp_operand_b_zero_p, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmnsub_141: cross cp_operand_a_normal_p, cp_operand_b_zero_m, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmnsub_142: cross cp_operand_a_normal_m, cp_operand_b_zero_p, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmnsub_143: cross cp_operand_a_zero_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmnsub_144: cross cp_operand_a_zero_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmnsub_145: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_normal_p;
		cr_fmnsub_146: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_normal_p;
		cr_fmnsub_147: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_normal_p;
		cr_fmnsub_148: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_normal_p;
		cr_fmnsub_149: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmnsub_150: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmnsub_151: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmnsub_152: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_normal_p;
		cr_fmnsub_153: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmnsub_154: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_normal_p;
		cr_fmnsub_155: cross cp_operand_a_zero_p, cp_operand_b_zero_p, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmnsub_156: cross cp_operand_a_zero_m, cp_operand_b_zero_m, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmnsub_157: cross cp_operand_a_normal_p, cp_operand_b_zero_p, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmnsub_158: cross cp_operand_a_normal_m, cp_operand_b_zero_m, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmnsub_159: cross cp_operand_a_zero_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmnsub_160: cross cp_operand_a_zero_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmnsub_161: cross cp_operand_a_zero_p, cp_operand_b_zero_m, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmnsub_162: cross cp_operand_a_zero_m, cp_operand_b_zero_p, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmnsub_163: cross cp_operand_a_normal_p, cp_operand_b_zero_m, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmnsub_164: cross cp_operand_a_normal_m, cp_operand_b_zero_p, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmnsub_165: cross cp_operand_a_zero_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmnsub_166: cross cp_operand_a_zero_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmnsub_167: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_zero_p, cp_result_o_normal_m;
		cr_fmnsub_168: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_zero_p, cp_result_o_normal_m;
		cr_fmnsub_169: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_zero_m, cp_result_o_normal_m;
		cr_fmnsub_170: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_zero_m, cp_result_o_normal_m;
		cr_fmnsub_171: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmnsub_172: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_m, cp_result_o_normal_m;
		cr_fmnsub_173: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmnsub_174: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmnsub_175: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_normal_p, cp_result_o_normal_m;
		cr_fmnsub_176: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_normal_p, cp_result_o_normal_m;
		//cr_fmnsub_177: cross cp_operand_a_normal_p, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_cnan;
		//cr_fmnsub_178: cross cp_operand_a_normal_m, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmnsub_179: cross cp_operand_a_normal_p, cp_operand_b_infinite_m, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmnsub_180: cross cp_operand_a_normal_m, cp_operand_b_infinite_p, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmnsub_181: cross cp_operand_a_infinite_p, cp_operand_b_normal_m, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmnsub_182: cross cp_operand_a_infinite_m, cp_operand_b_normal_p, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmnsub_183: cross cp_operand_a_infinite_p, cp_operand_b_infinite_m, cp_operand_c_infinite_p, cp_result_o_cnan;
		cr_fmnsub_184: cross cp_operand_a_infinite_m, cp_operand_b_infinite_p, cp_operand_c_infinite_p, cp_result_o_cnan;
		//cr_fmnsub_185: cross cp_operand_a_normal_p, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_cnan;
		//cr_fmnsub_186: cross cp_operand_a_normal_m, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmnsub_187: cross cp_operand_a_normal_p, cp_operand_b_infinite_p, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmnsub_188: cross cp_operand_a_normal_m, cp_operand_b_infinite_m, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmnsub_189: cross cp_operand_a_infinite_p, cp_operand_b_normal_p, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmnsub_190: cross cp_operand_a_infinite_m, cp_operand_b_normal_m, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmnsub_191: cross cp_operand_a_infinite_p, cp_operand_b_infinite_p, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmnsub_192: cross cp_operand_a_infinite_m, cp_operand_b_infinite_m, cp_operand_c_infinite_m, cp_result_o_cnan;
		cr_fmnsub_193: cross cp_operand_a_infinite_p, cp_operand_b_zero_p, cp_result_o_cnan;
		cr_fmnsub_194: cross cp_operand_a_infinite_p, cp_operand_b_zero_m, cp_result_o_cnan;
		cr_fmnsub_195: cross cp_operand_a_infinite_m, cp_operand_b_zero_p, cp_result_o_cnan;
		cr_fmnsub_196: cross cp_operand_a_infinite_m, cp_operand_b_zero_m, cp_result_o_cnan;
		cr_fmnsub_197: cross cp_operand_a_zero_p, cp_operand_b_infinite_p, cp_result_o_cnan;
		cr_fmnsub_198: cross cp_operand_a_zero_p, cp_operand_b_infinite_m, cp_result_o_cnan;
		cr_fmnsub_199: cross cp_operand_a_zero_m, cp_operand_b_infinite_p, cp_result_o_cnan;
		cr_fmnsub_200: cross cp_operand_a_zero_m, cp_operand_b_infinite_m, cp_result_o_cnan;
		cr_fmnsub_201: cross cp_operand_a_qnan_p, cp_result_o_cnan;
		cr_fmnsub_202: cross cp_operand_a_qnan_m, cp_result_o_cnan;
		cr_fmnsub_203: cross cp_operand_a_snan_p, cp_result_o_cnan;
		cr_fmnsub_204: cross cp_operand_a_snan_m, cp_result_o_cnan;
		cr_fmnsub_205: cross cp_operand_b_qnan_p, cp_result_o_cnan;
		cr_fmnsub_206: cross cp_operand_b_qnan_m, cp_result_o_cnan;
		cr_fmnsub_207: cross cp_operand_b_snan_p, cp_result_o_cnan;
		cr_fmnsub_208: cross cp_operand_b_snan_m, cp_result_o_cnan;
	endgroup : cg_Result_format_Arith_fmadd_fmnadd_fmsub_fmnsub

	covergroup cg_Result_format_SM; //hoang.pham
		cp_op_fdiv: coverpoint op_i {bins fdiv  = {fdiv};}
		cp_op_fsqrt: coverpoint op_i {bins fsqrt = {fsqrt};}
		cp_op_fexp: coverpoint op_i {bins fexp  = {fexp};}
		cp_op_flog: coverpoint op_i {bins flog  = {flog};}

		cp_operand_a_infinite_p: coverpoint operand_a_i {bins infinite_p = {`INFINITE_P};}
		cp_operand_a_infinite_m: coverpoint operand_a_i {bins infinite_m = {`INFINITE_M};}
		cp_operand_a_normal_p: coverpoint operand_a_i {bins normal_p = {`NO_FINITE_P};}
		cp_operand_a_normal_m: coverpoint operand_a_i {bins normal_m = {`NO_FINITE_M};}
		cp_operand_a_qnan_p: coverpoint operand_a_i {bins qnan_p = {`QNAN_P};}
		cp_operand_a_qnan_m: coverpoint operand_a_i {bins qnan_m = {`QNAN_M};}
		cp_operand_a_snan_p: coverpoint operand_a_i {bins snan_p = {`SNAN_P};}
		cp_operand_a_snan_m: coverpoint operand_a_i {bins snan_m = {`SNAN_M};}
		cp_operand_a_zero_p: coverpoint operand_a_i {bins zero_p = {`ZERO_P};}
		cp_operand_a_zero_m: coverpoint operand_a_i {bins zero_m = {`ZERO_M};}

		cp_operand_b_infinite_p: coverpoint operand_b_i {bins infinite_p = {`INFINITE_P};}
		cp_operand_b_infinite_m: coverpoint operand_b_i {bins infinite_m = {`INFINITE_M};}
		cp_operand_b_normal_p: coverpoint operand_b_i {bins normal_p = {`NO_FINITE_P};}
		cp_operand_b_normal_m: coverpoint operand_b_i {bins normal_m = {`NO_FINITE_M};}
		cp_operand_b_qnan_p: coverpoint operand_b_i {bins qnan_p = {`QNAN_P};}
		cp_operand_b_qnan_m: coverpoint operand_b_i {bins qnan_m = {`QNAN_M};}
		cp_operand_b_snan_p: coverpoint operand_b_i {bins snan_p = {`SNAN_P};}
		cp_operand_b_snan_m: coverpoint operand_b_i {bins snan_m = {`SNAN_M};}
		cp_operand_b_zero_p: coverpoint operand_b_i {bins zero_p = {`ZERO_P};}
		cp_operand_b_zero_m: coverpoint operand_b_i {bins zero_m = {`ZERO_M};}

		cp_result_o_cnan: coverpoint result_o {bins cnan = {`CNAN};}
		cp_result_o_infinite_p: coverpoint result_o {bins infinite_p = {`INFINITE_P};}
		cp_result_o_infinite_m: coverpoint result_o {bins infinite_m = {`INFINITE_M};}
		cp_result_o_normal_p: coverpoint result_o {bins normal_p = {`NO_FINITE_P};}
		cp_result_o_normal_m: coverpoint result_o {bins normal_m = {`NO_FINITE_M};}
		cp_result_o_zero_p: coverpoint result_o {bins zero_p = {`ZERO_P};}
		cp_result_o_zero_m: coverpoint result_o {bins zero_m = {`ZERO_M};}

		cr_fdiv_01: cross cp_op_fdiv, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_normal_p;
		cr_fdiv_02: cross cp_op_fdiv, cp_result_o_infinite_p, cp_operand_a_normal_p, cp_operand_b_normal_p;
		cr_fdiv_03: cross cp_op_fdiv, cp_result_o_normal_m, cp_operand_a_normal_p, cp_operand_b_normal_m;
		cr_fdiv_04: cross cp_op_fdiv, cp_result_o_infinite_m, cp_operand_a_normal_p, cp_operand_b_normal_m;
		cr_fdiv_05: cross cp_op_fdiv, cp_result_o_infinite_p, cp_operand_a_normal_p, cp_operand_b_zero_p;
		cr_fdiv_06: cross cp_op_fdiv, cp_result_o_infinite_m, cp_operand_a_normal_p, cp_operand_b_zero_m;
		cr_fdiv_07: cross cp_op_fdiv, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_infinite_p;
		cr_fdiv_08: cross cp_op_fdiv, cp_result_o_zero_m, cp_operand_a_normal_p, cp_operand_b_infinite_m;
		cr_fdiv_09_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_qnan_p;
		cr_fdiv_09_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_qnan_m;
		cr_fdiv_10_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_snan_p;
		cr_fdiv_10_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_normal_p, cp_operand_b_snan_m;
		cr_fdiv_11: cross cp_op_fdiv, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_normal_p;
		cr_fdiv_12: cross cp_op_fdiv, cp_result_o_infinite_m, cp_operand_a_normal_m, cp_operand_b_normal_p;
		cr_fdiv_13: cross cp_op_fdiv, cp_result_o_normal_p, cp_operand_a_normal_m, cp_operand_b_normal_m;
		cr_fdiv_14: cross cp_op_fdiv, cp_result_o_infinite_p, cp_operand_a_normal_m, cp_operand_b_normal_m;
		cr_fdiv_15: cross cp_op_fdiv, cp_result_o_infinite_m, cp_operand_a_normal_m, cp_operand_b_zero_p;
		cr_fdiv_16: cross cp_op_fdiv, cp_result_o_infinite_p, cp_operand_a_normal_m, cp_operand_b_zero_m;
		cr_fdiv_17: cross cp_op_fdiv, cp_result_o_zero_m, cp_operand_a_normal_m, cp_operand_b_infinite_p;
		cr_fdiv_18: cross cp_op_fdiv, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_infinite_m;
		cr_fdiv_19_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_qnan_p;
		cr_fdiv_19_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_qnan_m;
		cr_fdiv_20_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_snan_p;
		cr_fdiv_20_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_normal_m, cp_operand_b_snan_m;
		cr_fdiv_21: cross cp_op_fdiv, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_normal_p;
		cr_fdiv_22: cross cp_op_fdiv, cp_result_o_zero_m, cp_operand_a_zero_p, cp_operand_b_normal_m;
		cr_fdiv_23: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_zero_p;
		cr_fdiv_24: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_zero_m;
		cr_fdiv_25: cross cp_op_fdiv, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_infinite_p;
		cr_fdiv_26: cross cp_op_fdiv, cp_result_o_zero_m, cp_operand_a_zero_p, cp_operand_b_infinite_m;
		cr_fdiv_27_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_qnan_p;
		cr_fdiv_27_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_qnan_m;
		cr_fdiv_28_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_snan_p;
		cr_fdiv_28_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_zero_p, cp_operand_b_snan_m;
		cr_fdiv_29: cross cp_op_fdiv, cp_result_o_zero_m, cp_operand_a_zero_m, cp_operand_b_normal_p;
		cr_fdiv_30: cross cp_op_fdiv, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_normal_m;
		cr_fdiv_31: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_zero_p;
		cr_fdiv_32: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_zero_m;
		cr_fdiv_33: cross cp_op_fdiv, cp_result_o_zero_m, cp_operand_a_zero_m, cp_operand_b_infinite_p;
		cr_fdiv_34: cross cp_op_fdiv, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_infinite_m;
		cr_fdiv_35_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_qnan_p;
		cr_fdiv_35_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_qnan_m;
		cr_fdiv_36_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_snan_p;
		cr_fdiv_36_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_zero_m, cp_operand_b_snan_m;
		cr_fdiv_37: cross cp_op_fdiv, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_normal_p;
		cr_fdiv_38: cross cp_op_fdiv, cp_result_o_infinite_m, cp_operand_a_infinite_p, cp_operand_b_normal_m;
		cr_fdiv_39: cross cp_op_fdiv, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_zero_p;
		cr_fdiv_40: cross cp_op_fdiv, cp_result_o_infinite_m, cp_operand_a_infinite_p, cp_operand_b_zero_m;
		cr_fdiv_41: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_infinite_p;
		cr_fdiv_42: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_infinite_m;
		cr_fdiv_43_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_qnan_p;
		cr_fdiv_43_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_qnan_m;
		cr_fdiv_44_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_snan_p;
		cr_fdiv_44_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_infinite_p, cp_operand_b_snan_m;
		cr_fdiv_45: cross cp_op_fdiv, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_normal_p;
		cr_fdiv_46: cross cp_op_fdiv, cp_result_o_infinite_p, cp_operand_a_infinite_m, cp_operand_b_normal_m;
		cr_fdiv_47: cross cp_op_fdiv, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_zero_p;
		cr_fdiv_48: cross cp_op_fdiv, cp_result_o_infinite_p, cp_operand_a_infinite_m, cp_operand_b_zero_m;
		cr_fdiv_49: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_infinite_p;
		cr_fdiv_50: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_infinite_m;
		cr_fdiv_51_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_qnan_p;
		cr_fdiv_51_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_qnan_m;
		cr_fdiv_52_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_snan_p;
		cr_fdiv_52_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_infinite_m, cp_operand_b_snan_m;
		cr_fdiv_53_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_normal_p;
		cr_fdiv_53_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_normal_p;
		cr_fdiv_54_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_normal_m;
		cr_fdiv_54_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_normal_m;
		cr_fdiv_55_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_zero_p;
		cr_fdiv_55_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_zero_p;
		cr_fdiv_56_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_zero_m;
		cr_fdiv_56_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_zero_m;
		cr_fdiv_57_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_infinite_p;
		cr_fdiv_57_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_infinite_p;
		cr_fdiv_58_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_infinite_m;
		cr_fdiv_58_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_infinite_m;
		cr_fdiv_59_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_qnan_p;
		cr_fdiv_59_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_qnan_p;
		cr_fdiv_59_3: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_qnan_m;
		cr_fdiv_59_4: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_qnan_m;
		cr_fdiv_60_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_snan_p;
		cr_fdiv_60_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_snan_p;
		cr_fdiv_60_3: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_snan_m;
		cr_fdiv_60_4: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_snan_m;
		cr_fdiv_61_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_normal_p;
		cr_fdiv_61_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_normal_p;
		cr_fdiv_62_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_normal_m;
		cr_fdiv_62_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_normal_m;
		cr_fdiv_63_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_zero_p;
		cr_fdiv_63_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_zero_p;
		cr_fdiv_64_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_zero_m;
		cr_fdiv_64_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_zero_m;
		cr_fdiv_65_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_infinite_p;
		cr_fdiv_65_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_infinite_p;
		cr_fdiv_66_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_infinite_m;
		cr_fdiv_66_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_infinite_m;
		cr_fdiv_67_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_qnan_p;
		cr_fdiv_67_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_qnan_m;
		cr_fdiv_67_3: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_qnan_p;
		cr_fdiv_67_4: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_qnan_m;
		cr_fdiv_68_1: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_snan_p;
		cr_fdiv_68_2: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_snan_m;
		cr_fdiv_68_3: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_snan_p;
		cr_fdiv_68_4: cross cp_op_fdiv, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_snan_m;

		cr_fsqrt_01: cross cp_op_fsqrt, cp_result_o_normal_p, cp_operand_a_normal_p;
		cr_fsqrt_02: cross cp_op_fsqrt, cp_result_o_cnan, cp_operand_a_normal_m;
		cr_fsqrt_03: cross cp_op_fsqrt, cp_result_o_zero_p, cp_operand_a_zero_p;
		cr_fsqrt_04: cross cp_op_fsqrt, cp_result_o_zero_m, cp_operand_a_zero_m;
		cr_fsqrt_05: cross cp_op_fsqrt, cp_result_o_infinite_p, cp_operand_a_infinite_p;
		cr_fsqrt_06: cross cp_op_fsqrt, cp_result_o_cnan, cp_operand_a_infinite_m;
		cr_fsqrt_07_1: cross cp_op_fsqrt, cp_result_o_cnan, cp_operand_a_qnan_p;
		cr_fsqrt_07_2: cross cp_op_fsqrt, cp_result_o_cnan, cp_operand_a_qnan_m;
		cr_fsqrt_08_1: cross cp_op_fsqrt, cp_result_o_cnan, cp_operand_a_snan_p;
		cr_fsqrt_08_2: cross cp_op_fsqrt, cp_result_o_cnan, cp_operand_a_snan_m;

		cr_fexp_01: cross cp_op_fexp, cp_result_o_normal_p, cp_operand_a_normal_p;
		cr_fexp_02: cross cp_op_fexp, cp_result_o_infinite_p, cp_operand_a_normal_p;
		cr_fexp_03: cross cp_op_fexp, cp_result_o_normal_p, cp_operand_a_normal_m;
		cr_fexp_05: cross cp_op_fexp, cp_result_o_normal_p, cp_operand_a_zero_p;
		cr_fexp_06: cross cp_op_fexp, cp_result_o_normal_p, cp_operand_a_zero_m;
		cr_fexp_07: cross cp_op_fexp, cp_result_o_infinite_p, cp_operand_a_infinite_p;
		cr_fexp_08: cross cp_op_fexp, cp_result_o_zero_p, cp_operand_a_infinite_m;
		cr_fexp_09_1: cross cp_op_fexp, cp_result_o_cnan, cp_operand_a_qnan_p;
		cr_fexp_09_2: cross cp_op_fexp, cp_result_o_cnan, cp_operand_a_qnan_m;
		cr_fexp_10_1: cross cp_op_fexp, cp_result_o_cnan, cp_operand_a_snan_p;
		cr_fexp_10_2: cross cp_op_fexp, cp_result_o_cnan, cp_operand_a_snan_m;

		cr_flog_01: cross cp_op_flog, cp_result_o_normal_p, cp_operand_a_normal_p;
		cr_flog_02: cross cp_op_flog, cp_result_o_normal_m, cp_operand_a_normal_p;
		cr_flog_03: cross cp_op_flog, cp_result_o_zero_p, cp_operand_a_normal_p;
		cr_flog_05: cross cp_op_flog, cp_result_o_cnan, cp_operand_a_normal_m;
		cr_flog_06: cross cp_op_flog, cp_result_o_infinite_m, cp_operand_a_zero_p;
		cr_flog_07: cross cp_op_flog, cp_result_o_infinite_m, cp_operand_a_zero_m;
		cr_flog_08: cross cp_op_flog, cp_result_o_infinite_p, cp_operand_a_infinite_p;
		cr_flog_09: cross cp_op_flog, cp_result_o_cnan, cp_operand_a_infinite_m;
		cr_flog_10_1: cross cp_op_flog, cp_result_o_cnan, cp_operand_a_qnan_p;
		cr_flog_10_2: cross cp_op_flog, cp_result_o_cnan, cp_operand_a_qnan_m;
		cr_flog_11_1: cross cp_op_flog, cp_result_o_cnan, cp_operand_a_snan_p;
		cr_flog_11_2: cross cp_op_flog, cp_result_o_cnan, cp_operand_a_snan_m;
	endgroup : cg_Result_format_SM

	covergroup cg_Result_format_Cmp_Cvt; //hoang.pham
		cp_op_fcvt_w_s: coverpoint op_i {bins fcvt_w_s = {fcvt_w_s};}
		cp_op_fcvt_wu_s: coverpoint op_i {bins fcvt_wu_s = {fcvt_wu_s};}
		cp_op_fcvt_s_w: coverpoint op_i {bins fcvt_s_w = {fcvt_s_w};}
		cp_op_fcvt_s_wu: coverpoint op_i {bins fcvt_s_wu = {fcvt_s_wu};}
						
		cp_op_fmin: coverpoint op_i {bins fmin = {fmin};}
		cp_op_fmax: coverpoint op_i {bins fmax = {fmax};}
		cp_op_feq: coverpoint op_i {bins feq = {feq};}
		cp_op_flt: coverpoint op_i {bins flt = {flt};}
		cp_op_fle: coverpoint op_i {bins fle = {fle};}
		cp_op_fne: coverpoint op_i {bins fne = {fne};}

		cp_operand_a_infinite_p: coverpoint operand_a_i {bins infinite_p = {`INFINITE_P};}
		cp_operand_a_infinite_m: coverpoint operand_a_i {bins infinite_m = {`INFINITE_M};}
		cp_operand_a_normal_p: coverpoint operand_a_i {bins normal_p = {`NO_FINITE_P};}
		cp_operand_a_normal_m: coverpoint operand_a_i {bins normal_m = {`NO_FINITE_M};}
		cp_operand_a_qnan_p: coverpoint operand_a_i {bins qnan_p = {`QNAN_P};}
		cp_operand_a_qnan_m: coverpoint operand_a_i {bins qnan_m = {`QNAN_M};}
		cp_operand_a_snan_p: coverpoint operand_a_i {bins snan_p = {`SNAN_P};}
		cp_operand_a_snan_m: coverpoint operand_a_i {bins snan_m = {`SNAN_M};}
		cp_operand_a_zero_p: coverpoint operand_a_i {bins zero_p = {`ZERO_P};}
		cp_operand_a_zero_m: coverpoint operand_a_i {bins zero_m = {`ZERO_M};}

		cp_operand_b_infinite_p: coverpoint operand_b_i {bins infinite_p = {`INFINITE_P};}
		cp_operand_b_infinite_m: coverpoint operand_b_i {bins infinite_m = {`INFINITE_M};}
		cp_operand_b_normal_p: coverpoint operand_b_i {bins normal_p = {`NO_FINITE_P};}
		cp_operand_b_normal_m: coverpoint operand_b_i {bins normal_m = {`NO_FINITE_M};}
		cp_operand_b_qnan_p: coverpoint operand_b_i {bins qnan_p = {`QNAN_P};}
		cp_operand_b_qnan_m: coverpoint operand_b_i {bins qnan_m = {`QNAN_M};}
		cp_operand_b_snan_p: coverpoint operand_b_i {bins snan_p = {`SNAN_P};}
		cp_operand_b_snan_m: coverpoint operand_b_i {bins snan_m = {`SNAN_M};}
		cp_operand_b_zero_p: coverpoint operand_b_i {bins zero_p = {`ZERO_P};}
		cp_operand_b_zero_m: coverpoint operand_b_i {bins zero_m = {`ZERO_M};}

		cp_result_o_cnan: coverpoint result_o {bins cnan = {`CNAN};}
		cp_result_o_infinite_p: coverpoint result_o {bins infinite_p = {`INFINITE_P};}
		cp_result_o_infinite_m: coverpoint result_o {bins infinite_m = {`INFINITE_M};}
		cp_result_o_normal_p: coverpoint result_o {bins normal_p = {`NO_FINITE_P};}
		cp_result_o_normal_m: coverpoint result_o {bins normal_m = {`NO_FINITE_M};}
		cp_result_o_zero_p: coverpoint result_o {bins zero_p = {`ZERO_P};}
		cp_result_o_zero_m: coverpoint result_o {bins zero_m = {`ZERO_M};}
		cp_result_o_one: coverpoint result_o {bins one = {32'h0000_0001};}

		cr_fmin_01: cross cp_op_fmin, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_normal_p;
		cr_fmin_02: cross cp_op_fmin, cp_result_o_normal_m, cp_operand_a_normal_p, cp_operand_b_normal_m;
		cr_fmin_03: cross cp_op_fmin, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_zero_p;
		cr_fmin_04: cross cp_op_fmin, cp_result_o_zero_m, cp_operand_a_normal_p, cp_operand_b_zero_m;
		cr_fmin_05: cross cp_op_fmin, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_infinite_p;
		cr_fmin_06: cross cp_op_fmin, cp_result_o_infinite_m, cp_operand_a_normal_p, cp_operand_b_infinite_m;
		cr_fmin_07_1: cross cp_op_fmin, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_qnan_p;
		cr_fmin_07_2: cross cp_op_fmin, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_qnan_m;
		cr_fmin_08_1: cross cp_op_fmin, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_snan_p;
		cr_fmin_08_2: cross cp_op_fmin, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_snan_m;
		cr_fmin_09: cross cp_op_fmin, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_normal_p;
		cr_fmin_10: cross cp_op_fmin, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_normal_m;
		cr_fmin_11: cross cp_op_fmin, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_zero_p;
		cr_fmin_12: cross cp_op_fmin, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_zero_m;
		cr_fmin_13: cross cp_op_fmin, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_infinite_p;
		cr_fmin_14: cross cp_op_fmin, cp_result_o_infinite_m, cp_operand_a_normal_m, cp_operand_b_infinite_m;
		cr_fmin_15_1: cross cp_op_fmin, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_qnan_p;
		cr_fmin_15_2: cross cp_op_fmin, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_qnan_m;
		cr_fmin_16_1: cross cp_op_fmin, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_snan_p;
		cr_fmin_16_2: cross cp_op_fmin, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_snan_m;
		cr_fmin_17: cross cp_op_fmin, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_normal_p;
		cr_fmin_18: cross cp_op_fmin, cp_result_o_normal_m, cp_operand_a_zero_p, cp_operand_b_normal_m;
		cr_fmin_19: cross cp_op_fmin, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_zero_p;
		cr_fmin_20: cross cp_op_fmin, cp_result_o_zero_m, cp_operand_a_zero_p, cp_operand_b_zero_m;
		cr_fmin_21: cross cp_op_fmin, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_infinite_p;
		cr_fmin_22: cross cp_op_fmin, cp_result_o_infinite_m, cp_operand_a_zero_p, cp_operand_b_infinite_m;
		cr_fmin_23_1: cross cp_op_fmin, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_qnan_p;
		cr_fmin_23_2: cross cp_op_fmin, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_qnan_m;
		cr_fmin_24_1: cross cp_op_fmin, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_snan_p;
		cr_fmin_24_2: cross cp_op_fmin, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_snan_m;
		cr_fmin_25: cross cp_op_fmin, cp_result_o_zero_m, cp_operand_a_zero_m, cp_operand_b_normal_p;
		cr_fmin_26: cross cp_op_fmin, cp_result_o_normal_m, cp_operand_a_zero_m, cp_operand_b_normal_m;
		cr_fmin_27: cross cp_op_fmin, cp_result_o_zero_m, cp_operand_a_zero_m, cp_operand_b_zero_p;
		cr_fmin_28: cross cp_op_fmin, cp_result_o_zero_m, cp_operand_a_zero_m, cp_operand_b_zero_m;
		cr_fmin_29: cross cp_op_fmin, cp_result_o_zero_m, cp_operand_a_zero_m, cp_operand_b_infinite_p;
		cr_fmin_30: cross cp_op_fmin, cp_result_o_infinite_m, cp_operand_a_zero_m, cp_operand_b_infinite_m;
		cr_fmin_31_1: cross cp_op_fmin, cp_result_o_zero_m, cp_operand_a_zero_m, cp_operand_b_qnan_p;
		cr_fmin_31_2: cross cp_op_fmin, cp_result_o_zero_m, cp_operand_a_zero_m, cp_operand_b_qnan_m;
		cr_fmin_32_1: cross cp_op_fmin, cp_result_o_zero_m, cp_operand_a_zero_m, cp_operand_b_snan_p;
		cr_fmin_32_2: cross cp_op_fmin, cp_result_o_zero_m, cp_operand_a_zero_m, cp_operand_b_snan_m;
		cr_fmin_33: cross cp_op_fmin, cp_result_o_normal_p, cp_operand_a_infinite_p, cp_operand_b_normal_p;
		cr_fmin_34: cross cp_op_fmin, cp_result_o_normal_m, cp_operand_a_infinite_p, cp_operand_b_normal_m;
		cr_fmin_35: cross cp_op_fmin, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_zero_p;
		cr_fmin_36: cross cp_op_fmin, cp_result_o_zero_m, cp_operand_a_infinite_p, cp_operand_b_zero_m;
		cr_fmin_37: cross cp_op_fmin, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_infinite_p;
		cr_fmin_38: cross cp_op_fmin, cp_result_o_infinite_m, cp_operand_a_infinite_p, cp_operand_b_infinite_m;
		cr_fmin_39_1: cross cp_op_fmin, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_qnan_p;
		cr_fmin_39_2: cross cp_op_fmin, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_qnan_m;
		cr_fmin_40_1: cross cp_op_fmin, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_snan_p;
		cr_fmin_40_2: cross cp_op_fmin, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_snan_m;
		cr_fmin_41: cross cp_op_fmin, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_normal_p;
		cr_fmin_42: cross cp_op_fmin, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_normal_m;
		cr_fmin_43: cross cp_op_fmin, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_zero_p;
		cr_fmin_44: cross cp_op_fmin, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_zero_m;
		cr_fmin_45: cross cp_op_fmin, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_infinite_p;
		cr_fmin_46: cross cp_op_fmin, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_infinite_m;
		cr_fmin_47_1: cross cp_op_fmin, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_qnan_p;
		cr_fmin_47_2: cross cp_op_fmin, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_qnan_m;
		cr_fmin_48_1: cross cp_op_fmin, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_snan_p;
		cr_fmin_48_2: cross cp_op_fmin, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_snan_m;
		cr_fmin_49_1: cross cp_op_fmin, cp_result_o_normal_p, cp_operand_a_qnan_p, cp_operand_b_normal_p;
		cr_fmin_49_2: cross cp_op_fmin, cp_result_o_normal_p, cp_operand_a_qnan_m, cp_operand_b_normal_p;
		cr_fmin_50_1: cross cp_op_fmin, cp_result_o_normal_m, cp_operand_a_qnan_p, cp_operand_b_normal_m;
		cr_fmin_50_2: cross cp_op_fmin, cp_result_o_normal_m, cp_operand_a_qnan_m, cp_operand_b_normal_m;
		cr_fmin_51_1: cross cp_op_fmin, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_zero_p;
		cr_fmin_51_2: cross cp_op_fmin, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_zero_p;
		cr_fmin_52_1: cross cp_op_fmin, cp_result_o_zero_m, cp_operand_a_qnan_p, cp_operand_b_zero_m;
		cr_fmin_52_2: cross cp_op_fmin, cp_result_o_zero_m, cp_operand_a_qnan_m, cp_operand_b_zero_m;
		cr_fmin_53_1: cross cp_op_fmin, cp_result_o_infinite_p, cp_operand_a_qnan_p, cp_operand_b_infinite_p;
		cr_fmin_53_2: cross cp_op_fmin, cp_result_o_infinite_p, cp_operand_a_qnan_m, cp_operand_b_infinite_p;
		cr_fmin_54_1: cross cp_op_fmin, cp_result_o_infinite_m, cp_operand_a_qnan_p, cp_operand_b_infinite_m;
		cr_fmin_54_2: cross cp_op_fmin, cp_result_o_infinite_m, cp_operand_a_qnan_m, cp_operand_b_infinite_m;
		cr_fmin_55_1: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_qnan_p;
		cr_fmin_55_2: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_qnan_p;
		cr_fmin_55_3: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_qnan_m;
		cr_fmin_55_4: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_qnan_m;
		cr_fmin_56_1: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_snan_p;
		cr_fmin_56_2: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_snan_p;
		cr_fmin_56_3: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_snan_m;
		cr_fmin_56_4: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_snan_m;
		cr_fmin_57_1: cross cp_op_fmin, cp_result_o_normal_p, cp_operand_a_snan_p, cp_operand_b_normal_p;
		cr_fmin_57_2: cross cp_op_fmin, cp_result_o_normal_p, cp_operand_a_snan_m, cp_operand_b_normal_p;
		cr_fmin_58_1: cross cp_op_fmin, cp_result_o_normal_m, cp_operand_a_snan_p, cp_operand_b_normal_m;
		cr_fmin_58_2: cross cp_op_fmin, cp_result_o_normal_m, cp_operand_a_snan_m, cp_operand_b_normal_m;
		cr_fmin_59_1: cross cp_op_fmin, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_zero_p;
		cr_fmin_59_2: cross cp_op_fmin, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_zero_p;
		cr_fmin_60_1: cross cp_op_fmin, cp_result_o_zero_m, cp_operand_a_snan_p, cp_operand_b_zero_m;
		cr_fmin_60_2: cross cp_op_fmin, cp_result_o_zero_m, cp_operand_a_snan_m, cp_operand_b_zero_m;
		cr_fmin_61_1: cross cp_op_fmin, cp_result_o_infinite_p, cp_operand_a_snan_p, cp_operand_b_infinite_p;
		cr_fmin_61_2: cross cp_op_fmin, cp_result_o_infinite_p, cp_operand_a_snan_m, cp_operand_b_infinite_p;
		cr_fmin_62_1: cross cp_op_fmin, cp_result_o_infinite_m, cp_operand_a_snan_p, cp_operand_b_infinite_m;
		cr_fmin_62_2: cross cp_op_fmin, cp_result_o_infinite_m, cp_operand_a_snan_m, cp_operand_b_infinite_m;
		cr_fmin_63_1: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_qnan_p;
		cr_fmin_63_2: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_qnan_m;
		cr_fmin_63_3: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_qnan_p;
		cr_fmin_63_4: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_qnan_m;
		cr_fmin_64_1: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_snan_p;
		cr_fmin_64_2: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_snan_m;
		cr_fmin_64_3: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_snan_p;
		cr_fmin_64_4: cross cp_op_fmin, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_snan_m;
		
		cr_fmax_01: cross cp_op_fmax, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_normal_p;
		cr_fmax_02: cross cp_op_fmax, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_normal_m;
		cr_fmax_03: cross cp_op_fmax, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_zero_p;
		cr_fmax_04: cross cp_op_fmax, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_zero_m;
		cr_fmax_05: cross cp_op_fmax, cp_result_o_infinite_p, cp_operand_a_normal_p, cp_operand_b_infinite_p;
		cr_fmax_06: cross cp_op_fmax, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_infinite_m;
		cr_fmax_07_1: cross cp_op_fmax, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_qnan_p;
		cr_fmax_07_2: cross cp_op_fmax, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_qnan_m;
		cr_fmax_08_1: cross cp_op_fmax, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_snan_p;
		cr_fmax_08_2: cross cp_op_fmax, cp_result_o_normal_p, cp_operand_a_normal_p, cp_operand_b_snan_m;
		cr_fmax_09: cross cp_op_fmax, cp_result_o_normal_p, cp_operand_a_normal_m, cp_operand_b_normal_p;
		cr_fmax_10: cross cp_op_fmax, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_normal_m;
		cr_fmax_11: cross cp_op_fmax, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_zero_p;
		cr_fmax_12: cross cp_op_fmax, cp_result_o_zero_m, cp_operand_a_normal_m, cp_operand_b_zero_m;
		cr_fmax_13: cross cp_op_fmax, cp_result_o_infinite_p, cp_operand_a_normal_m, cp_operand_b_infinite_p;
		cr_fmax_14: cross cp_op_fmax, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_infinite_m;
		cr_fmax_15_1: cross cp_op_fmax, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_qnan_p;
		cr_fmax_15_2: cross cp_op_fmax, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_qnan_m;
		cr_fmax_16_1: cross cp_op_fmax, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_snan_p;
		cr_fmax_16_2: cross cp_op_fmax, cp_result_o_normal_m, cp_operand_a_normal_m, cp_operand_b_snan_m;
		cr_fmax_17: cross cp_op_fmax, cp_result_o_normal_p, cp_operand_a_zero_p, cp_operand_b_normal_p;
		cr_fmax_18: cross cp_op_fmax, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_normal_m;
		cr_fmax_19: cross cp_op_fmax, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_zero_p;
		cr_fmax_20: cross cp_op_fmax, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_zero_m;
		cr_fmax_21: cross cp_op_fmax, cp_result_o_infinite_p, cp_operand_a_zero_p, cp_operand_b_infinite_p;
		cr_fmax_22: cross cp_op_fmax, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_infinite_m;
		cr_fmax_23_1: cross cp_op_fmax, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_qnan_p;
		cr_fmax_23_2: cross cp_op_fmax, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_qnan_m;
		cr_fmax_24_1: cross cp_op_fmax, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_snan_p;
		cr_fmax_24_2: cross cp_op_fmax, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_snan_m;
		cr_fmax_25: cross cp_op_fmax, cp_result_o_normal_p, cp_operand_a_zero_m, cp_operand_b_normal_p;
		cr_fmax_26: cross cp_op_fmax, cp_result_o_zero_m, cp_operand_a_zero_m, cp_operand_b_normal_m;
		cr_fmax_27: cross cp_op_fmax, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_zero_p;
		cr_fmax_28: cross cp_op_fmax, cp_result_o_zero_m, cp_operand_a_zero_m, cp_operand_b_zero_m;
		cr_fmax_29: cross cp_op_fmax, cp_result_o_infinite_p, cp_operand_a_zero_m, cp_operand_b_infinite_p;
		cr_fmax_30: cross cp_op_fmax, cp_result_o_zero_m, cp_operand_a_zero_m, cp_operand_b_infinite_m;
		cr_fmax_31_1: cross cp_op_fmax, cp_result_o_zero_m, cp_operand_a_zero_m, cp_operand_b_qnan_p;
		cr_fmax_31_2: cross cp_op_fmax, cp_result_o_zero_m, cp_operand_a_zero_m, cp_operand_b_qnan_m;
		cr_fmax_32_1: cross cp_op_fmax, cp_result_o_zero_m, cp_operand_a_zero_m, cp_operand_b_snan_p;
		cr_fmax_32_2: cross cp_op_fmax, cp_result_o_zero_m, cp_operand_a_zero_m, cp_operand_b_snan_m;
		cr_fmax_33: cross cp_op_fmax, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_normal_p;
		cr_fmax_34: cross cp_op_fmax, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_normal_m;
		cr_fmax_35: cross cp_op_fmax, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_zero_p;
		cr_fmax_36: cross cp_op_fmax, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_zero_m;
		cr_fmax_37: cross cp_op_fmax, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_infinite_p;
		cr_fmax_38: cross cp_op_fmax, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_infinite_m;
		cr_fmax_39_1: cross cp_op_fmax, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_qnan_p;
		cr_fmax_39_2: cross cp_op_fmax, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_qnan_m;
		cr_fmax_40_1: cross cp_op_fmax, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_snan_p;
		cr_fmax_40_2: cross cp_op_fmax, cp_result_o_infinite_p, cp_operand_a_infinite_p, cp_operand_b_snan_m;
		cr_fmax_41: cross cp_op_fmax, cp_result_o_normal_p, cp_operand_a_infinite_m, cp_operand_b_normal_p;
		cr_fmax_42: cross cp_op_fmax, cp_result_o_normal_m, cp_operand_a_infinite_m, cp_operand_b_normal_m;
		cr_fmax_43: cross cp_op_fmax, cp_result_o_zero_p, cp_operand_a_infinite_m, cp_operand_b_zero_p;
		cr_fmax_44: cross cp_op_fmax, cp_result_o_zero_m, cp_operand_a_infinite_m, cp_operand_b_zero_m;
		cr_fmax_45: cross cp_op_fmax, cp_result_o_infinite_p, cp_operand_a_infinite_m, cp_operand_b_infinite_p;
		cr_fmax_46: cross cp_op_fmax, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_infinite_m;
		cr_fmax_47_1: cross cp_op_fmax, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_qnan_p;
		cr_fmax_47_2: cross cp_op_fmax, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_qnan_m;
		cr_fmax_48_1: cross cp_op_fmax, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_snan_p;
		cr_fmax_48_2: cross cp_op_fmax, cp_result_o_infinite_m, cp_operand_a_infinite_m, cp_operand_b_snan_m;
		cr_fmax_49_1: cross cp_op_fmax, cp_result_o_normal_p, cp_operand_a_qnan_p, cp_operand_b_normal_p;
		cr_fmax_49_2: cross cp_op_fmax, cp_result_o_normal_p, cp_operand_a_qnan_m, cp_operand_b_normal_p;
		cr_fmax_50_1: cross cp_op_fmax, cp_result_o_normal_m, cp_operand_a_qnan_p, cp_operand_b_normal_m;
		cr_fmax_50_2: cross cp_op_fmax, cp_result_o_normal_m, cp_operand_a_qnan_m, cp_operand_b_normal_m;
		cr_fmax_51_1: cross cp_op_fmax, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_zero_p;
		cr_fmax_51_2: cross cp_op_fmax, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_zero_p;
		cr_fmax_52_1: cross cp_op_fmax, cp_result_o_zero_m, cp_operand_a_qnan_p, cp_operand_b_zero_m;
		cr_fmax_52_2: cross cp_op_fmax, cp_result_o_zero_m, cp_operand_a_qnan_m, cp_operand_b_zero_m;
		cr_fmax_53_1: cross cp_op_fmax, cp_result_o_infinite_p, cp_operand_a_qnan_p, cp_operand_b_infinite_p;
		cr_fmax_53_2: cross cp_op_fmax, cp_result_o_infinite_p, cp_operand_a_qnan_m, cp_operand_b_infinite_p;
		cr_fmax_54_1: cross cp_op_fmax, cp_result_o_infinite_m, cp_operand_a_qnan_p, cp_operand_b_infinite_m;
		cr_fmax_54_2: cross cp_op_fmax, cp_result_o_infinite_m, cp_operand_a_qnan_m, cp_operand_b_infinite_m;
		cr_fmax_55_1: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_qnan_p;
		cr_fmax_55_2: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_qnan_p;
		cr_fmax_55_3: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_qnan_m;
		cr_fmax_55_4: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_qnan_m;
		cr_fmax_56_1: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_snan_p;
		cr_fmax_56_2: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_snan_p;
		cr_fmax_56_3: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_qnan_p, cp_operand_b_snan_m;
		cr_fmax_56_4: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_qnan_m, cp_operand_b_snan_m;
		cr_fmax_57_1: cross cp_op_fmax, cp_result_o_normal_p, cp_operand_a_snan_p, cp_operand_b_normal_p;
		cr_fmax_57_2: cross cp_op_fmax, cp_result_o_normal_p, cp_operand_a_snan_m, cp_operand_b_normal_p;
		cr_fmax_58_1: cross cp_op_fmax, cp_result_o_normal_m, cp_operand_a_snan_p, cp_operand_b_normal_m;
		cr_fmax_58_2: cross cp_op_fmax, cp_result_o_normal_m, cp_operand_a_snan_m, cp_operand_b_normal_m;
		cr_fmax_59_1: cross cp_op_fmax, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_zero_p;
		cr_fmax_59_2: cross cp_op_fmax, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_zero_p;
		cr_fmax_60_1: cross cp_op_fmax, cp_result_o_zero_m, cp_operand_a_snan_p, cp_operand_b_zero_m;
		cr_fmax_60_2: cross cp_op_fmax, cp_result_o_zero_m, cp_operand_a_snan_m, cp_operand_b_zero_m;
		cr_fmax_61_1: cross cp_op_fmax, cp_result_o_infinite_p, cp_operand_a_snan_p, cp_operand_b_infinite_p;
		cr_fmax_61_2: cross cp_op_fmax, cp_result_o_infinite_p, cp_operand_a_snan_m, cp_operand_b_infinite_p;
		cr_fmax_62_1: cross cp_op_fmax, cp_result_o_infinite_m, cp_operand_a_snan_p, cp_operand_b_infinite_m;
		cr_fmax_62_2: cross cp_op_fmax, cp_result_o_infinite_m, cp_operand_a_snan_m, cp_operand_b_infinite_m;
		cr_fmax_63_1: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_qnan_p;
		cr_fmax_63_2: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_qnan_m;
		cr_fmax_63_3: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_qnan_p;
		cr_fmax_63_4: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_qnan_m;
		cr_fmax_64_1: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_snan_p;
		cr_fmax_64_2: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_snan_p, cp_operand_b_snan_m;
		cr_fmax_64_3: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_snan_p;
		cr_fmax_64_4: cross cp_op_fmax, cp_result_o_cnan, cp_operand_a_snan_m, cp_operand_b_snan_m;
		
		cr_feq_01: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_normal_p;
		cr_feq_02: cross cp_op_feq, cp_result_o_one, cp_operand_a_normal_p, cp_operand_b_normal_p;
		cr_feq_03: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_normal_m;
		cr_feq_04: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_zero_p;
		cr_feq_05: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_zero_m;
		cr_feq_06: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_infinite_p;
		cr_feq_07: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_infinite_m;
		cr_feq_08_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_qnan_p;
		cr_feq_08_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_qnan_m;
		cr_feq_09_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_snan_p;
		cr_feq_09_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_snan_m;
		cr_feq_10: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_normal_p;
		cr_feq_11: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_normal_m;
		cr_feq_12: cross cp_op_feq, cp_result_o_one, cp_operand_a_normal_m, cp_operand_b_normal_m;
		cr_feq_13: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_zero_p;
		cr_feq_14: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_zero_m;
		cr_feq_15: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_infinite_p;
		cr_feq_16: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_infinite_m;
		cr_feq_17_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_qnan_p;
		cr_feq_17_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_qnan_m;
		cr_feq_18_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_snan_p;
		cr_feq_18_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_snan_m;
		cr_feq_19: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_normal_p;
		cr_feq_20: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_normal_m;
		cr_feq_21: cross cp_op_feq, cp_result_o_one, cp_operand_a_zero_p, cp_operand_b_zero_p;
		cr_feq_22: cross cp_op_feq, cp_result_o_one, cp_operand_a_zero_p, cp_operand_b_zero_m;
		cr_feq_23: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_infinite_p;
		cr_feq_24: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_infinite_m;
		cr_feq_25_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_qnan_p;
		cr_feq_25_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_qnan_m;
		cr_feq_26_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_snan_p;
		cr_feq_26_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_snan_m;
		cr_feq_27: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_normal_p;
		cr_feq_28: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_normal_m;
		cr_feq_29: cross cp_op_feq, cp_result_o_one, cp_operand_a_zero_m, cp_operand_b_zero_p;
		cr_feq_30: cross cp_op_feq, cp_result_o_one, cp_operand_a_zero_m, cp_operand_b_zero_m;
		cr_feq_31: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_infinite_p;
		cr_feq_32: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_infinite_m;
		cr_feq_33_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_qnan_p;
		cr_feq_33_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_qnan_m;
		cr_feq_34_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_snan_p;
		cr_feq_34_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_snan_m;
		cr_feq_35: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_normal_p;
		cr_feq_36: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_normal_m;
		cr_feq_37: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_zero_p;
		cr_feq_38: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_zero_m;
		cr_feq_39: cross cp_op_feq, cp_result_o_one, cp_operand_a_infinite_p, cp_operand_b_infinite_p;
		cr_feq_40: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_infinite_m;
		cr_feq_41_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_qnan_p;
		cr_feq_41_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_qnan_m;
		cr_feq_42_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_snan_p;
		cr_feq_42_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_snan_m;
		cr_feq_43: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_infinite_m, cp_operand_b_normal_p;
		cr_feq_44: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_infinite_m, cp_operand_b_normal_m;
		cr_feq_45: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_infinite_m, cp_operand_b_zero_p;
		cr_feq_46: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_infinite_m, cp_operand_b_zero_m;
		cr_feq_47: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_infinite_m, cp_operand_b_infinite_p;
		cr_feq_48: cross cp_op_feq, cp_result_o_one, cp_operand_a_infinite_m, cp_operand_b_infinite_m;
		cr_feq_49_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_infinite_m, cp_operand_b_qnan_p;
		cr_feq_49_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_infinite_m, cp_operand_b_qnan_m;
		cr_feq_50_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_infinite_m, cp_operand_b_snan_p;
		cr_feq_50_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_infinite_m, cp_operand_b_snan_m;
		cr_feq_51_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_normal_p;
		cr_feq_51_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_normal_p;
		cr_feq_52_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_normal_m;
		cr_feq_52_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_normal_m;
		cr_feq_53_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_zero_p;
		cr_feq_53_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_zero_p;
		cr_feq_54_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_zero_m;
		cr_feq_54_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_zero_m;
		cr_feq_55_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_infinite_p;
		cr_feq_55_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_infinite_p;
		cr_feq_56_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_infinite_m;
		cr_feq_56_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_infinite_m;
		cr_feq_57_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_qnan_p;
		cr_feq_57_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_qnan_p;
		cr_feq_57_3: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_qnan_m;
		cr_feq_57_4: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_qnan_m;
		cr_feq_58_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_snan_p;
		cr_feq_58_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_snan_p;
		cr_feq_58_3: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_snan_m;
		cr_feq_58_4: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_snan_m;
		cr_feq_59_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_normal_p;
		cr_feq_59_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_normal_p;
		cr_feq_60_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_normal_m;
		cr_feq_60_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_normal_m;
		cr_feq_61_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_zero_p;
		cr_feq_61_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_zero_p;
		cr_feq_62_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_zero_m;
		cr_feq_62_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_zero_m;
		cr_feq_63_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_infinite_p;
		cr_feq_63_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_infinite_p;
		cr_feq_64_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_infinite_m;
		cr_feq_64_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_infinite_m;
		cr_feq_65_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_qnan_p;
		cr_feq_65_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_qnan_m;
		cr_feq_65_3: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_qnan_p;
		cr_feq_65_4: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_qnan_m;
		cr_feq_66_1: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_snan_p;
		cr_feq_66_2: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_snan_m;
		cr_feq_66_3: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_snan_p;
		cr_feq_66_4: cross cp_op_feq, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_snan_m;
		
		cr_flt_01: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_normal_p;
		cr_flt_02: cross cp_op_flt, cp_result_o_one, cp_operand_a_normal_p, cp_operand_b_normal_p;
		cr_flt_03: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_normal_m;
		cr_flt_04: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_zero_p;
		cr_flt_05: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_zero_m;
		cr_flt_06: cross cp_op_flt, cp_result_o_one, cp_operand_a_normal_p, cp_operand_b_infinite_p;
		cr_flt_07: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_infinite_m;
		cr_flt_08_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_qnan_p;
		cr_flt_08_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_qnan_m;
		cr_flt_09_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_snan_p;
		cr_flt_09_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_snan_m;
		cr_flt_10: cross cp_op_flt, cp_result_o_one, cp_operand_a_normal_m, cp_operand_b_normal_p;
		cr_flt_11: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_normal_m;
		cr_flt_12: cross cp_op_flt, cp_result_o_one, cp_operand_a_normal_m, cp_operand_b_normal_m;
		cr_flt_13: cross cp_op_flt, cp_result_o_one, cp_operand_a_normal_m, cp_operand_b_zero_p;
		cr_flt_14: cross cp_op_flt, cp_result_o_one, cp_operand_a_normal_m, cp_operand_b_zero_m;
		cr_flt_15: cross cp_op_flt, cp_result_o_one, cp_operand_a_normal_m, cp_operand_b_infinite_p;
		cr_flt_16: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_infinite_m;
		cr_flt_17_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_qnan_p;
		cr_flt_17_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_qnan_m;
		cr_flt_18_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_snan_p;
		cr_flt_18_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_snan_m;
		cr_flt_19: cross cp_op_flt, cp_result_o_one, cp_operand_a_zero_p, cp_operand_b_normal_p;
		cr_flt_20: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_normal_m;
		cr_flt_21: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_zero_p;
		cr_flt_22: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_zero_m;
		cr_flt_23: cross cp_op_flt, cp_result_o_one, cp_operand_a_zero_p, cp_operand_b_infinite_p;
		cr_flt_24: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_infinite_m;
		cr_flt_25_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_qnan_p;
		cr_flt_25_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_qnan_m;
		cr_flt_26_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_snan_p;
		cr_flt_26_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_snan_m;
		cr_flt_27: cross cp_op_flt, cp_result_o_one, cp_operand_a_zero_m, cp_operand_b_normal_p;
		cr_flt_28: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_normal_m;
		cr_flt_29: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_zero_p;
		cr_flt_30: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_zero_m;
		cr_flt_31: cross cp_op_flt, cp_result_o_one, cp_operand_a_zero_m, cp_operand_b_infinite_p;
		cr_flt_32: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_infinite_m;
		cr_flt_33_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_qnan_p;
		cr_flt_33_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_qnan_m;
		cr_flt_34_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_snan_p;
		cr_flt_34_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_snan_m;
		cr_flt_35: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_normal_p;
		cr_flt_36: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_normal_m;
		cr_flt_37: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_zero_p;
		cr_flt_38: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_zero_m;
		cr_flt_39: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_infinite_p;
		cr_flt_40: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_infinite_m;
		cr_flt_41_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_qnan_p;
		cr_flt_41_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_qnan_m;
		cr_flt_42_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_snan_p;
		cr_flt_42_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_snan_m;
		cr_flt_43: cross cp_op_flt, cp_result_o_one, cp_operand_a_infinite_m, cp_operand_b_normal_p;
		cr_flt_44: cross cp_op_flt, cp_result_o_one, cp_operand_a_infinite_m, cp_operand_b_normal_m;
		cr_flt_45: cross cp_op_flt, cp_result_o_one, cp_operand_a_infinite_m, cp_operand_b_zero_p;
		cr_flt_46: cross cp_op_flt, cp_result_o_one, cp_operand_a_infinite_m, cp_operand_b_zero_m;
		cr_flt_47: cross cp_op_flt, cp_result_o_one, cp_operand_a_infinite_m, cp_operand_b_infinite_p;
		cr_flt_48: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_infinite_m, cp_operand_b_infinite_m;
		cr_flt_49_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_infinite_m, cp_operand_b_qnan_p;
		cr_flt_49_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_infinite_m, cp_operand_b_qnan_m;
		cr_flt_50_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_infinite_m, cp_operand_b_snan_p;
		cr_flt_50_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_infinite_m, cp_operand_b_snan_m;
		cr_flt_51_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_normal_p;
		cr_flt_51_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_normal_p;
		cr_flt_52_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_normal_m;
		cr_flt_52_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_normal_m;
		cr_flt_53_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_zero_p;
		cr_flt_53_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_zero_p;
		cr_flt_54_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_zero_m;
		cr_flt_54_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_zero_m;
		cr_flt_55_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_infinite_p;
		cr_flt_55_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_infinite_p;
		cr_flt_56_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_infinite_m;
		cr_flt_56_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_infinite_m;
		cr_flt_57_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_qnan_p;
		cr_flt_57_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_qnan_p;
		cr_flt_57_3: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_qnan_m;
		cr_flt_57_4: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_qnan_m;
		cr_flt_58_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_snan_p;
		cr_flt_58_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_snan_p;
		cr_flt_58_3: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_snan_m;
		cr_flt_58_4: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_snan_m;
		cr_flt_59_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_normal_p;
		cr_flt_59_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_normal_p;
		cr_flt_60_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_normal_m;
		cr_flt_60_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_normal_m;
		cr_flt_61_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_zero_p;
		cr_flt_61_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_zero_p;
		cr_flt_62_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_zero_m;
		cr_flt_62_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_zero_m;
		cr_flt_63_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_infinite_p;
		cr_flt_63_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_infinite_p;
		cr_flt_64_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_infinite_m;
		cr_flt_64_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_infinite_m;
		cr_flt_65_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_qnan_p;
		cr_flt_65_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_qnan_m;
		cr_flt_65_3: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_qnan_p;
		cr_flt_65_4: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_qnan_m;
		cr_flt_66_1: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_snan_p;
		cr_flt_66_2: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_snan_m;
		cr_flt_66_3: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_snan_p;
		cr_flt_66_4: cross cp_op_flt, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_snan_m;
		
		cr_fle_01: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_normal_p;
		cr_fle_02: cross cp_op_fle, cp_result_o_one, cp_operand_a_normal_p, cp_operand_b_normal_p;
		cr_fle_03: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_normal_m;
		cr_fle_04: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_zero_p;
		cr_fle_05: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_zero_m;
		cr_fle_06: cross cp_op_fle, cp_result_o_one, cp_operand_a_normal_p, cp_operand_b_infinite_p;
		cr_fle_07: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_infinite_m;
		cr_fle_08_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_qnan_p;
		cr_fle_08_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_qnan_m;
		cr_fle_09_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_snan_p;
		cr_fle_09_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_snan_m;
		cr_fle_10: cross cp_op_fle, cp_result_o_one, cp_operand_a_normal_m, cp_operand_b_normal_p;
		cr_fle_11: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_normal_m;
		cr_fle_12: cross cp_op_fle, cp_result_o_one, cp_operand_a_normal_m, cp_operand_b_normal_m;
		cr_fle_13: cross cp_op_fle, cp_result_o_one, cp_operand_a_normal_m, cp_operand_b_zero_p;
		cr_fle_14: cross cp_op_fle, cp_result_o_one, cp_operand_a_normal_m, cp_operand_b_zero_m;
		cr_fle_15: cross cp_op_fle, cp_result_o_one, cp_operand_a_normal_m, cp_operand_b_infinite_p;
		cr_fle_16: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_infinite_m;
		cr_fle_17_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_qnan_p;
		cr_fle_17_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_qnan_m;
		cr_fle_18_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_snan_p;
		cr_fle_18_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_snan_m;
		cr_fle_19: cross cp_op_fle, cp_result_o_one, cp_operand_a_zero_p, cp_operand_b_normal_p;
		cr_fle_20: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_normal_m;
		cr_fle_21: cross cp_op_fle, cp_result_o_one, cp_operand_a_zero_p, cp_operand_b_zero_p;
		cr_fle_22: cross cp_op_fle, cp_result_o_one, cp_operand_a_zero_p, cp_operand_b_zero_m;
		cr_fle_23: cross cp_op_fle, cp_result_o_one, cp_operand_a_zero_p, cp_operand_b_infinite_p;
		cr_fle_24: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_infinite_m;
		cr_fle_25_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_qnan_p;
		cr_fle_25_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_qnan_m;
		cr_fle_26_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_snan_p;
		cr_fle_26_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_snan_m;
		cr_fle_27: cross cp_op_fle, cp_result_o_one, cp_operand_a_zero_m, cp_operand_b_normal_p;
		cr_fle_28: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_normal_m;
		cr_fle_29: cross cp_op_fle, cp_result_o_one, cp_operand_a_zero_m, cp_operand_b_zero_p;
		cr_fle_30: cross cp_op_fle, cp_result_o_one, cp_operand_a_zero_m, cp_operand_b_zero_m;
		cr_fle_31: cross cp_op_fle, cp_result_o_one, cp_operand_a_zero_m, cp_operand_b_infinite_p;
		cr_fle_32: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_infinite_m;
		cr_fle_33_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_qnan_p;
		cr_fle_33_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_qnan_m;
		cr_fle_34_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_snan_p;
		cr_fle_34_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_snan_m;
		cr_fle_35: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_normal_p;
		cr_fle_36: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_normal_m;
		cr_fle_37: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_zero_p;
		cr_fle_38: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_zero_m;
		cr_fle_39: cross cp_op_fle, cp_result_o_one, cp_operand_a_infinite_p, cp_operand_b_infinite_p;
		cr_fle_40: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_infinite_m;
		cr_fle_41_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_qnan_p;
		cr_fle_41_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_qnan_m;
		cr_fle_42_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_snan_p;
		cr_fle_42_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_snan_m;
		cr_fle_43: cross cp_op_fle, cp_result_o_one, cp_operand_a_infinite_m, cp_operand_b_normal_p;
		cr_fle_44: cross cp_op_fle, cp_result_o_one, cp_operand_a_infinite_m, cp_operand_b_normal_m;
		cr_fle_45: cross cp_op_fle, cp_result_o_one, cp_operand_a_infinite_m, cp_operand_b_zero_p;
		cr_fle_46: cross cp_op_fle, cp_result_o_one, cp_operand_a_infinite_m, cp_operand_b_zero_m;
		cr_fle_47: cross cp_op_fle, cp_result_o_one, cp_operand_a_infinite_m, cp_operand_b_infinite_p;
		cr_fle_48: cross cp_op_fle, cp_result_o_one, cp_operand_a_infinite_m, cp_operand_b_infinite_m;
		cr_fle_49_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_infinite_m, cp_operand_b_qnan_p;
		cr_fle_49_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_infinite_m, cp_operand_b_qnan_m;
		cr_fle_50_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_infinite_m, cp_operand_b_snan_p;
		cr_fle_50_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_infinite_m, cp_operand_b_snan_m;
		cr_fle_51_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_normal_p;
		cr_fle_51_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_normal_p;
		cr_fle_52_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_normal_m;
		cr_fle_52_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_normal_m;
		cr_fle_53_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_zero_p;
		cr_fle_53_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_zero_p;
		cr_fle_54_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_zero_m;
		cr_fle_54_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_zero_m;
		cr_fle_55_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_infinite_p;
		cr_fle_55_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_infinite_p;
		cr_fle_56_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_infinite_m;
		cr_fle_56_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_infinite_m;
		cr_fle_57_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_qnan_p;
		cr_fle_57_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_qnan_p;
		cr_fle_57_3: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_qnan_m;
		cr_fle_57_4: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_qnan_m;
		cr_fle_58_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_snan_p;
		cr_fle_58_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_snan_p;
		cr_fle_58_3: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_qnan_p, cp_operand_b_snan_m;
		cr_fle_58_4: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_qnan_m, cp_operand_b_snan_m;
		cr_fle_59_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_normal_p;
		cr_fle_59_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_normal_p;
		cr_fle_60_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_normal_m;
		cr_fle_60_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_normal_m;
		cr_fle_61_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_zero_p;
		cr_fle_61_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_zero_p;
		cr_fle_62_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_zero_m;
		cr_fle_62_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_zero_m;
		cr_fle_63_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_infinite_p;
		cr_fle_63_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_infinite_p;
		cr_fle_64_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_infinite_m;
		cr_fle_64_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_infinite_m;
		cr_fle_65_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_qnan_p;
		cr_fle_65_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_qnan_m;
		cr_fle_65_3: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_qnan_p;
		cr_fle_65_4: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_qnan_m;
		cr_fle_66_1: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_snan_p;
		cr_fle_66_2: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_snan_p, cp_operand_b_snan_m;
		cr_fle_66_3: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_snan_p;
		cr_fle_66_4: cross cp_op_fle, cp_result_o_zero_p, cp_operand_a_snan_m, cp_operand_b_snan_m;
		cr_fne_01: cross cp_op_fne, cp_result_o_zero_p, cp_operand_a_normal_p, cp_operand_b_normal_p;
		cr_fne_02: cross cp_op_fne, cp_result_o_one, cp_operand_a_normal_p, cp_operand_b_normal_p;
		cr_fne_03: cross cp_op_fne, cp_result_o_one, cp_operand_a_normal_p, cp_operand_b_normal_m;
		cr_fne_04: cross cp_op_fne, cp_result_o_one, cp_operand_a_normal_p, cp_operand_b_zero_p;
		cr_fne_05: cross cp_op_fne, cp_result_o_one, cp_operand_a_normal_p, cp_operand_b_zero_m;
		cr_fne_06: cross cp_op_fne, cp_result_o_one, cp_operand_a_normal_p, cp_operand_b_infinite_p;
		cr_fne_07: cross cp_op_fne, cp_result_o_one, cp_operand_a_normal_p, cp_operand_b_infinite_m;
		cr_fne_08_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_normal_p, cp_operand_b_qnan_p;
		cr_fne_08_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_normal_p, cp_operand_b_qnan_m;
		cr_fne_09_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_normal_p, cp_operand_b_snan_p;
		cr_fne_09_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_normal_p, cp_operand_b_snan_m;
		cr_fne_10: cross cp_op_fne, cp_result_o_one, cp_operand_a_normal_m, cp_operand_b_normal_p;
		cr_fne_11: cross cp_op_fne, cp_result_o_zero_p, cp_operand_a_normal_m, cp_operand_b_normal_m;
		cr_fne_12: cross cp_op_fne, cp_result_o_one, cp_operand_a_normal_m, cp_operand_b_normal_m;
		cr_fne_13: cross cp_op_fne, cp_result_o_one, cp_operand_a_normal_m, cp_operand_b_zero_p;
		cr_fne_14: cross cp_op_fne, cp_result_o_one, cp_operand_a_normal_m, cp_operand_b_zero_m;
		cr_fne_15: cross cp_op_fne, cp_result_o_one, cp_operand_a_normal_m, cp_operand_b_infinite_p;
		cr_fne_16: cross cp_op_fne, cp_result_o_one, cp_operand_a_normal_m, cp_operand_b_infinite_m;
		cr_fne_17_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_normal_m, cp_operand_b_qnan_p;
		cr_fne_17_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_normal_m, cp_operand_b_qnan_m;
		cr_fne_18_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_normal_m, cp_operand_b_snan_p;
		cr_fne_18_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_normal_m, cp_operand_b_snan_m;
		cr_fne_19: cross cp_op_fne, cp_result_o_one, cp_operand_a_zero_p, cp_operand_b_normal_p;
		cr_fne_20: cross cp_op_fne, cp_result_o_one, cp_operand_a_zero_p, cp_operand_b_normal_m;
		cr_fne_21: cross cp_op_fne, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_zero_p;
		cr_fne_22: cross cp_op_fne, cp_result_o_zero_p, cp_operand_a_zero_p, cp_operand_b_zero_m;
		cr_fne_23: cross cp_op_fne, cp_result_o_one, cp_operand_a_zero_p, cp_operand_b_infinite_p;
		cr_fne_24: cross cp_op_fne, cp_result_o_one, cp_operand_a_zero_p, cp_operand_b_infinite_m;
		cr_fne_25_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_zero_p, cp_operand_b_qnan_p;
		cr_fne_25_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_zero_p, cp_operand_b_qnan_m;
		cr_fne_26_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_zero_p, cp_operand_b_snan_p;
		cr_fne_26_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_zero_p, cp_operand_b_snan_m;
		cr_fne_27: cross cp_op_fne, cp_result_o_one, cp_operand_a_zero_m, cp_operand_b_normal_p;
		cr_fne_28: cross cp_op_fne, cp_result_o_one, cp_operand_a_zero_m, cp_operand_b_normal_m;
		cr_fne_29: cross cp_op_fne, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_zero_p;
		cr_fne_30: cross cp_op_fne, cp_result_o_zero_p, cp_operand_a_zero_m, cp_operand_b_zero_m;
		cr_fne_31: cross cp_op_fne, cp_result_o_one, cp_operand_a_zero_m, cp_operand_b_infinite_p;
		cr_fne_32: cross cp_op_fne, cp_result_o_one, cp_operand_a_zero_m, cp_operand_b_infinite_m;
		cr_fne_33_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_zero_m, cp_operand_b_qnan_p;
		cr_fne_33_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_zero_m, cp_operand_b_qnan_m;
		cr_fne_34_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_zero_m, cp_operand_b_snan_p;
		cr_fne_34_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_zero_m, cp_operand_b_snan_m;
		cr_fne_35: cross cp_op_fne, cp_result_o_one, cp_operand_a_infinite_p, cp_operand_b_normal_p;
		cr_fne_36: cross cp_op_fne, cp_result_o_one, cp_operand_a_infinite_p, cp_operand_b_normal_m;
		cr_fne_37: cross cp_op_fne, cp_result_o_one, cp_operand_a_infinite_p, cp_operand_b_zero_p;
		cr_fne_38: cross cp_op_fne, cp_result_o_one, cp_operand_a_infinite_p, cp_operand_b_zero_m;
		cr_fne_39: cross cp_op_fne, cp_result_o_zero_p, cp_operand_a_infinite_p, cp_operand_b_infinite_p;
		cr_fne_40: cross cp_op_fne, cp_result_o_one, cp_operand_a_infinite_p, cp_operand_b_infinite_m;
		cr_fne_41_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_infinite_p, cp_operand_b_qnan_p;
		cr_fne_41_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_infinite_p, cp_operand_b_qnan_m;
		cr_fne_42_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_infinite_p, cp_operand_b_snan_p;
		cr_fne_42_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_infinite_p, cp_operand_b_snan_m;
		cr_fne_43: cross cp_op_fne, cp_result_o_one, cp_operand_a_infinite_m, cp_operand_b_normal_p;
		cr_fne_44: cross cp_op_fne, cp_result_o_one, cp_operand_a_infinite_m, cp_operand_b_normal_m;
		cr_fne_45: cross cp_op_fne, cp_result_o_one, cp_operand_a_infinite_m, cp_operand_b_zero_p;
		cr_fne_46: cross cp_op_fne, cp_result_o_one, cp_operand_a_infinite_m, cp_operand_b_zero_m;
		cr_fne_47: cross cp_op_fne, cp_result_o_one, cp_operand_a_infinite_m, cp_operand_b_infinite_p;
		cr_fne_48: cross cp_op_fne, cp_result_o_zero_p, cp_operand_a_infinite_m, cp_operand_b_infinite_m;
		cr_fne_49_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_infinite_m, cp_operand_b_qnan_p;
		cr_fne_49_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_infinite_m, cp_operand_b_qnan_m;
		cr_fne_50_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_infinite_m, cp_operand_b_snan_p;
		cr_fne_50_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_infinite_m, cp_operand_b_snan_m;
		cr_fne_51_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_qnan_p, cp_operand_b_normal_p;
		cr_fne_51_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_qnan_m, cp_operand_b_normal_p;
		cr_fne_52_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_qnan_p, cp_operand_b_normal_m;
		cr_fne_52_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_qnan_m, cp_operand_b_normal_m;
		cr_fne_53_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_qnan_p, cp_operand_b_zero_p;
		cr_fne_53_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_qnan_m, cp_operand_b_zero_p;
		cr_fne_54_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_qnan_p, cp_operand_b_zero_m;
		cr_fne_54_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_qnan_m, cp_operand_b_zero_m;
		cr_fne_55_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_qnan_p, cp_operand_b_infinite_p;
		cr_fne_55_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_qnan_m, cp_operand_b_infinite_p;
		cr_fne_56_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_qnan_p, cp_operand_b_infinite_m;
		cr_fne_56_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_qnan_m, cp_operand_b_infinite_m;
		cr_fne_57_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_qnan_p, cp_operand_b_qnan_p;
		cr_fne_57_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_qnan_m, cp_operand_b_qnan_p;
		cr_fne_57_3: cross cp_op_fne, cp_result_o_one, cp_operand_a_qnan_p, cp_operand_b_qnan_m;
		cr_fne_57_4: cross cp_op_fne, cp_result_o_one, cp_operand_a_qnan_m, cp_operand_b_qnan_m;
		cr_fne_58_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_qnan_p, cp_operand_b_snan_p;
		cr_fne_58_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_qnan_m, cp_operand_b_snan_p;
		cr_fne_58_3: cross cp_op_fne, cp_result_o_one, cp_operand_a_qnan_p, cp_operand_b_snan_m;
		cr_fne_58_4: cross cp_op_fne, cp_result_o_one, cp_operand_a_qnan_m, cp_operand_b_snan_m;
		cr_fne_59_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_snan_p, cp_operand_b_normal_p;
		cr_fne_59_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_snan_m, cp_operand_b_normal_p;
		cr_fne_60_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_snan_p, cp_operand_b_normal_m;
		cr_fne_60_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_snan_m, cp_operand_b_normal_m;
		cr_fne_61_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_snan_p, cp_operand_b_zero_p;
		cr_fne_61_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_snan_m, cp_operand_b_zero_p;
		cr_fne_62_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_snan_p, cp_operand_b_zero_m;
		cr_fne_62_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_snan_m, cp_operand_b_zero_m;
		cr_fne_63_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_snan_p, cp_operand_b_infinite_p;
		cr_fne_63_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_snan_m, cp_operand_b_infinite_p;
		cr_fne_64_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_snan_p, cp_operand_b_infinite_m;
		cr_fne_64_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_snan_m, cp_operand_b_infinite_m;
		cr_fne_65_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_snan_p, cp_operand_b_qnan_p;
		cr_fne_65_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_snan_p, cp_operand_b_qnan_m;
		cr_fne_65_3: cross cp_op_fne, cp_result_o_one, cp_operand_a_snan_m, cp_operand_b_qnan_p;
		cr_fne_65_4: cross cp_op_fne, cp_result_o_one, cp_operand_a_snan_m, cp_operand_b_qnan_m;
		cr_fne_66_1: cross cp_op_fne, cp_result_o_one, cp_operand_a_snan_p, cp_operand_b_snan_p;
		cr_fne_66_2: cross cp_op_fne, cp_result_o_one, cp_operand_a_snan_p, cp_operand_b_snan_m;
		cr_fne_66_3: cross cp_op_fne, cp_result_o_one, cp_operand_a_snan_m, cp_operand_b_snan_p;
		cr_fne_66_4: cross cp_op_fne, cp_result_o_one, cp_operand_a_snan_m, cp_operand_b_snan_m;
	endgroup : cg_Result_format_Cmp_Cvt

	covergroup cg_Pipeline_nonpipe_Coverage;
		cp_op: coverpoint op_i[7:6] {
						bins arith_spmath  = (`SEL_ARITH  => `SEL_SPMATH);
						bins arith_cmpcnv  = (`SEL_ARITH  => `SEL_CMPCNV);
						bins spmath_arith  = (`SEL_SPMATH => `SEL_ARITH);
						bins spmath_cmpcnv = (`SEL_SPMATH => `SEL_CMPCNV);
						bins cmpcnv_spmath = (`SEL_CMPCNV => `SEL_SPMATH);
						bins cmpcnv_arith  = (`SEL_CMPCNV => `SEL_ARITH);
					}
	endgroup : cg_Pipeline_nonpipe_Coverage

	covergroup cg_Input_combination_coverage;
		cp_op: coverpoint op_i {
						bins fadd = {fadd};
						bins fsub = {fsub};
						bins fmul = {fmul};
						bins fmadd = {fmadd};
						bins fmsub = {fmsub};
						bins fmnadd = {fmnadd};
						bins fmnsub = {fmnsub};
						bins fdiv = {fdiv};
						bins fsqrt = {fsqrt};
						bins fexp = {fexp};
						bins flog = {flog};
						
						bins fcvt_w_s  = {fcvt_w_s };
						bins fcvt_wu_s = {fcvt_wu_s};
						
						bins fmin = {fmin};
						bins fmax = {fmax};
						bins feq = {feq};
						bins flt = {flt};
						bins fle = {fle};
						bins fne = {fne};
					}
		cp_operand_a: coverpoint operand_a_i {
						bins subnormal_p = {`SN_FINITE_P};
						bins subnormal_m = {`SN_FINITE_M};
						bins no_finite_p = {`NO_FINITE_P};
						bins no_finite_m = {`NO_FINITE_M};
						bins zero_p = {`ZERO_P};
						bins zero_m = {`ZERO_M};
						bins infinite_p = {`INFINITE_P};
						bins infinite_m = {`INFINITE_M};
						bins qnan = {`QNAN_P, `QNAN_M};
						bins snan = {`SNAN_P, `SNAN_M};
					}						
		cp_operand_b: coverpoint operand_b_i {
						bins subnormal_p = {`SN_FINITE_P};
						bins subnormal_m = {`SN_FINITE_M};
						bins no_finite_p = {`NO_FINITE_P};
						bins no_finite_m = {`NO_FINITE_M};
						bins zero_p = {`ZERO_P};
						bins zero_m = {`ZERO_M};
						bins infinite_p = {`INFINITE_P};
						bins infinite_m = {`INFINITE_M};
						bins qnan = {`QNAN_P, `QNAN_M};
						bins snan = {`SNAN_P, `SNAN_M};
					}						
		cp_operand_c: coverpoint operand_c_i {
						bins subnormal_p = {`SN_FINITE_P};
						bins subnormal_m = {`SN_FINITE_M};
						bins no_finite_p = {`NO_FINITE_P};
						bins no_finite_m = {`NO_FINITE_M};
						bins zero_p = {`ZERO_P};
						bins zero_m = {`ZERO_M};
						bins infinite_p = {`INFINITE_P};
						bins infinite_m = {`INFINITE_M};
						bins qnan = {`QNAN_P, `QNAN_M};
						bins snan = {`SNAN_P, `SNAN_M};
					}						

		cs_op_operand: cross cp_op, cp_operand_a, cp_operand_b, cp_operand_c{
						bins arith_f_operand_ab  =  (binsof (cp_op) intersect {[fadd:fmul]} && 
	   										  				 	  	 binsof (cp_operand_a) && 
	   										  				 	  	 binsof (cp_operand_b)); 
						bins arith_f_operand_abc =  (binsof (cp_op) intersect {[fmadd:fmnsub]} && 
	   										  						   binsof (cp_operand_a) && 
	   										  						   binsof (cp_operand_b) && 
	   										  						   binsof (cp_operand_c)); 

						bins smath_f_operand_ab  =  (binsof (cp_op) intersect {fdiv} && 
	   										  				 	  	 binsof (cp_operand_a) && 
	   										  				 	  	 binsof (cp_operand_b)); 
						bins smath_f_operand_a   =  (binsof (cp_op) intersect {fsqrt, fexp, flog} && 
	   										  				 	  	 binsof (cp_operand_a)); 

						bins cmpcnv_f_operand_a  =  (binsof (cp_op) intersect {fcvt_w_s, fcvt_wu_s} && 
	   										  				 	  	 binsof (cp_operand_a)); 
						bins cmpcnv_f_operand_ab =  (binsof (cp_op) intersect {[fmin:fne]} && 
	   										  				 	  	 binsof (cp_operand_a) && 
	   										  				 	  	 binsof (cp_operand_b)); 
					}
	endgroup : cg_Input_combination_coverage
