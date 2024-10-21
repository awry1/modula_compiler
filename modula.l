%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define MAX_STR_LEN	100
#include "modula.tab.h"
int process_token(const char *text, const char *TokenType,
    const char *TokenVal, const int TokenID); 
char *strnncpy(char *dst, const char *src, const int n);
int start_line;
%}

/* stany analizatora leksykalnego (INITIAL jest zdefiniowany) */
%option yylineno
%x ST_COMMENT
%x ST_DQ_STRING
%x ST_AP_STRING

%%

    /* słowa kluczowe */
(?i:AND) return process_token(yytext, "KW_AND", "", KW_AND);
(?i:BEGIN) return process_token(yytext, "KW_BEGIN", "", KW_BEGIN);
(?i:CONST) return process_token(yytext, "KW_CONST", "", KW_CONST);
(?i:DIV) return process_token(yytext, "KW_DIV", "", KW_DIV);
(?i:DO) return process_token(yytext, "KW_DO", "", KW_DO);
(?i:ELSE) return process_token(yytext, "KW_ELSE", "", KW_ELSE);
(?i:ELSIF) return process_token(yytext, "KW_ELSIF", "", KW_ELSIF);
(?i:END) return process_token(yytext, "KW_END", "", KW_END);
(?i:FOR) return process_token(yytext, "KW_FOR", "", KW_FOR);
(?i:FROM) return process_token(yytext, "KW_FROM", "", KW_FROM);
(?i:IF) return process_token(yytext, "KW_IF", "", KW_IF);
(?i:IMPORT) return process_token(yytext, "KW_IMPORT", "", KW_IMPORT);
(?i:IN) return process_token(yytext, "KW_IN", "", KW_IN);
(?i:MOD) return process_token(yytext, "KW_MOD", "", KW_MOD);
(?i:MODULE) return process_token(yytext, "KW_MODULE", "", KW_MODULE);
(?i:NOT) return process_token(yytext, "KW_NOT", "", KW_NOT);
(?i:PROCEDURE) return process_token(yytext, "KW_PROCEDURE", "", KW_PROCEDURE);
(?i:OR) return process_token(yytext, "KW_OR", "", KW_OR);
(?i:THEN) return process_token(yytext, "KW_THEN", "", KW_THEN);
(?i:TYPE) return process_token(yytext, "KW_TYPE", "", KW_TYPE);
(?i:TO) return process_token(yytext, "KW_TO", "", KW_TO);
(?i:VAR) return process_token(yytext, "KW_VAR", "", KW_VAR);
(?i:WHILE) return process_token(yytext, "KW_WHILE", "", KW_WHILE);
(?i:REPEAT) return process_token(yytext, "KW_REPEAT", "", KW_REPEAT);
(?i:UNTIL) return process_token(yytext, "KW_UNTIL", "", KW_UNTIL);
(?i:LOOP) return process_token(yytext, "KW_LOOP", "", KW_LOOP);
(?i:CASE) return process_token(yytext, "KW_CASE", "", KW_CASE);
(?i:OF) return process_token(yytext, "KW_OF", "", KW_OF);
(?i:ARRAY) return process_token(yytext, "KW_ARRAY", "", KW_ARRAY);
(?i:RECORD) return process_token(yytext, "KW_RECORD", "", KW_RECORD);
(?i:DOWNTO) return process_token(yytext, "KW_DOWNTO", "", KW_DOWNTO);

    /* usuwanie białych znaków */
[ \t\n]+ ;

    /* operatory dwuznakowe */
":=" return process_token(yytext, "ASSIGN", "", ASSIGN);
"<=" return process_token(yytext, "LE", "", LE);
">=" return process_token(yytext, "GE", "", GE);
"<>" return process_token(yytext, "NEQ", "", NEQ);
".." return process_token(yytext, "RANGE", "", RANGE);

    /* identyfikatory */
[A-Za-z_][A-Za-z0-9_]* return process_token(yytext, "IDENT", yytext, IDENT);

    /* stałe całkowite */
[0-9]+ return process_token(yytext, "INTEGER_CONST", yytext, INTEGER_CONST);

    /* stałe zmiennoprzecinkowe */
(([0-9]+\.[0-9]*)|([0-9]*\.[0-9]+))([eE][+-]?[0-9]+)? return process_token(yytext, "REAL_CONST", yytext, REAL_CONST);

    /* napisy w cudzysłowach */
\"[^\"\n]*\" return process_token(yytext, "STRING_CONST", yytext, STRING_CONST);

    /* stałe znakowe w apostrofach */
\'[^\']\' return process_token(yytext, "CHAR_CONST", yytext, CHAR_CONST);

    /* symbole końcowe */
[+\-*/=<>|&\\,.;:()\[\]] return process_token(yytext, yytext, "", IDENT);

    /* napisy w cudzysłowach (na warunkach początkowych) */
<INITIAL>\" { BEGIN(ST_DQ_STRING); yymore(); }
<ST_DQ_STRING>\" { BEGIN(INITIAL); return process_token(yytext, "STRING_CONST", yytext, STRING_CONST); }
<ST_DQ_STRING>. yymore();
<ST_DQ_STRING>\n { printf("Brak końca napisu"); BEGIN(INITIAL); }

    /* stałe znakowe w apostrofach (na warunkach początkowych) */
<INITIAL>\' { BEGIN(ST_AP_STRING); yymore(); }
<ST_AP_STRING>\' { BEGIN(INITIAL); return process_token(yytext, "STRING_CONST", yytext, STRING_CONST); }
<ST_AP_STRING>. yymore();
<ST_AP_STRING>\n { printf("Brak końca znaku"); BEGIN(INITIAL); }

    /* komentarze (na warunkach początkowych) */
<INITIAL>"(*" { yymore(); BEGIN(ST_COMMENT); start_line = yylineno; }
<ST_COMMENT>.|\n { yymore(); }
<ST_COMMENT>"*)" { BEGIN(INITIAL); }
<ST_COMMENT><<EOF>> { printf("Komentarz otwarty w lini %d nie został zamknięty\n", start_line); BEGIN(INITIAL); }
<INITIAL>"*)" { printf("Komentarz zamknięty w lini %d kiedy żaden nie został otwarty\n", yylineno); }


%%

int yywrap() {
  return 1; /* konieczne!!! */
}

/* Nazwa:	strnncpy
 * Cel:		Kopiuje zadaną liczbę znaków napisu umieszczając na końcu
 *		znak o kodzie 0.
 * Parametry:	dst		- (o) napis, do którego ma nastąpić kopiowanie;
 *		src		- (i) napis, który ma być kopiowany;
 *		n		- (i) maksymalna liczba znaków do kopiowania.
 * Zwraca:	dst.
 * Uwagi:	strncpy nie umieszcza znaku o kodzie 0 za kopiowanym napisem.
 *		Napis docelowy musi mieć miejsce na dodatkowy n+1 znak.
 */
char *
strnncpy(char *dst, const char *src, const int n)
{
  if (n > 0) {
    strncpy(dst, src, n);
  }
  dst[n] = '\0';
  return dst;
}   /*strnncpy*/

/* Nazwa:       process_token
 * Cel:         Wypisanie informacji o wykrytym elemencie i przekazanie
 *              tej informacji wyżej z ewentualną wartością elementu, jeśli
 *              takowa występuje.
 * Parametry:   text            - (i) tekst, do którego nastąpiło dopasowanie;
 *              TokenType       - (i) napis będący tekstową reprezentacją
 *                                      nazwy typu elementu;
 *              TokenVal        - (i) wartość elementu, o ile występuje;
 *              TokenID         - (i) identyfikator typu elementu zadeklarowany
 *                                      za pomocą dyrektywy %token
 *                                      w pliku modula.y lub kod pojedynczego
 *					znaku (w pliku analizatora składniowego
 *					występuje ujęty w apostrofy).
 * Zwraca:      Identyfikator typu elementu (TokenID).
 * Uwagi:       Informacja o wykrytym elemencie zwracana jest
 *              w trzech kolumnach. W pierwszej wypisywany jest tekst,
 *              do którego nastąpiło dopasowanie, w drugiej - typ elementu,
 *              w trzeciej - wartość elementu (o ile występuje).
 */
int process_token(const char *text, const char *TokenType,
		  const char *TokenVal, const int TokenID)
{
  int l;
  printf("%-20.20s%-15s %s\n", text, TokenType, TokenVal);
  switch (TokenID) {

  case INTEGER_CONST:
    yylval.i = atoi(text); break;

  case REAL_CONST:
    yylval.d = atof(text); break;

  case IDENT:
    strncpy(yylval.s, text, MAX_STR_LEN); break;

  case STRING_CONST:
    l = strlen(text);
    strnncpy(yylval.s, TokenVal+1, l - 2 <= MAX_STR_LEN ? l - 1 : MAX_STR_LEN);
    break;

  }
  return(TokenID);
}
