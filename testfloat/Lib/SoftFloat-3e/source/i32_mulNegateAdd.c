
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

#define MAX  0x7FFFFFFF
#define ZERO 0
#define MIN  -2147483648

int32_t i32_mulNegateAdd( int32_t a, int32_t b, int32_t c )
{

    union { int64_t i64; int32_t i; } uA, uB, uC, uD;
    
    uA.i   = a;
    uA.i64 = uA.i;
    uB.i   = b;
    uB.i64 = uB.i;
    uC.i   = c;
    uC.i64 = uC.i;
    
    uD.i64  =  -(uA.i64 * uB.i64 + uC.i64);

    if ( uD.i64 > MAX ){
      softfloat_raiseFlags( int_flag_overflow );
    }

    if ( uD.i64 < ZERO ){
      softfloat_raiseFlags( int_flag_sign );
    }

    if ( uD.i64 < MIN ){
      softfloat_raiseFlags( int_flag_overflow );
    }

    if ( uD.i64 == ZERO ){
      softfloat_raiseFlags( int_flag_zero );
    }
    
    return uD.i;



}

