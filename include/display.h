#ifndef _H_DISPLAY
#define _H_DISPLAY
#include <stdlib.h>
#include "types.h"
#include "maillons.h"
#include <stdio.h>


void displayWord(mot_t* word, FILE *filedes) __attribute__((always_inline));
void displayDico(dico* dictionary);
#endif
