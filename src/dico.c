/**
*\file dico.c
*\brief contient le programme pricipale dectionnaire 
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
*
*
*
*/



#include "dico.h"

#ifdef KLEE
#include <klee/klee.h> 
#include <assert.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
int deco (int argc, char **argv)
{
  	FILE* f = NULL;
  if (argc < 2) {
	printf("usage de %s est : <%s> <fichier_d_entree>\n%d\n",argv[0], argv[0], argc);
  }else {
     for (int i=1; i<argc; i++) {
  	if ((f = fdopen(open(argv[i], O_RDONLY), "r+"))== NULL) {
		printf("Erreur de lecture fichier : %s\n", argv[1]);
 	 }else {
  		unsigned int* line = (unsigned int*) malloc(sizeof(int));
  		unsigned int* colonne = (unsigned int*) malloc(sizeof(int));
  		char* word = (char*) malloc(sizeof(char)*maxSizeWord);
 		 dico* dictionary = (dico*) malloc(sizeof(dico));
		 dictionary->mot=NULL;
		dictionary->next=NULL;

 		 while(!feof(f)) {
  	  		word = next_word(f,line,colonne); 
   	 		dictionary = addToDico(dictionary,word,line,colonne); 
  		}
		dico* tempDico = (dico*) malloc(sizeof(dico));
		tempDico = dictionary;
		mot_t* w1=tempDico->mot;
		mot_t* w2=NULL;
		tempDico = tempDico->next;

		    while(tempDico != NULL) {
		      w2=tempDico->mot;
		      if (compareWord(w1, w2) > -1){
			assert(0);
		      }
		      w1=w2;
		      tempDico = tempDico->next;
		    }
  		displayDico(dictionary);
		free(tempDico);
		free(line);
		free(colonne);
		free(dictionary);
  		fclose(f);
  	}
     }
  }
	
    	
  	return 0;
}

#else
int deco (int argc, char **argv)
{
  FILE* f = NULL;
  int i, j;
  if (argc < 2) {
	printf("usage de %s est : <%s> <fichier_d_entree>\n",argv[0], argv[0]);
  }else {
  for (j=0; j<10; j++) {
     for (i=1; i<argc; i++) {
  	if ((f = fopen(argv[i], "r"))== NULL) {
		printf("Erreur de lecture fichier : %s\n", argv[1]);
 	 }else {
		printf("Traitement du fichier : %s\n", argv[i]);
  		unsigned int* line = (unsigned int*) malloc(sizeof(int));
  		unsigned int* colonne = (unsigned int*) malloc(sizeof(int));
  		char* word = (char*) malloc(sizeof(char)*maxSizeWord);
 		 dico* dictionary = (dico*) malloc(sizeof(dico));
		 dictionary->mot=NULL;
		dictionary->next=NULL;

 		 while(!feof(f)) {
  	  		word = next_word(f,line,colonne); 
   	 		dictionary = addToDico(dictionary,word,line,colonne); 
  		}
  		displayDico(dictionary);
  		fclose(f);
  	}
     }
  }
  }
  return 0;
}
#endif
