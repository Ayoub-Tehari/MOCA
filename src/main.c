//Include for tests
#include "CuTest.h"
#include "AllTests.h"

//Includes for dico.c
#include "dico.h"

#define FINAL 1

int main (int argc, char *argv[]) {
	#if FINAL
	deco(argc, argv);
	#else
	RunAllTests();
	#endif
	return 0;
}


