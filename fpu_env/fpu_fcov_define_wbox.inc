	covergroup cg_GRS_arith_comb_Coverage;
		cp_op_arith: coverpoint op_i {
						bins fadd = {fadd};
						bins fsub = {fsub};
						bins fmul = {fmul};
						bins fmadd = {fmadd};
						bins fmsub = {fmsub};
						bins fmnadd = {fmnadd};
						bins fmnsub = {fmnsub};
					     }
		cp_rm: coverpoint rm_i {
						bins rne = {rne};
						bins rtz = {rtz};
						bins rdn = {rdn};
						bins rup = {rup};
						bins rmm = {rmm};
						}

		cp_grs_arith: coverpoint {guard_bit_arith, round_bit_arith, sticky_bit_arith} {
						bins grs_000 = {3'b000};
						bins grs_001 = {3'b001};
						bins grs_010 = {3'b010};
						bins grs_011 = {3'b011};
						bins grs_100 = {3'b100};
						bins grs_101 = {3'b101};
						bins grs_110 = {3'b110};
						bins grs_111 = {3'b111};
						}

		cs_grs_arith_comb: cross cp_op_arith, cp_rm, cp_grs_arith;
	endgroup

	covergroup cg_GRS_spmath_comb_Coverage;
		cp_op_spmath: coverpoint op_i {
						bins fdiv = {fdiv};
						bins fsqrt = {fsqrt};
						bins fexp = {fexp};
						bins flog = {flog};
					      }
		cp_rm: coverpoint rm_i {
						bins rne = {rne};
						bins rtz = {rtz};
						bins rdn = {rdn};
						bins rup = {rup};
						bins rmm = {rmm};
						}

		cp_grs_spmath: coverpoint {guard_bit_spmath, round_bit_spmath, sticky_bit_spmath} {
						bins grs_000 = {3'b000};
						bins grs_001 = {3'b001};
						bins grs_010 = {3'b010};
						bins grs_011 = {3'b011};
						bins grs_100 = {3'b100};
						bins grs_101 = {3'b101};
						bins grs_110 = {3'b110};
						bins grs_111 = {3'b111};
						}

		cs_grs_spmath_comb: cross cp_op_spmath, cp_rm, cp_grs_spmath{
					ignore_bins grs_xx0_fdiv_fsqrt = binsof (cp_op_spmath) intersect {fdiv, fsqrt} &&
							binsof (cp_grs_spmath) intersect {3'b010, 3'b100, 3'b110};
						}
	endgroup

	covergroup cg_GRS_cmpcnv_i2f_comb_Coverage;
		cp_op_cmpcnv_i2f: coverpoint op_i {
						bins fcvt_s_w  = {fcvt_s_w };
						bins fcvt_s_wu = {fcvt_s_wu};
						}
		cp_rm: coverpoint rm_i {
						bins rne = {rne};
						bins rtz = {rtz};
						bins rdn = {rdn};
						bins rup = {rup};
						bins rmm = {rmm};
						}

		cp_grs_cmpcnv_i2f: coverpoint {guard_bit_cmpcnv_i2f, round_bit_cmpcnv_i2f, sticky_bit_cmpcnv_i2f} {
						bins grs_000 = {3'b000};
						bins grs_001 = {3'b001};
						bins grs_010 = {3'b010};
						bins grs_011 = {3'b011};
						bins grs_100 = {3'b100};
						bins grs_101 = {3'b101};
						bins grs_110 = {3'b110};
						bins grs_111 = {3'b111};
						}

		cs_grs_cmpcnv_i2f_comb: cross cp_op_cmpcnv_i2f, cp_rm, cp_grs_cmpcnv_i2f;
	endgroup

	covergroup cg_GRS_cmpcnv_f2i_comb_Coverage;
		cp_op_cmpcnv_f2i: coverpoint op_i {
						bins fcvt_w_s  = {fcvt_w_s };
						bins fcvt_wu_s = {fcvt_wu_s};
						}
		cp_rm: coverpoint rm_i {
						bins rne = {rne};
						bins rtz = {rtz};
						bins rdn = {rdn};
						bins rup = {rup};
						bins rmm = {rmm};
						}

		cp_grs_cmpcnv_f2i: coverpoint {fraction_0_cmpcnv_f2i, fraction_1_cmpcnv_f2i} {
						bins fraction_00 = {2'b00};
						bins fraction_01 = {2'b01};
						bins fraction_10 = {2'b10};
						bins fraction_11 = {2'b11};
						}

		cs_grs_cmpcnv_f2i_comb: cross cp_op_cmpcnv_f2i, cp_rm, cp_grs_cmpcnv_f2i;
	endgroup
