#ifndef _H_MAILLONS
#define _H_MAILLONS
#include "types.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
  #ifdef KLEE
  #include <assert.h>
  #endif
void setCharnum(maillon_t* link, int k, char c) ;
char getCharnum(maillon_t* link, int k) ;
int isAvailable(char c) ;
int getSizeMaillon(maillon_t* link) ;

#define charToNum(c)  ((c) - 'a' + 1)

#define numToChar(i) ((i) + 'a' - 1)
#define isAvailable(c) (((c) < 'a' || (c) > 'z')? 0: 1)

char* maillonToString(maillon_t* link);
maillon_t* stringToMaillon(char* word) ;
unsigned int getMask(int k) __attribute__((always_inline)) ;
#endif
