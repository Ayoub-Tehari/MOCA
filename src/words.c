#include "words.h"
unsigned int current_line=1;
unsigned int current_col=1;
char *separators = SEP; 

mot_t* generateMot_t (char* word, unsigned int* line, unsigned int* colonne){
  mot_t* newLinkWord = (mot_t*) malloc(sizeof(mot_t));
  emplacement_t* location = (emplacement_t*) malloc(sizeof(emplacement_t));
  newLinkWord->tete_mot = stringToMaillon(word);
  newLinkWord->queue_mot = newLinkWord->tete_mot;  
  while (newLinkWord->queue_mot->next != NULL) 
	{ newLinkWord->queue_mot = newLinkWord->queue_mot->next; }  
  location->line = *line;
  location -> colonne = *colonne;
  location -> next = NULL;
  newLinkWord->tete_liste = location;
  newLinkWord->queue_liste = location;
  newLinkWord->queue_liste->next=NULL;
	return newLinkWord;
}


/*APPROUVEE !!!! */ 
char *next_word(FILE *f, unsigned int *nblin, unsigned int *nbcol){
  char s[100]; 
  char *res; 
  unsigned int i=0, startl = current_line, startc = current_col;
  char sep;
  sep = fgetc(f);
  while (strchr(separators,sep) != NULL  || sep == '\n') { 
    startc++;
    if (sep == '\n'){ 
      startl++; startc = 1;
    } 
    sep = fgetc(f);
  } 
  ungetc(sep,f);
  if (nblin != NULL) *nblin = startl;  
  if (nbcol != NULL) *nbcol = startc;
  while ((strchr(separators, s[i]=fgetc(f)) == NULL) && s[i] != '\n'){
    i++; startc++;
  }
  sep = s[i]; 
  s[i] = '\0';
  res = (char *)malloc(strlen(s)+1); 
  strcpy(res,s);
  while (strchr(separators,sep) != NULL  || sep == '\n') { 
    startc++;
    if (sep == '\n'){  
      startl++; startc = 1;
    } 
    sep = fgetc(f);
  } 
  ungetc(sep,f);
  current_line = startl;
  current_col = startc;
 
  return res;
}

int compareWord(mot_t* w1, mot_t* w2) {
  if ((w1 == NULL)&&(w2 == NULL)){
	#ifdef KLEE
	assert(0);
	#endif
	return 0;
  }
  if (w1 == NULL) {
	#ifdef KLEE
	assert(0);
	#endif
    return -1;
  } else if (w2 == NULL) {
	#ifdef KLEE
	assert(0);
	#endif
    return 1;
  } else {
    char* word1 = maillonToString(w1->tete_mot);
    char* word2 = maillonToString(w2->tete_mot);
    int minSize = (strlen(word1)<strlen(word2))?strlen(word1):strlen(word2);
    int i = 0;
    int pos = 0;
    while(i<minSize && pos == 0) {
      pos = (word1[i]<word2[i])?-1:(word1[i]>word2[i])?1:0;
      i++;
    }
    return (pos == 0 && strlen(word1) < strlen(word2))?-1:(pos == 0 && strlen(word1) > strlen(word2))?1:pos;
  }
}

void inline addTailWord(dico* dictionary, mot_t* linkWord) {
  dico* newDictionary = (dico*) malloc(sizeof(dico));
  newDictionary->mot = linkWord;
  newDictionary->next = NULL;
  if(dictionary->next == NULL) {
    dictionary->next = newDictionary;
  } else {
    newDictionary->next = dictionary->next;
    dictionary->next = newDictionary;
  }
}

dico* addHeadWord(dico* dictionary, mot_t* linkWord) {
  dico* newDictionary = (dico*) malloc(sizeof(dico));
  newDictionary->mot = linkWord;
  newDictionary->next = dictionary;
  return newDictionary;
  printf("{%s}\n", maillonToString(dictionary->mot->tete_mot));
}

void inline incWord(emplacement_t* location, unsigned int line, unsigned int colonne) {
  emplacement_t* newLocation = (emplacement_t*) malloc(sizeof(emplacement_t));
  emplacement_t* tempLocation = (emplacement_t*) malloc(sizeof(emplacement_t));//free
  tempLocation = location;
  newLocation->next = NULL;
  newLocation->line = line;
  newLocation->colonne = colonne;
  while(tempLocation->next != NULL) {
    tempLocation = tempLocation->next;
  }
  tempLocation->next = newLocation;
  location = newLocation;
  
}

dico* insertDico(dico* dictionary, mot_t* linkWord) {
  dico* newDictionary = (dico*) malloc(sizeof(dico));
  dico* newDictionaryPrevious = (dico*) malloc(sizeof(dico));
  newDictionary = dictionary;
  newDictionaryPrevious = newDictionary;

  while(newDictionary != NULL&& compareWord(newDictionary->mot,linkWord)<0){
    if (newDictionary->next == NULL) {
      addTailWord(newDictionary,linkWord);
      return dictionary;
    } else {
      newDictionaryPrevious = newDictionary;
      newDictionary = newDictionary->next;
    }
  }

  if (compareWord(newDictionary->mot,linkWord)==0) { 
    incWord(newDictionary->mot->queue_liste,linkWord->tete_liste->line,linkWord->tete_liste->colonne);
  } else { //
    if (newDictionary == dictionary) {
      dictionary=addHeadWord(newDictionary,linkWord);
    } else {
      addTailWord(newDictionaryPrevious,linkWord);
    }
  }
  return dictionary;
}

dico* addToDico(dico* dictionary, char* word, unsigned int* line, unsigned int* colonne) {
  mot_t* newLinkWord = generateMot_t (word, line, colonne);
  if (dictionary == NULL) {  
    dico* newDictionary = (dico*) malloc(sizeof(dico));
    newDictionary->mot = newLinkWord;
    newDictionary->next = NULL;
    dictionary = newDictionary;
  } else if (dictionary->mot == NULL) {
    dictionary->mot = newLinkWord;
  } else {
    dictionary = insertDico(dictionary,newLinkWord);
  }
  return dictionary;
}

