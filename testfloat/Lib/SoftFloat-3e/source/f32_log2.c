#include <stdio.h>
#include <mpfr.h>
#include <gmp.h>
#include <stdbool.h>
#include <stdint.h>
#include <math.h>
#include "platform.h"
#include "internals.h"
#include "specialize.h"
#include "softfloat.h"

#define MPFR_NEED_LONGLONG_H
#include "mpfr-impl.h"

# define INF \
  (__extension__                                                              \
   ((union { unsigned __l __attribute__ ((__mode__ (__SI__))); float32_t __d; })  \
    { __l: 0xff800000UL }).__d)

# define POS_INF \
  (__extension__                                                              \
   ((union { unsigned __l __attribute__ ((__mode__ (__SI__))); float32_t __d; })  \
    { __l: 0x7f800000UL }).__d)

# define cNAN \
  (__extension__                                                              \
   ((union { unsigned __l __attribute__ ((__mode__ (__SI__))); float32_t __d; })  \
    { __l: 0x7fc00000UL }).__d)

float32_t f32_log2 ( float32_t op )
{

  // temp var
  mpfr_t     _r;
  mpfr_t     _a;
  mpfr_rnd_t _rnd;

  uint_fast8_t roundingMode;
  roundingMode = softfloat_roundingMode;

  float f32op;             //32-bit floating point
  union ui32_f32 result;   //result in both unint32_t or float32_t

  union ui32_f32 uA;
  uint_fast32_t uiA;
  bool signA;              //sign
  int_fast16_t expA, expK; //exponent of floating input
  uint_fast32_t sigA, sigA_s;      //mantisa or fraction of floating input

  // Output conversion
  typedef union {
     float f;
     struct
     {
        unsigned int mantissa : 23;
        unsigned int exponent : 8;
        unsigned int sign : 1;
     } raw_flt32;
  } rs_float;
  rs_float rs;
  uint32_t rs_hex;
  uint32_t rs_exp_bit_pos;

  /*------------------------------------------------------------------------
  *------------------------------------------------------------------------*/
  uA.f  = op;
  uiA   = uA.ui;
  signA = signF32UI( uiA );
  expA  = expF32UI( uiA );
  expK  = expA - 127;
  sigA  = fracF32UI( uiA );
  /*------------------------------------------------------------------------
  *------------------------------------------------------------------------*/
//  printf ("Floating-point input: sign is %d, exp is %x, frac is %x, expK %x \n", signA, expA, sigA, expK);
  if ( isNaNF32UI( uiA ) && !(softfloat_isSigNaNF32UI( uiA )))  { //cNaN -> cNaN
     return cNAN;
     }
//infinite
  if ( ( (expA == 0) && (sigA == 0)) ) {  //+-0 -> INF
      softfloat_raiseFlags( softfloat_flag_infinite );
//Wrong     if (signA){
//Wrong      softfloat_raiseFlags( softfloat_flag_invalid );
//Wrong       }
     return INF;
     }

  if (( !signA ) && (expA == 0xFF ) && (sigA == 0)) {  //POS_INF -> POS_INF
     return POS_INF;
     }
  
//invalid
  if ((( signA ) && (expA != 0)) || (softfloat_isSigNaNF32UI( uiA )) ){  //Negave/sNaN -> cNaN 
      softfloat_raiseFlags( softfloat_flag_invalid );
     return cNAN;     
     }

  if (( signA ) && (expA == 0xFF ) && (sigA == 0)) {  //-INF -> cNaN
      softfloat_raiseFlags( softfloat_flag_invalid );
     return cNAN;
     }


//Wrong   if ( ( signA ) && (isNaNF32UI( uiA )))  { //-cNaN -> cNaN
//Wrong      softfloat_raiseFlags( softfloat_flag_invalid );
//Wrong      return cNAN;
//Wrong    }

//sub-normal
  if ( isSubF32UI( uiA ) ) {
        softfloat_raiseFlags( softfloat_flag_subnormal );
      signA = (signF32UI( uiA ));
      uiA   = packToF32UI( signA, 0, 0 );
      softfloat_raiseFlags( softfloat_flag_infinite );  
//    if (signA) {
//      softfloat_raiseFlags( softfloat_flag_invalid );
//       }
   return INF;
    }

//convert input from binary to decimal representation  
  int j;
  double sig_j, frac_r;

  frac_r = 1;
  j = 0;

  for (int i=22; i>=0; i--)
  {
    j++;
    sigA_s = ((sigA >> i) & 0x01); // 0 - 1
    
    sig_j = sigA_s * pow(2.0, -j);
    frac_r = frac_r + sig_j;
//    printf ("j, sig_j, frac_r is   :%d, %f, %f \n", j, sig_j, frac_r);

  };

  f32op = pow(-1, signA) * pow(2, expK) * frac_r;  //input value = (-1)^sign * e^exp *1.man
      
  // Init floating point of mpfr_t. Result of _a will be NaN.
  mpfr_init2 (_a, 64);
  mpfr_init2 (_r, 64);

  // Set floating point of mpfr_t by op of float32_t
  if (roundingMode == softfloat_round_near_even){
//    printf ("Near Even\n");
    _rnd = MPFR_RNDN; //or MPFR_RNDD
  }

  if (roundingMode == softfloat_round_minMag){
//    printf ("Zero\n");
    _rnd = MPFR_RNDZ; //or MPFR_RNDD
  }

  if (roundingMode == softfloat_round_min){
//    printf ("Min\n");
    _rnd = MPFR_RNDD; //or MPFR_RNDD
  }

  if (roundingMode == softfloat_round_max){
//    printf ("Max\n");
    _rnd = MPFR_RNDU; //or MPFR_RNDD
  }

  if (roundingMode == softfloat_round_near_maxMag){
//    printf ("Away Zero\n");
    _rnd = MPFR_RNDNA; //or MPFR_RNDD
  }


  mpfr_set_flt (_a, f32op, _rnd);
//  mpfr_set_ui (_a, uiA, _rnd);

//  printf ("Value of _a is (base10): ");
//  mpfr_out_str (stdout, 10, 0, _a, _rnd);
//  putchar ('\n');

//Calculate logarithm
   mpfr_log2(_r, _a, _rnd);

//  printf ("Result is (base10): ");
//  mpfr_out_str (stdout, 10, 0, _r, _rnd);
//  putchar ('\n');
  
  //Convert from floating-point binary representation to hex representation
  rs.f = mpfr_get_flt (_r, _rnd);
  
  rs_hex = rs.raw_flt32.mantissa;           //Get mantissa value as decimal value
  
  // Check sign and add as unsign integer decimal value
  if (rs.raw_flt32.sign == 0 ) {
      rs_hex = rs_hex ;
  } else {
      rs_hex = rs_hex + pow(2.0,31);
  }
  
  // Check exponent value and add as unsign integer decimal value
  for (int unsigned i = 0 ; i < 8 ; i++ ) {
      rs_exp_bit_pos = i+23;
      if ( (rs.raw_flt32.exponent >> i) & 1) {
          rs_hex = rs_hex + pow(2.0,rs_exp_bit_pos);
      } else {
          rs_hex = rs_hex ;
      }
  }
  result.ui = rs_hex;
  
  // print 32 bit unsign integer as hexvalue
//  printf("rs_hex=32'h%8x \n",rs_hex);

  // Get flags that set by mpfr_log2
  mpfr_flags_t rs_flag = mpfr_flags_save();
//  printf("rs_flag=6'h%x \n",rs_flag);

  if (rs_flag == 0x1){
   softfloat_raiseFlags( softfloat_flag_underflow );
 };
  if (rs_flag == 0x2){
   softfloat_raiseFlags( softfloat_flag_overflow );
 };
  if (rs_flag == 0x8){
   softfloat_raiseFlags( softfloat_flag_inexact );
 };
  if (rs_flag == 0x20){
   softfloat_raiseFlags( softfloat_flag_infinite );
 };
  if (rs_flag == 0x9){
   softfloat_raiseFlags( softfloat_flag_underflow );
   softfloat_raiseFlags( softfloat_flag_inexact );
 };
  if (rs_flag == 0xa){
   softfloat_raiseFlags( softfloat_flag_overflow );
   softfloat_raiseFlags( softfloat_flag_inexact );
 };

 
  // Free the space occupied by the significand of mpfr_t variable.
  mpfr_clear(_a);
  mpfr_clear(_r);
  mpfr_free_cache ();
  mpfr_flags_clear(0x3F);

  return result.f;
}

