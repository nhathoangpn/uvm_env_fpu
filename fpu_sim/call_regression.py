#! /usr/bin/python
import subprocess
import os

print('Hi the exciting FPU world!!!!')

tfv_in_file			= 'tfv_in_file'
tfv_in_file_t		= 'tfv_in_file_t'
tfv_out_file		= 'tfv_out_file'
tfv_out_file_t	= 'tfv_out_file_t'

tfv_cmdi = "cat tfv_in_file_t | ../testfloat/Lib/TestFloat-3e/build/Linux-riscV-GCC/testfloat_ver -exact -checkNaNs -errors 1000000"
'''tfv_cmdo = "|& tee tfv_out_file_t"'''
tfv_cmdo = "&> tfv_out_file_t"

fadd      = '00'
fsub      = '01'
fmul      = '02'
fmadd     = '08'
fmsub     = '09'
fmnadd    = '0a'
fmnsub    = '0b'
add       = '20'
sub       = '21'
mul       = '22'
mulh      = '23'
madd      = '28'
msub      = '29'
mnadd     = '2a'
mnsub     = '2b'
add_u     = '30'
sub_u     = '31'
mul_u     = '32'
mulh_u    = '33'
mul_su    = '34'
mulh_su   = '35'

fdiv      = '40'
fsqrt     = '42'
fexp      = '44'
flog      = '45'
div_s     = '60'
rem_s     = '61'
div_u     = '70'
rem_u     = '71'

fmin      = '80'
fmax      = '81'
feq       = '82'
flt       = '83'
fle       = '84'
fne       = '85'
fcvt_w_s  = '88'
fcvt_wu_s = '89'
fcvt_s_w  = 'aa'
fcvt_s_wu = 'ab'

rne       =  '0'
rtz       =  '1'
rdn       =  '2'
rup       =  '3'
rmm       =  '4'

def dec_opc2opo(op_code):
	if op_code == fadd:
		op_opt = 'f32_add'
	elif op_code == fsub:
		op_opt = 'f32_sub'
	elif op_code == fmul:
		op_opt = 'f32_mul'
	elif op_code == fmadd:
		op_opt = 'f32_mulAdd'
	elif op_code == fmsub:
		op_opt = 'f32_mulSub'
	elif op_code == fmnadd:
		op_opt = 'f32_mulNegateAdd'
	elif op_code == fmnsub:
		op_opt = 'f32_mulNegateSub'
	elif op_code == add:
		op_opt = 'i32_add'
	elif op_code == sub:
		op_opt = 'i32_sub'
	elif op_code == mul:
		op_opt = 'i32_mul'
	elif op_code == mulh:
		op_opt = 'i32_mulh'
	elif op_code == madd:
		op_opt = 'i32_mulAdd'
	elif op_code == msub:
		op_opt = 'i32_mulSub'
	elif op_code == mnadd:
		op_opt = 'i32_mulNegateAdd'
	elif op_code == mnsub:
		op_opt = 'i32_mulNegateSub'
	elif op_code == add_u:
		op_opt = 'ui32_add'
	elif op_code == sub_u:
		op_opt = 'ui32_sub'
	elif op_code == mul_u:
		op_opt = 'ui32_mul'
	elif op_code == mulh_u:
		op_opt = 'ui32_mulh'
	elif op_code == mul_su:
		op_opt = 'i32_ui32_mul'
	elif op_code == mulh_su:
		op_opt = 'i32_ui32_mulh'
	elif op_code == fdiv:
		op_opt = 'f32_div'
	elif op_code == fsqrt:
		op_opt = 'f32_sqrt'
	elif op_code == fexp:
		op_opt = 'f32_exp2'
	elif op_code == flog:
		op_opt = 'f32_log2'
	elif op_code == div_s:
		op_opt = 'i32_div'
	elif op_code == div_u:
		op_opt = 'ui32_div'
	elif op_code == rem_s:
		op_opt = 'i32_rem'
	elif op_code == rem_u:
		op_opt = 'ui32_rem'
	elif op_code == fmin:
		op_opt = 'f32_min'
	elif op_code == fmax:
		op_opt = 'f32_max'
	elif op_code == feq:
		op_opt = 'f32_eq'
	elif op_code == flt:
		op_opt = 'f32_lt'
	elif op_code == fle:
		op_opt = 'f32_le'
	elif op_code == fne:
		op_opt = 'f32_ne'
	elif op_code == fcvt_w_s:
		op_opt = 'f32_to_i32'
	elif op_code == fcvt_wu_s:
		op_opt = 'f32_to_ui32'
	elif op_code == fcvt_s_w:
		op_opt = 'i32_to_f32'
	elif op_code == fcvt_s_wu:
		op_opt = 'ui32_to_f32'
	else:
		op_opt = 'op_none'
	return op_opt

def dec_rmc2rmo(rm_code):
	if   rm_code == rne:
		rm_opt = '-rnear_even'
	elif rm_code == rtz:
		rm_opt = '-rminMag'
	elif rm_code == rdn:
		rm_opt = '-rmin'
	elif rm_code == rup:
		rm_opt = '-rmax'
	elif rm_code == rmm:
		rm_opt = '-rnear_maxMag'
	else:
		rm_opt = 'rm_none'
	return rm_opt

def dec_fnc2fno(fn_code):
	if   fn_code == '1':
		fn_opt = '-flush'
	elif fn_code == '0':
		fn_opt = ''
	else:
		fn_opt = 'fn_none'
	return fn_opt

def dec_opc2list(op_code, in_list):
	if op_code == fadd:
		out_list = [in_list[2], in_list[3],             in_list[5],    in_list[6]]
	elif op_code == fsub:
		out_list = [in_list[2], in_list[3],             in_list[5],    in_list[6]]
	elif op_code == fmul:
		out_list = [in_list[2], in_list[3],             in_list[5],    in_list[6]]
	elif op_code == fmadd:
		out_list = [in_list[2], in_list[3], in_list[4], in_list[5],    in_list[6]]
	elif op_code == fmsub:
		out_list = [in_list[2], in_list[3], in_list[4], in_list[5],    in_list[6]]
	elif op_code == fmnadd:
		out_list = [in_list[2], in_list[3], in_list[4], in_list[5],    in_list[6]]
	elif op_code == fmnsub:
		out_list = [in_list[2], in_list[3], in_list[4], in_list[5],    in_list[6]]
	elif op_code == add:
		out_list = [in_list[2], in_list[3],             in_list[5],                '0' + in_list[7]]
	elif op_code == add_u:
		out_list = [in_list[2], in_list[3],             in_list[5],                '0' + in_list[7]]
	elif op_code == sub:
		out_list = [in_list[2], in_list[3],             in_list[5],                '0' + in_list[7]]
	elif op_code == sub_u:
		out_list = [in_list[2], in_list[3],             in_list[5],                '0' + in_list[7]]
	elif op_code == mul:
		out_list = [in_list[2], in_list[3],             in_list[5],                '0' + in_list[7]]
	elif op_code == mulh:
		out_list = [in_list[2], in_list[3],             in_list[5],                '0' + in_list[7]]
	elif op_code == mul_u:
		out_list = [in_list[2], in_list[3],             in_list[5],                '0' + in_list[7]]
	elif op_code == mulh_u:
		out_list = [in_list[2], in_list[3],             in_list[5],                '0' + in_list[7]]
	elif op_code == mul_su:
		out_list = [in_list[2], in_list[3],             in_list[5],                '0' + in_list[7]]
	elif op_code == mulh_su:
		out_list = [in_list[2], in_list[3],             in_list[5],                '0' + in_list[7]]
	elif op_code == madd:
		out_list = [in_list[2], in_list[3], in_list[4], in_list[5],                '0' + in_list[7]]
	elif op_code == mnadd:
		out_list = [in_list[2], in_list[3], in_list[4], in_list[5],                '0' + in_list[7]]
	elif op_code == msub:
		out_list = [in_list[2], in_list[3], in_list[4], in_list[5],                '0' + in_list[7]]
	elif op_code == mnsub:
		out_list = [in_list[2], in_list[3], in_list[4], in_list[5],                '0' + in_list[7]]
	elif op_code == fdiv:
		out_list = [in_list[2], in_list[3],             in_list[5],    in_list[6]]
	elif op_code == fsqrt:
		out_list = [in_list[2],                         in_list[5],    in_list[6]]
	elif op_code == fexp:
		out_list = [in_list[2],                         in_list[5],    in_list[6]]
	elif op_code == flog:
		out_list = [in_list[2],                         in_list[5],    in_list[6]]
	elif op_code == div_s:
		out_list = [in_list[2], in_list[3],             in_list[5],                '0' + in_list[7]]
	elif op_code == div_u:
		out_list = [in_list[2], in_list[3],             in_list[5],                '0' + in_list[7]]
	elif op_code == rem_s:
		out_list = [in_list[2], in_list[3],             in_list[5],                '0' + in_list[7]]
	elif op_code == rem_u:
		out_list = [in_list[2], in_list[3],             in_list[5],                '0' + in_list[7]]
	elif op_code == fmin:
		out_list = [in_list[2], in_list[3],             in_list[5],    in_list[6]]
	elif op_code == fmax:
		out_list = [in_list[2], in_list[3],             in_list[5],    in_list[6]]
	elif op_code == feq:
		out_list = [in_list[2], in_list[3],             in_list[5][7], in_list[6]]
	elif op_code == flt:
		out_list = [in_list[2], in_list[3],             in_list[5][7], in_list[6]]
	elif op_code == fle:
		out_list = [in_list[2], in_list[3],             in_list[5][7], in_list[6]]
	elif op_code == fne:
		out_list = [in_list[2], in_list[3],             in_list[5][7], in_list[6]]
	elif op_code == fcvt_w_s:
		out_list = [in_list[2],                         in_list[5]   , in_list[6]]
	elif op_code == fcvt_wu_s:
		out_list = [in_list[2],                         in_list[5]   , in_list[6]]
	elif op_code == fcvt_s_w:
		out_list = [in_list[2],                         in_list[5]   , in_list[6]]
	elif op_code == fcvt_s_wu:
		out_list = [in_list[2],                         in_list[5]   , in_list[6]]
	else:
		out_list = ['none']
	return out_list

target_dic = {}
tfvi_file = open(tfv_in_file, 'r')
for tfvi_line in tfvi_file:
	tfvi_line_list = tfvi_line.split()
	op_dic = tfvi_line_list[0]
	rm_dic = tfvi_line_list[1]
	fn_dic = tfvi_line_list[10]
	if op_dic not in target_dic:
		target_dic[op_dic] = {}
	if rm_dic not in target_dic[op_dic]:
		target_dic[op_dic][rm_dic] = {}
	if fn_dic not in target_dic[op_dic][rm_dic]:
		target_dic[op_dic][rm_dic][fn_dic] = []
	target_dic[op_dic][rm_dic][fn_dic].append(dec_opc2list(op_dic, tfvi_line_list))
tfvi_file.close()

tfvo_file = open(tfv_out_file, 'w+')
for op_item in target_dic.keys():
	for rm_item in target_dic[op_item].keys():
		for fn_item in target_dic[op_item][rm_item].keys():
			if len(target_dic[op_item][rm_item][fn_item]) != 0:
				tfvi_file_t = open(tfv_in_file_t, 'w+')
				for item in range(0, len(target_dic[op_item][rm_item][fn_item])):
					tfvi_file_t.write(' '.join(target_dic[op_item][rm_item][fn_item][item]))
					tfvi_file_t.write('\n')
				tfvi_file_t.close()
				os.system(tfv_cmdi + " " + dec_opc2opo(op_item) + " " + dec_rmc2rmo(rm_item) + " " + dec_fnc2fno(fn_item) + " " + tfv_cmdo)
				tfvo_file.write(dec_opc2opo(op_item) + " " + dec_rmc2rmo(rm_item) + " " + dec_fnc2fno(fn_item) + "\n")
				tfvo_file_t = open(tfv_out_file_t, 'r')
				for tfvo_file_t_line in tfvo_file_t:
					tfvo_file_wline = ''
					if len(tfvo_file_t_line.split()) == 3:
						tfvo_file_wline = tfvo_file_t_line
					elif 'expected' in tfvo_file_t_line:
						tfvo_file_wline = tfvo_file_wline + tfvo_file_t_line
					elif 'Invalid' in tfvo_file_t_line:
						tfvo_file_wline = tfvo_file_t_line
					elif 'No such file or directory' in tfvo_file_t_line:
						tfvo_file_wline = tfvo_file_t_line
					tfvo_file.write(tfvo_file_wline)
				tfvo_file_t.close()
tfvo_file.close()
os.system("sed -i 's/\r//g' tfv_out_file")
