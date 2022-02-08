#les declarations des variables

OBJDIR=objs
INCDIR=include
SRCDIR=src

TESTS=$(wildcard tests/*.txt)
SRCS=$(wildcard $(SRCDIR)/*.c)
INCS=$(wildcard $(INCDIR)/*.h)

OBJS=$(patsubst src%.c, objs%.o, $(SRCS))

PROG=projet2
PROGS=$(OBJDIR)/$(PROG)
MAIN_TEST=prog_tests

ifdef klee
CC=wllvm
CFLAGS=-Wall -g 
CFLAGS_MAIN= $(CFLAGS)
LDFLAGS =-L${KLEE}/lib -lkleeRuntest
else
CC=gcc


ifdef gcov
CFLAGS=-Wall -fprofile-arcs -ftest-coverage
LDFLAGS = -fprofile-arcs -ftest-coverage
else 
ifdef sanitize
CFLAGS=-fsanitize=$(sanitize) -Wall -g
LDFLAGS =-fsanitize=$(sanitize)
else
CFLAGS=-Wall -g
LDFLAGS =
endif
endif
#test pour produire ou non la bibliotheque dynamique
ifdef N
CFLAGS_MAIN=$(CFLAGS) -fPIC
else
#test pout le niveau d'optimisation
ifdef O
CFLAGS_MAIN=$(CFLAGS) -O${O}
else 
CFLAGS_MAIN=$(CFLAGS)
endif
endif
endif


#les règles qui génèrent les programmes
all: $(OBJDIR)/$(PROG)
all_S_library: $(PROG_S_LIB)
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(PWD)/
all_D_library: $(PROG_D_LIB)
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(PWD)/

all_tests : $(MAIN_TEST)

#règle pour générer les objets
$(OBJDIR)/%.o : $(SRCDIR)/%.c $(INCDIR)/%.h $(INCDIR)/types.h
	$(CC) $(CFLAGS_MAIN) -c $< -I $(INCDIR) -o $@

ifdef klee
#règle pour générer les objets
$(OBJDIR)/dico.o : $(SRCDIR)/dico.c $(INCDIR)/dico.h $(INCDIR)/types.h ${KLEE}/include/klee/klee.h
	$(CC) $(CFLAGS_MAIN) -c $< -I${KLEE}/include -I $(INCDIR) -DKLEE -o $@
endif

#fichier qui contient le main
$(OBJDIR)/main.o : $(SRCDIR)/main.c $(INCDIR)/dico.h $(INCDIR)/AllTests.h $(INCDIR)/CuTest.h
	$(CC) $(CFLAGS) -c $< -I $(INCDIR) -o $@ 

$(OBJDIR)/AllTests.o : $(SRCDIR)/AllTests.c $(INCDIR)/AllTests.h $(INCDIR)/SuiteDeTests.h $(INCDIR)/CuTest.h


#règle sans avoir besoin des bibliothèque	
$(OBJDIR)/$(PROG) : $(OBJDIR)/main.o $(OBJDIR)/dico.o $(OBJDIR)/words.o $(OBJDIR)/maillons.o $(OBJDIR)/display.o $(OBJDIR)/AllTests.o $(OBJDIR)/CuTest.o $(OBJDIR)/SuiteDeTests.o
	$(CC) $(LDFLAGS) -o $@ $^
ifdef klee
	extract-bc $@
endif
#regle de la procedure profilling
profiling : $(SRCS)
	$(CC) $(CFLAGS) -pg -c src/dico.c -I $(INCDIR) -o objs/dico.o
	$(CC) $(CFLAGS) -pg -c src/words.c -I $(INCDIR) -o objs/words.o
	$(CC) $(CFLAGS) -pg -c src/maillons.c -I $(INCDIR) -o objs/maillons.o
	$(CC) $(CFLAGS) -pg -c src/display.c -I $(INCDIR) -o objs/display.o
	$(CC) $(CFLAGS) -pg -c src/AllTests.c -I $(INCDIR) -o objs/AllTests.o
	$(CC) $(CFLAGS) -pg -c src/CuTest.c -I $(INCDIR) -o objs/CuTest.o
	$(CC) $(CFLAGS) -pg -c src/SuiteDeTests.c -I $(INCDIR) -o objs/SuiteDeTests.o
	$(CC) $(CFLAGS) -pg -c $(SRCDIR)/main.c -I $(INCDIR) -o $(OBJDIR)/main.o 
	$(CC) -pg -o $(OBJDIR)/$(PROG) $(OBJS)
	./$(OBJDIR)/$(PROG) $(TESTS)
	gprof -Pdeco ./$(OBJDIR)/$(PROG)

doc : 
	doxygen 
	cd latex
	make pdf
	cd ..

#règle de creation de la bibliothèque statique
libutilitaires.a : $(OBJDIR)/words.o $(OBJDIR)/maillons.o $(OBJDIR)/display.o
	ar r $@ $^
	ranlib $@

#règle de creation de la bibliothèque dynamique
libutilitairesD.so : $(OBJDIR)/words.o $(OBJDIR)/maillons.o $(OBJDIR)/display.o
	$(CC) -shared -o $@ $^
	
#règle de l'édition des liens au cas d'invocation des bibliothèques 
$(PROG_S_LIB) : $(OBJDIR)/dico.o libutilitaires.a  
	$(CC) -o $(PROG_S_LIB) $< -Wl,-Bstatic -l utilitaires -L .
#Option -Wl,-Bstatic pour forcer un link statique
#option -Wl,-Bdynamic pour forcer un link dynamique 
$(PROG_D_LIB) : $(OBJDIR)/dico.o libutilitairesD.so  
	$(CC) -o $(PROG_D_LIB) $< -Wl,-Bdynamic -l utilitairesD -L .


clean : 
	@echo " deleting object files, libraries and programs"
	-rm -rf $(OBJDIR)/* $(PROGS) *.so *.a dictionnaires.txt
	touch dictionnaires.txt
