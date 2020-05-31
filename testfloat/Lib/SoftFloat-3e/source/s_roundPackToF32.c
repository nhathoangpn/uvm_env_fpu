
/*============================================================================

This C source file is part of the SoftFloat IEEE Floating-Point Arithmetic
Package, Release 3e, by John R. Hauser.

Copyright 2011, 2012, 2013, 2014, 2015, 2017 The Regents of the University of
California.  All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice,
    this list of conditions, and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions, and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

 3. Neither the name of the University nor the names of its contributors may
    be used to endorse or promote products derived from this software without
    specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS "AS IS", AND ANY
EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ARE
DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=============================================================================*/

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include "platform.h"
#include "internals.h"
#include "softfloat.h"

float32_t
 softfloat_roundPackToF32( bool sign, int_fast16_t exp, uint_fast32_t sig )
{
    int_fast16_t  exp_br;
    uint_fast32_t sig_br  = sig << 1;
    uint_fast32_t sig_or  = sig;
    uint_fast32_t sig_nor = ( sig_br & 0x7fffff00) >> 8;
    uint_fast32_t grs     = ( sig_br & 0x000000ff);
    uint_fast32_t g       = ( ( sig_br & 0x000000ff) & 0x80 ) >> 7 ;
    uint_fast32_t r       = ( ( sig_br & 0x000000ff) & 0x40 ) >> 6 ;
    uint_fast32_t s       = ( sig_br & 0x000000ff) && 0x3f  ;

    if ((sig_br >> 31)) {
      exp_br = exp - 126;  
    }
    else{
      exp_br = exp - 127;  
    }
   
//    printf ("exp = %d\n", exp);
//    printf ("exp = %08x\n", exp);
//    printf ("exp_br = %d\n", exp_br);
//    printf ("exp_br = %08x\n", exp_br);
//    printf ("sig = %08x\n", sig);
//    printf ("sig_br = %08x\n", sig_br);
//    printf ("sig_nor = %08x\n", sig_nor);
//    printf ("grs = %8x\n", grs);
//    printf ("g = %8x\n", g);
//    printf ("r = %8x\n", r);
//    printf ("s = %8x\n", s);
 
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
    if ( ! roundNearEven && (roundingMode != softfloat_round_near_maxMag) ) {
        roundIncrement =
            (roundingMode
                 == (sign ? softfloat_round_min : softfloat_round_max))
                ? 0x7F
                : 0;
    }
    roundBits = sig & 0x7F;
    /*------------------------------------------------------------------------
    *------------------------------------------------------------------------*/
    if ( 0xFD <= (unsigned int) exp ) {
        if ( exp < 0 ) {
            /*----------------------------------------------------------------
            *----------------------------------------------------------------*/
            isTiny =
                (softfloat_detectTininess == softfloat_tininess_beforeRounding)
                    || (exp < -1) || (sig + roundIncrement < 0x80000000);
            sig = softfloat_shiftRightJam32( sig, -exp );
            exp = 0;
            roundBits = sig & 0x7F;
            if ( isTiny && roundBits ) {
                softfloat_raiseFlags( softfloat_flag_underflow );
            }
        } else if ( (0xFD < exp) || (0x80000000 <= sig + roundIncrement) ) {
            /*----------------------------------------------------------------
            *----------------------------------------------------------------*/
            softfloat_raiseFlags(
                softfloat_flag_overflow | softfloat_flag_inexact );
            uiZ = packToF32UI( sign, 0xFF, 0 ) - ! roundIncrement;
            goto uiZ;
        }
    }
    /*------------------------------------------------------------------------
    *------------------------------------------------------------------------*/
    sig = (sig + roundIncrement)>>7;
    if ( roundBits ) {
        softfloat_exceptionFlags |= softfloat_flag_inexact;
#ifdef SOFTFLOAT_ROUND_ODD
        if ( roundingMode == softfloat_round_odd ) {
            sig |= 1;
            goto packReturn;
        }
#endif
    }
    sig &= ~(uint_fast32_t) (! (roundBits ^ 0x40) & roundNearEven);
    if ( ! sig ) exp = 0;
    /*------------------------------------------------------------------------
    *------------------------------------------------------------------------*/
 packReturn:
    uiZ = packToF32UI( sign, exp, sig );
//    printf ("uiZ = %08x\n", uiZ);

//Tininess after rounding
    if (softfloat_detectTininess == softfloat_tininess_afterRounding) {
      uint_fast32_t sigZ;
      sigZ  = fracF32UI( uiZ );
      uint_fast32_t expZ;
      expZ  = expF32UI( uiZ );
      bool signZ;
      signZ = signF32UI( uiZ );

      if ( expZ == 0 && sigZ != 0) {
        softfloat_raiseFlags( softfloat_flag_underflow );
        softfloat_raiseFlags( softfloat_flag_inexact );
        if (roundingMode == softfloat_round_max){
            if ( signZ ) {
              uiZ = packToF32UI( signZ, 0, 0 );
            }
            else {
              uiZ = packToF32UI( 0, 1, 0 );
            }
        }
    
    
        if (roundingMode == softfloat_round_min){
            if ( signZ ) {
              uiZ = packToF32UI( 1, 1, 0 );
            }
            else {
              uiZ = packToF32UI( 0, 0, 0 );
            }
        }
    
        if (roundingMode == softfloat_round_minMag){
            if ( signZ ) {
              uiZ = packToF32UI( signZ, 0, 0 );
            }
            else {
              uiZ = packToF32UI( 0, 0, 0 );
            }
     
        }
    
        if (roundingMode == softfloat_round_near_even){
          if ((flushMode == softfloat_flush_precise) && (exp_br == -128) && (sig_nor == 0x007fffff)) {
              if ( ((g) && (sig_nor & 0x00000001)) || ((g) && (r & s)) ){
                uiZ = packToF32UI( signZ, 1, 0 );
              }
              else{
                uiZ = packToF32UI( signZ, 0, 0 );
              }
           
          }
          else{
              if ( (flushMode == softfloat_flush_precise) && (exp_br >= -127 )) {
                uiZ = packToF32UI( signZ, 1, 0 );
              }
              else {
                uiZ = packToF32UI( signZ, 0, 0 );
              }
          }
     
        }
    
        if (roundingMode == softfloat_round_near_maxMag){
          if ((flushMode == softfloat_flush_precise) && (exp_br == -128) && (sig_nor == 0x007fffff)) {
              if (g) {
                uiZ = packToF32UI( signZ, 1, 0 );
              }
              else{
                uiZ = packToF32UI( signZ, 0, 0 );
              }
           
          }
          else{
              if ( (flushMode == softfloat_flush_precise) && (exp_br >= -127 )) {
                uiZ = packToF32UI( signZ, 1, 0 );
              }
              else {
                uiZ = packToF32UI( signZ, 0, 0 );
              }
     
          }
        }
      }
    
    }


//Tininess before rounding
    if (softfloat_detectTininess == softfloat_tininess_beforeRounding) {
      if ( exp_br < -126 && sig_or != 0) {
        softfloat_raiseFlags( softfloat_flag_underflow );
        softfloat_raiseFlags( softfloat_flag_inexact );
        if (roundingMode == softfloat_round_max){
            bool signZ;
            signZ = (signF32UI( uiZ ));
            if ( signZ ) {
              uiZ = packToF32UI( signZ, 0, 0 );
            }
            else {
              uiZ = packToF32UI( 0, 1, 0 );
            }
        }
    
    
        if (roundingMode == softfloat_round_min){
            bool signZ;
            signZ = (signF32UI( uiZ ));
            if ( signZ ) {
              uiZ = packToF32UI( 1, 1, 0 );
            }
            else {
              uiZ = packToF32UI( 0, 0, 0 );
            }
        }
    
        if (roundingMode == softfloat_round_minMag){
            bool signZ;
            signZ = (signF32UI( uiZ ));
            if ( signZ ) {
              uiZ = packToF32UI( signZ, 0, 0 );
            }
            else {
              uiZ = packToF32UI( 0, 0, 0 );
            }
     
        }
    
        if (roundingMode == softfloat_round_near_even){
            bool signZ;
            uint_fast32_t sigZ;
            sigZ  = fracF32UI( uiZ );
            signZ = (signF32UI( uiZ ));
            if ( signZ ) {
              if ( (flushMode == softfloat_flush_precise) && (exp_br >= -127 )) {
                uiZ = packToF32UI( signZ, 1, 0 );
              }
              else {
                uiZ = packToF32UI( signZ, 0, 0 );
              }
            }
            else {
              if ( (flushMode == softfloat_flush_precise) && (exp_br >= -127 )) {
                uiZ = packToF32UI( signZ, 1, 0 );
              }
              else {
                uiZ = packToF32UI( signZ, 0, 0 );
              }
            }
     
        }
    
        if (roundingMode == softfloat_round_near_maxMag){
            bool signZ;
            uint_fast32_t sigZ;
            sigZ  = fracF32UI( uiZ );
            signZ = (signF32UI( uiZ ));
            if ( signZ ) {
              if ( (flushMode == softfloat_flush_precise) && (exp_br >= -127)) {
                uiZ = packToF32UI( signZ, 1, 0 );
              }
              else {
                uiZ = packToF32UI( signZ, 0, 0 );
              }
            }
            else {
              if ( (flushMode == softfloat_flush_precise) && (exp_br >= -127)) {
                uiZ = packToF32UI( signZ, 1, 0 );
              }
              else {
                uiZ = packToF32UI( signZ, 0, 0 );
              }
            }
     
        }
      }
    
    }

    if ( (roundingMode == softfloat_round_min) && ( exp_br >= -126) ) {
      if ( (exp == 0x00) && ( sig == 0x000000) ) {
          uiZ = packToF32UI( 1, 0, 0 );
      }
    }



 uiZ:
    uZ.ui = uiZ;



    return uZ.f;

}

