#ifndef SUITEDETESTS_H
#define SUITEDETESTS_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include "CuTest.h"
#include "maillons.h"
#include "words.h"

char *StrToUpper (char *str);
void PremierTestPourJouerAvecFrameworkCuTest (CuTest * tc);
void ConvesionMaillonStringTest (CuTest * tc);
void GetSizeMaillonTest (CuTest *tc);
void CompareWordTest (CuTest *tc) ;
CuSuite *MaTestSuite ();

#endif //ALLTEST_H
