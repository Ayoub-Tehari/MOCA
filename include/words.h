#ifndef _H_WORDS
#define _H_WORDS
#include "maillons.h"
#include "types.h"
#include <stdio.h>
#include <string.h>
#ifdef KLEE
#include <assert.h>
#endif
mot_t* generateMot_t (char*word, unsigned int* line, unsigned int* colonne) ;

char *next_word(FILE *f, unsigned int *nblin, unsigned int *nbcol) ;

int compareWord(mot_t* w1, mot_t* w2);

void addTailWord(dico* dictionary, mot_t* linkWord) __attribute__((always_inline));

dico* addHeadWord(dico* dictionary, mot_t* linkWord) ;

void incWord(emplacement_t* location, unsigned int line, unsigned int colonne) __attribute__((always_inline)) ;

dico* insertDico(dico* dictionary, mot_t* linkWord) ;

dico* addToDico(dico* dictionary, char* word, unsigned int* line, unsigned int* colonne) ;

#endif
