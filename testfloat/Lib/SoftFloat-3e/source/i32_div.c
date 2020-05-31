
/*============================================================================

This C source file is part of the SoftFloat IEEE Floating-Point Arithmetic
Package, Release 3e, by John R. Hauser.

Copyright 2011, 2012, 2013, 2014, 2015, 2016 The Regents of the University of
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
#include <inttypes.h>

#define MAX_DIV    0x80000000
#define MAX_DIVED  0xFFFFFFFF
#define ZERO 0

int32_t i32_div( int32_t a, int32_t b )
{

    union { int64_t i64; int32_t i; } uA, uB, C;
    
    uA.i   = a;
    uA.i64 = uA.i;
    uB.i   = b;
    uB.i64 = uB.i;
    

    if ( (uA.i == MAX_DIV) && (uB.i == MAX_DIVED) ){
      softfloat_raiseFlags( int_flag_overflow );
      softfloat_raiseFlags( int_flag_sign );
      return MAX_DIV;
    }

    if ( (uA.i != ZERO) && (uB.i == ZERO) ){
      softfloat_raiseFlags( int_flag_infinite );
      softfloat_raiseFlags( int_flag_sign );
      return MAX_DIVED;
    }

    if ( (uA.i == ZERO) && (uB.i == ZERO) ){
      softfloat_raiseFlags( int_flag_infinite );
      softfloat_raiseFlags( int_flag_sign );
      return MAX_DIVED;
    }

    C.i  = uA.i / uB.i;

    if ( C.i < ZERO ){
      softfloat_raiseFlags( int_flag_sign );
    }

    if ( C.i == ZERO ){
      softfloat_raiseFlags( int_flag_zero );
    }
    
    return C.i;



}

