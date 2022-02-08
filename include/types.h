/**
*\file types.h
*\brief contient les definitions des types et structures. 
*\author TEHARI Ayoub
*\version 
*\date 30/03/2020
*
*
*
*
*
*
*
*
*
*/



#ifndef _H_TYPES
#define _H_TYPES

#include <stdint.h>

#ifndef _MACROS_

#define _MACROS_
#define SizeLetter 5
#define maxSizeWord 25
#define SEP " ,.-'"  
#define DICORES "dictionnaires.txt"
#define TEXTE "hugo1.txt"

#endif



typedef struct maillon_t maillon_t;
struct maillon_t {
  uint32_t elem;
  maillon_t* next;
};

typedef struct emplacement_t emplacement_t;
struct emplacement_t {
  unsigned int line;
  unsigned int colonne;
  emplacement_t* next;
};

typedef struct mot_t mot_t;
struct mot_t {
  maillon_t* tete_mot;
  maillon_t* queue_mot;
  emplacement_t* tete_liste;
  emplacement_t* queue_liste;
};

typedef struct dico dico;
struct dico {
  mot_t* mot;
  dico* next;
};
#endif
