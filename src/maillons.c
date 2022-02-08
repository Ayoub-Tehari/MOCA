#include "maillons.h"

void setCharnum(maillon_t* link, int k, char c) {
  if (link == NULL) {
  #ifdef KLEE
  assert(0);
  #endif
    printf("setCharnum : link null\n");
  } else {
    link->elem = (link->elem & ~getMask(k)) + ((unsigned int)charToNum(c) << (5*(5-k)));
  }
}

char getCharnum(maillon_t* link, int k) {
  if (link == NULL) {
    printf("getCharnum : link null\n");
    #ifdef KLEE
    assert(0);
    #endif
    return '#';
  } else {
    return numToChar((link->elem & getMask(k)) >> (5*(5-k)));
  }
}


int getSizeMaillon(maillon_t* link) {
  if (link == NULL) {
    return 0;
    #ifdef KLEE
    assert(0);
    #endif
  } else {
    int i = 0,res = 0;
    maillon_t* useLink = link;
    while(useLink != NULL) {
      for(i=0;i<=5;i++) {
	if  (isAvailable(getCharnum(useLink,i)) == 0) {break;}
	res++;
      }
      useLink = useLink->next;
    }
	return res;
  }
}


char* maillonToString(maillon_t* link) {
  if (link == NULL) {
    #ifdef KLEE
    assert(0);
    #endif
    return NULL;

  } else {
    char* word = (char*) malloc(sizeof(char)*getSizeMaillon(link)+1);
    maillon_t* useLink = link;
    int index = 0, i = 0;
    while (useLink != NULL) {
      for(i=0;i<=5;i++) {
	if (isAvailable(getCharnum(useLink,i)) == 0) {break;}
	else {
	  word[index] = getCharnum(useLink,i);
	  index++;
	}
      }
      useLink = useLink->next;
    }
    word[index] = '\0';//word[index+1] = '\0';
    free(useLink);
    return word;
  }
}
maillon_t* stringToMaillon(char* word) {
  if (word == NULL) {
  #ifdef KLEE
  assert(0);
  #endif
    return NULL;
  } else {
    maillon_t* useLink = (maillon_t*) malloc(sizeof(maillon_t));
    useLink->elem = 0;
    useLink->next = NULL;
    maillon_t* savLink = useLink;
    int i;
    for(i=0;i<strlen(word);i++) {
      if ((i % 6) == 0 && useLink->elem != 0) { 
	maillon_t* newLink = (maillon_t*) malloc(sizeof(maillon_t));
	newLink->elem = 0;
	newLink->next = NULL;
	useLink->next = newLink;
	useLink = newLink;
      }
      setCharnum(useLink,(i%6),word[i]);
    }
    return savLink;
  }
}

unsigned int inline getMask(int k) {
  switch(k) {
  case 0:
    return 0x3E000000;
    break;
  case 1:
    return 0x01F00000;
    break;
  case 2:
    return 0x000F8000;
    break;
  case 3:
    return 0x00007C00;
    break;
  case 4:
    return 0x000003E0;
    break;
  case 5:
    return 0x0000001F;
    break;
  }
  #ifdef KLEE
  assert(0);
  #endif
  return 0x00000000;
}
