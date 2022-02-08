#include "SuiteDeTests.h"


char *StrToUpper (char *str){
  return str;
}

void PremierTestPourJouerAvecFrameworkCuTest (CuTest * tc){
  char *input = strdup ("hello world");
  char *actual =  StrToUpper (input);
  char *expected = "HELLO WORLD";
  CuAssertStrEquals (tc, expected, actual);
}

void ConvesionMaillonStringTest (CuTest * tc){
  char *input = strdup ("");
  char *actual = maillonToString(stringToMaillon(input));
  char *expected = "";
  CuAssertStrEquals (tc, expected, actual);
  input = strdup ("a");
  actual = maillonToString(stringToMaillon(input));
  expected = "a";
  CuAssertStrEquals (tc, expected, actual);
  input = strdup ("modification");
  actual = maillonToString(stringToMaillon(input));
  expected = "modification";
  CuAssertStrEquals (tc, expected, actual);
}

void GetSizeMaillonTest (CuTest *tc){
  maillon_t* input = (stringToMaillon("azertyuiopqsdfghjklmwxcvbn"));
  int actual = getSizeMaillon(input);
  int expected = 26;
  CuAssertIntEquals (tc, expected, actual);
  input = (stringToMaillon(""));
  actual = getSizeMaillon(input);
  expected = 0;
  CuAssertIntEquals (tc, expected, actual);
  input = (stringToMaillon("azert"));
  actual = getSizeMaillon(input);
  expected = 5;
  CuAssertIntEquals (tc, expected, actual);
}

void CompareWordTest (CuTest *tc) {
	unsigned int *a = (unsigned int *) malloc (sizeof (unsigned int));
	*a = 1;
	mot_t* w1 = generateMot_t("", a, a);
	mot_t* w2 = generateMot_t("he", a, a);
	int actual = compareWord(w1, w2);
	int expected = -1;
	CuAssertIntEquals (tc, expected, actual);

	w1 = generateMot_t("", a, a);
	w2 = generateMot_t("helloworld", a, a);
	actual = compareWord(w1, w2);
	expected = -1;
	CuAssertIntEquals (tc, expected, actual);

	w1 = NULL;
	w2 = generateMot_t("he", a, a);
	actual = compareWord(w1, w2);
	expected = -1;
	CuAssertIntEquals (tc, expected, actual);

	w1 = generateMot_t("helloworld", a, a);
	w2 = generateMot_t("helloworld", a, a);
	actual = compareWord(w1, w2);
	expected = 0;
	CuAssertIntEquals (tc, expected, actual);

	w1 = generateMot_t("", a, a);
	w2 = generateMot_t("", a, a);
	actual = compareWord(w1, w2);
	expected = 0;
	CuAssertIntEquals (tc, expected, actual);

	w1 = NULL;
	w2 = NULL;
	actual = compareWord(w1, w2);
	expected = 0;
	CuAssertIntEquals (tc, expected, actual);

	w1 = generateMot_t("", a, a);
	w2 = NULL;
	actual = compareWord(w1, w2);
	expected = 1;
	CuAssertIntEquals (tc, expected, actual);

        w1 = generateMot_t("hellow", a, a);
	w2 = generateMot_t("hello", a, a);
	actual = compareWord(w1, w2);
	expected = 1;
	CuAssertIntEquals (tc, expected, actual);

        w1 = generateMot_t("helloworlda", a, a);
	w2 = generateMot_t("helloworld", a, a);
	actual = compareWord(w1, w2);
	expected = 1;
	CuAssertIntEquals (tc, expected, actual);
}



CuSuite *MaTestSuite (){
  CuSuite *suite = CuSuiteNew ();
 // SUITE_ADD_TEST (suite, PremierTestPourJouerAvecFrameworkCuTest);
  SUITE_ADD_TEST (suite, ConvesionMaillonStringTest);
  SUITE_ADD_TEST (suite, GetSizeMaillonTest);
  SUITE_ADD_TEST (suite, CompareWordTest);
  
  return suite;
}



