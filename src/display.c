
#include "display.h"


void inline displayWord (mot_t* word, FILE *filedes) {
  if (word == NULL) {
  } else {
    maillon_t* link = word->tete_mot;
    emplacement_t* list = word->tete_liste;
    if (link != NULL) {
      fprintf(filedes,"%s",maillonToString(link));
      fflush(stdout);
    }
    while(list != NULL) {
      fprintf(filedes," (%i,%i)",list->line,list->colonne);
      list = list->next;
    }
    free(link);
    free(list);
  }
}

void displayDico(dico* dictionary) {
  FILE *f = NULL;
  f = fopen(DICORES, "rw+");
  if (f == NULL) { printf("Erreur d'ouverture %s\n",DICORES); f=stdout;}
  if (!feof(f))
    printf("Resultat existant dans le fichier resultat, on ecrase\n");
  if (dictionary == NULL) {
    printf("displayDico : NULL\n");
  } else {
    //fprintf(f, "Contenu dictionnaire pour %s : \n", TEXTE);
    dico* tempDico = (dico*) malloc(sizeof(dico));
    tempDico = dictionary;
    while(tempDico != NULL) {
      displayWord(tempDico->mot,f);
      fprintf(f, "\n");
      tempDico = tempDico->next;
    }
    free(tempDico);
  }
}

