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

# define ONE \
  (__extension__                                                              \
   ((union { unsigned __l __attribute__ ((__mode__ (__SI__))); float32_t __d; })  \
    { __l: 0xbf800000UL }).__d)

# define POS_ONE \
  (__extension__                                                              \
   ((union { unsigned __l __attribute__ ((__mode__ (__SI__))); float32_t __d; })  \
    { __l: 0x3f800000UL }).__d)

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

# define ZERO \
  (__extension__                                                              \
   ((union { unsigned __l __attribute__ ((__mode__ (__SI__))); float32_t __d; })  \
    { __l: 0x00000000UL }).__d)

# define OVER \
  (__extension__                                                              \
   ((union { unsigned __l __attribute__ ((__mode__ (__SI__))); float32_t __d; })  \
    { __l: 0x7F7FFFFFUL }).__d)

float32_t f32_exp2 ( float32_t op )
{

  // temp var
  mpfr_t     _r;
  mpfr_t     _a;
  mpfr_rnd_t _rnd;


  float f32op;             //32-bit floating point
  union ui32_f32 result;   //result in both unint32_t or float32_t

  union ui32_f32 uA;
  uint_fast32_t uiA;
  bool signA, signZ;              //sign
  int_fast16_t expA, expK, expZ; //exponent of floating input
  uint_fast32_t sigA, sigA_s, sigZ;      //mantisa or fraction of floating input

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

    uint_fast8_t roundingMode;
    uint_fast8_t flushMode;
    bool roundNearEven;
    uint_fast8_t roundIncrement, roundBits;
    bool isTiny;
    uint_fast32_t uiZ;
    union ui32_f32 uZ;

    /*------------------------------------------------------------------------
    *------------------------------------------------------------------------*/
    roundingMode = softfloat_roundingMode;
    flushMode    = softfloat_flushMode;
    roundNearEven = (roundingMode == softfloat_round_near_even);
    roundIncrement = 0x40;

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
//result format & flag
 
   if (( signA ) && (expA == 0xFF ) && (sigA == 0)) {  //-infinity -> 0
      return ZERO;
      }
 
   if (( !signA ) && (expA == 0xFF ) && (sigA == 0)) { //+infinity -> +infinity
      return POS_INF;
      }
 
 //invalid
   if ((softfloat_isSigNaNF32UI( uiA )) ){  //sNAN -> qNAN
       softfloat_raiseFlags( softfloat_flag_invalid );
      return cNAN;
      }
   if (( isNaNF32UI( uiA ))  ){ //qNAN -> qNAN
      return cNAN;
      }

   if (isZERF32UI (uiA)){ //+-0 -> 0
      return POS_ONE;
      }

 
 //sub-normal
   if ( isSubF32UI( uiA ) ) {
         softfloat_raiseFlags( softfloat_flag_subnormal );
         softfloat_raiseFlags( softfloat_flag_inexact );
         union ui32_f32 uB;
         uB.ui = packToF32UI( 0, 0x7f, 0 );
//         printf ("%08x\n", uB.ui);
         return uB.f;
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
    _rnd = MPFR_RNDN; //or MPFR_RNDD
  }

  if (roundingMode == softfloat_round_minMag){
    _rnd = MPFR_RNDZ; //or MPFR_RNDD
  }

  if (roundingMode == softfloat_round_min){
    _rnd = MPFR_RNDD; //or MPFR_RNDD
  }

  if (roundingMode == softfloat_round_max){
    _rnd = MPFR_RNDU; //or MPFR_RNDD
  }

  if (roundingMode == softfloat_round_near_maxMag){
    _rnd = MPFR_RNDNA; //or MPFR_RNDD
  }

  mpfr_set_flt (_a, f32op, _rnd);


//Calculate logarithm
   mpfr_set_emin (-125);
   mpfr_set_emax (128);
   mpfr_exp2(_r, _a, _rnd);
  
  // Get flags that set by mpfr_log2
  mpfr_flags_t rs_flag = mpfr_flags_save();
  //Convert from floating-point binary representation to hex representation
  rs.f = mpfr_get_flt (_r, _rnd);
//  printf ("rs.f = %08f\n", rs.f);
  
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




  signZ = signF32UI( rs_hex );
  expZ  = expF32UI( rs_hex );
  sigZ  = fracF32UI( rs_hex );

//  printf ("Flag = %08x\n", rs_flag);
//  printf ("Result = %08x\n", rs_hex);

//  if ( expZ == 0 && sigZ != 0) {
//      rs_flag = 0x9 ;
//   }

  if (rs_flag == 0xa){
   softfloat_raiseFlags( softfloat_flag_overflow );
   softfloat_raiseFlags( softfloat_flag_inexact );
 };

  if (rs_flag == 0x1){
   softfloat_raiseFlags( softfloat_flag_underflow );
 
 };
  if (rs_flag == 0x2){
   softfloat_raiseFlags( softfloat_flag_overflow );
 };
  if ( (rs_flag == 0x8)) {
   softfloat_raiseFlags( softfloat_flag_inexact );
 };
  if (rs_flag == 0x20){
   softfloat_raiseFlags( softfloat_flag_infinite );
 };
  if (rs_flag == 0x9){
   softfloat_raiseFlags( softfloat_flag_underflow );
   softfloat_raiseFlags( softfloat_flag_inexact );

        if (roundingMode == softfloat_round_min){
            if ( signZ ) {
              uiZ = packToF32UI( 1, 1, 0 );  //-2^min
            }
            else {
              uiZ = packToF32UI( 0, 0, 0 );  //+0
            }
        }

        if (roundingMode == softfloat_round_max){
            if ( signZ ) {
              uiZ = packToF32UI( 1, 0, 0 );  //-0
            }
            else {
              uiZ = packToF32UI( 0, 1, 0 );  //+2^min
            }
        }

        if (roundingMode == softfloat_round_minMag){
            if ( signZ ) {
              uiZ = packToF32UI( signZ, 0, 0 );  //-0
            }
            else {
              uiZ = packToF32UI( 0, 0, 0 );     //+0
            }
        }

        if ((roundingMode == softfloat_round_near_even) || (roundingMode == softfloat_round_near_maxMag)){
            if ( (flushMode == softfloat_flush_precise) && (uA.ui <= 0xC2FE0000 )) {
              uiZ = packToF32UI( signZ, 1, 0 );
            }
            else {
            uiZ = packToF32UI( signZ, 0, 0 );
            }
        }

        result.ui = uiZ;

 };


  // Free the space occupied by the significand of mpfr_t variable.
  mpfr_clear(_a);
  mpfr_clear(_r);
  mpfr_free_cache ();
  mpfr_flags_clear(0x3F);

  return result.f;
 
}

