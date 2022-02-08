#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
int main(){
	int i, j, k;
	srandom(getpid());

	char c;
	double r, d ;
	  for (k=0; k<100; k++) {
		for (i=0; i<10; i++) {
		   d = (double) random() * 20.0 / (double) RAND_MAX;
		   for (j = 0 ; j< d ; j++) {
			r = (double) random() * 25.0 / (double) RAND_MAX;
			c = (char) r + 'a';
			printf("%c",c);
		   }
		   
		   if ((random() * 20.0 / (double) RAND_MAX)<=1.0)
			printf(",");
		   printf(" ");
		}
		printf("\n");
	  }
	return 0;
}

