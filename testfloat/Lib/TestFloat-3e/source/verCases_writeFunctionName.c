
/*============================================================================

This C source file is part of TestFloat, Release 3e, a package of programs for
testing the correctness of floating-point arithmetic complying with the IEEE
Standard for Floating-Point, by John R. Hauser.

Copyright 2011, 2012, 2013, 2014, 2017 The Regents of the University of
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

#include <stdio.h>
#include "platform.h"
#include "functions.h"
#include "verCases.h"

void verCases_writeFunctionName( FILE *streamPtr )
{
    static const char *roundingModeNames[NUM_ROUNDINGMODES] = {
        0,
        ", rounding near_even",
        ", rounding minMag",
        ", rounding min",
        ", rounding max",
        ", rounding near_maxMag",
#ifdef FLOAT_ROUND_ODD
        ", rounding odd"
#endif
    };

    fputs( verCases_functionNamePtr, streamPtr );
    if ( verCases_roundingCode ) {
        if ( verCases_roundingPrecision ) {
            fprintf(
                streamPtr, ", precision %d", (int) verCases_roundingPrecision
            );
        }
        fputs( roundingModeNames[verCases_roundingCode], streamPtr );
        if ( verCases_tininessCode ) {
            fputs(
                (verCases_tininessCode == TININESS_BEFORE_ROUNDING)
                    ? ", tininess before rounding"
                    : ", tininess after rounding",
                streamPtr
            );
        }
        if ( verCases_flushCode ) {
            fputs(
                (verCases_flushCode == EN_PRECISE)
                    ? ", fn = 1"
                    : ", fn = 0",
                streamPtr
            );
        }
    }
    if ( verCases_usesExact ) {
        fputs( verCases_exact ? ", exact" : ", not exact", streamPtr );
    }

}

