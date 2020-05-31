
/*============================================================================

This C source file is part of the SoftFloat IEEE Floating-Point Arithmetic
Package, Release 3e, by John R. Hauser.

Copyright 2011, 2012, 2013, 2014 The Regents of the University of California.
All rights reserved.

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
#include "platform.h"
#include "internals.h"
#include "specialize.h"
#include "softfloat.h"

# define NAN \
  (__extension__                                                              \
   ((union { unsigned __l __attribute__ ((__mode__ (__SI__))); float32_t __d; })  \
    { __l: 0x7fc00000UL }).__d)


float32_t f32_max( float32_t a, float32_t b )
{

    union ui32_f32 uA;
    uint_fast32_t uiA;
    union ui32_f32 uB;
    uint_fast32_t uiB;
    bool signA, signB, result;
    int_fast16_t expA;
    uint_fast32_t sigA;
    int_fast16_t expB;
    uint_fast32_t sigB;

   
    uA.f = a;
    uiA = uA.ui;
    uB.f = b;
    uiB = uB.ui;

    expA  = expF32UI( uiA );
    sigA  = fracF32UI( uiA );
    expB  = expF32UI( uiB );
    sigB  = fracF32UI( uiB );

//    if ( ((expA == 0) && (expB == 0)) && ((sigA == 0) && (sigB == 0)) ) {
//      return (uB.f);
//    }

//    if ( isZERF32UI (uiA ) && isZERF32UI( uiB ) ) {
//       return (uA.f);
//    }

    if ( isNaNF32UI( uiA ) || isNaNF32UI( uiB ) ) {
          if (softfloat_isSigNaNF32UI( uiA ) || softfloat_isSigNaNF32UI( uiB )) {
              softfloat_raiseFlags( softfloat_flag_invalid );
//              return NAN;
          }
//          else {
          if ( isNaNF32UI( uiA ) && isNaNF32UI( uiB ) ) {
            return NAN;
          }

          if ( isNaNF32UI( uiA ) && !(isNaNF32UI( uiB )) ) {
            return (uB.f);
          }

          if ( !(isNaNF32UI( uiA )) && isNaNF32UI( uiB ) ) {
            return (uA.f);
          }

//         }

    }

    else {


      signA  = signF32UI( uiA );
      signB  = signF32UI( uiB );
//      result = (signA != signB) ? signA && ((uint32_t) ((uiA | uiB)<<1) != 0) : (uiA != uiB) && (signA ^ (uiA < uiB));
      result = (signA != signB) ? signA : (uiA != uiB) && (signA ^ (uiA < uiB));

      if (result) {
        return (uB.f);
      }
      else{
        return (uA.f);
      }

   }
    

}
