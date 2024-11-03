%{
#include <stdio.h>
#include <string.h>
#define MAX_STR_LEN	100
int yylex(void);
void yyerror(const char *txt);
void found(const char *nonterminal, const char *value);
%}

%union {
	char s[MAX_STR_LEN + 1];
	int i;
	double d;
}

%start GRAMMAR
/* keywords */
%token <i> KW_ARRAY KW_AND KW_BEGIN KW_CASE KW_CONST KW_DIV KW_DO KW_DOWNTO KW_ELSE KW_ELSIF KW_END KW_FOR KW_FROM KW_IF KW_IMPORT KW_IN KW_LOOP KW_MOD KW_MODULE KW_NOT KW_OF KW_OR KW_PROCEDURE KW_RECORD KW_REPEAT KW_THEN KW_TO KW_TYPE KW_UNTIL KW_VAR KW_WHILE
/* literal values */
%token <s> STRING_CONST CHAR_CONST
%token <i> INTEGER_CONST
%token <d> FLOAT_CONST
/* operators */
%token <i> ASSIGN LE GE NEQ RANGE
/* other */
%token <s> IDENT

%left '+' '-' KW_OR
%left '*' '/' KW_DIV KW_MOD KW_AND '&'
%left NEG KW_NOT

%%

GRAMMAR: TOKEN | GRAMMAR TOKEN | error;

TOKEN: KEYWORD | LITERAL_VALUE | OPERATOR | OTHER;

KEYWORD: KW_ARRAY | KW_AND | KW_BEGIN | KW_CASE | KW_CONST | KW_DIV | KW_DO | KW_DOWNTO | KW_ELSE | KW_ELSIF | KW_END | KW_FOR | KW_FROM | KW_IF | KW_IMPORT | KW_IN | KW_LOOP | KW_MOD | KW_MODULE | KW_NOT | KW_OF | KW_OR | KW_PROCEDURE | KW_RECORD | KW_REPEAT | KW_THEN | KW_TO | KW_TYPE | KW_UNTIL | KW_VAR | KW_WHILE;

LITERAL_VALUE: STRING_CONST | CHAR_CONST | INTEGER_CONST | FLOAT_CONST;

OPERATOR: ASSIGN | LE | GE | NEQ | RANGE;

OTHER: IDENT | ',' | ';' | '=' | ':' | '(' | ')' | '+' | '*' | '-' | '.' | '|' | '<' | '[' | ']';

%%

int main(void) {
	printf("Kamil Lubarski\n" );
	printf("yytext              Token type      Token value as string\n\n");
	yyparse();
	return(0);
}

void yyerror(const char *txt) {
	printf("%s\n", txt);
}

void found(const char *nonterminal, const char *value) {
	printf("===== FOUND: %s %s%s%s=====\n", nonterminal, (*value) ? "'" : "", value, (*value) ? "'" : "");
}
