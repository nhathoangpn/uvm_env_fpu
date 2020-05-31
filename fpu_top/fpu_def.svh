//==================================================================================================
// Owner:    Hoang Pham
// Filename: fpu_def
// History:  2019.06.21 Create new version
//==================================================================================================

//==================================================================================================
// duv signal width
//==================================================================================================
`define VLDI_W  1
`define RDY_W   1
`define OP_W    8
`define OPD_W  32
`define RM_W    3
`define FN_W    1
`define USRI_W  8
`define STLL_W  1

`define VLDO_W  1
`define RS_W   32
`define FF_W    6
`define IF_W    4
`define ERR_W   1
`define USRO_W  8

//==================================================================================================
// define fpu parameter
//==================================================================================================
//`define P_FPU_ARITH_EN  1
//`define P_FPU_CMPCNV_EN 1
//`define P_FPU_SPMATH_EN 1
//`define P_FPU_SPMATH_EXPLOG_EN 1

//==================================================================================================
// arithmetic operation code
//==================================================================================================
`define FADD      8'b00_00_0000//00
`define FSUB      8'b00_00_0001//01
`define FMUL      8'b00_00_0010//02
`define FMADD     8'b00_00_1000//08
`define FMSUB     8'b00_00_1001//09
`define FMNADD    8'b00_00_1010//0A
`define FMNSUB    8'b00_00_1011//0B
`define ADD       8'b00_10_0000//20
`define SUB       8'b00_10_0001//21
`define MUL       8'b00_10_0010//22
`define MULH      8'b00_10_0011//23
`define MADD      8'b00_10_1000//28
`define MSUB      8'b00_10_1001//29
`define MNADD     8'b00_10_1010//2A
`define MNSUB     8'b00_10_1011//2B
`define ADD_U     8'b00_11_0000//30
`define SUB_U     8'b00_11_0001//31
`define MUL_U     8'b00_11_0010//32
`define MULH_U    8'b00_11_0011//33
`define MUL_SU    8'b00_11_0100//34
`define MULH_SU   8'b00_11_0101//35

//==================================================================================================
// special math operation code
//==================================================================================================
`define FDIV      8'b01_00_0000//40
`define FSQRT     8'b01_00_0010//42
`define FEXP      8'b01_00_0100//44
`define FLOG      8'b01_00_0101//45
`define DIV_S     8'b01_10_0000//60
`define REM_S     8'b01_10_0001//61
`define DIV_U     8'b01_11_0000//70
`define REM_U     8'b01_11_0001//71

//==================================================================================================
// compare/convert math operation code
//==================================================================================================
`define FMIN      8'b10_00_0000//80
`define FMAX      8'b10_00_0001//81
`define FEQ       8'b10_00_0010//82
`define FLT       8'b10_00_0011//83
`define FLE       8'b10_00_0100//84
`define FNE       8'b10_00_0101//85
`define FCVT_W_S  8'b10_00_1000//88
`define FCVT_WU_S 8'b10_00_1001//89
`define FCVT_S_W  8'b10_10_1010//AA
`define FCVT_S_WU 8'b10_10_1011//AB

//==================================================================================================
// rounding mode
//==================================================================================================
`define RNE 3'b000
`define RTZ 3'b001
`define RDN 3'b010
`define RUP 3'b011
`define RMM 3'b100

//==================================================================================================
// operand range
//==================================================================================================
`define NO_FINITE_P           [32'h0080_0000:32'h7F7F_FFFF]
`define NO_FINITE_P_S          32'h0080_0000
`define NO_FINITE_P_E          32'h7F7F_FFFF

`define NO_FINITE_M           [32'h8080_0000:32'hFF7F_FFFF]
`define NO_FINITE_M_S          32'h8080_0000
`define NO_FINITE_M_E          32'hFF7F_FFFF

`define SN_FINITE_P           [32'h0000_0001:32'h007F_FFFF]
`define SN_FINITE_P_S          32'h0000_0001
`define SN_FINITE_P_E          32'h007F_FFFF

`define SN_FINITE_M           [32'h8000_0001:32'h807F_FFFF]
`define SN_FINITE_M_S          32'h8000_0001
`define SN_FINITE_M_E          32'h807F_FFFF

`define ZERO_P                 32'h0000_0000

`define ZERO_M                 32'h8000_0000

`define INFINITE_P             32'h7F80_0000

`define INFINITE_M             32'hFF80_0000

`define SNAN_P                [32'h7F80_0001:32'h7FBF_FFFF]
`define SNAN_P_S               32'h7F80_0001
`define SNAN_P_E               32'h7FBF_FFFF

`define SNAN_M                [32'hFF80_0001:32'hFFBF_FFFF]
`define SNAN_M_S               32'hFF80_0001
`define SNAN_M_E               32'hFFBF_FFFF

`define QNAN_P                [32'h7FC0_0000:32'h7FFF_FFFF]
`define QNAN_P_S               32'h7FC0_0000
`define QNAN_P_E               32'h7FFF_FFFF

`define QNAN_M                [32'hFFC0_0000:32'hFFFF_FFFF]
`define QNAN_M_S               32'hFFC0_0000
`define QNAN_M_E               32'hFFFF_FFFF

`define S_INT_P               [32'h0000_0000:32'h7FFF_FFFF]
`define S_INT_P_S              32'h0000_0000
`define S_INT_P_E              32'h7FFF_FFFF

`define S_INT_M               [32'h8000_0000:32'hFFFF_FFFF]
`define S_INT_M_S              32'h8000_0000
`define S_INT_M_E              32'hFFFF_FFFF

`define U_INT                 [32'h0000_0000:32'hFFFF_FFFF]
`define U_INT_S                32'h0000_0000
`define U_INT_E                32'hFFFF_FFFF

`define CNAN                   32'h7FC0_0000

//==================================================================================================
// Output floating point exception flags 
//==================================================================================================
`define FF_DE                   6'b10_0000 // Subnormal number.
`define FF_NV                   6'b01_0000 // Invalid operation.
`define FF_DZ                   6'b00_1000 // Divide by zero.
`define FF_OF                   6'b00_0100 // Overflow.
`define FF_UF                   6'b00_0010 // Underflow.
`define FF_NX                   6'b00_0001 // Inexact

//==================================================================================================
// Output integer flags 
//==================================================================================================
`define IF_ZE                   4'b1000 // Zero
`define IF_DZ                   4'b0100 // Divide by zero.
`define IF_SN                   4'b0010 // Result sign is minus or not.
`define IF_OF                   4'b0001 // Overflow

//==================================================================================================
// Pipeline select 
//==================================================================================================
`define SEL_ARITH               2'b00
`define SEL_SPMATH              2'b01
`define SEL_CMPCNV              2'b10
