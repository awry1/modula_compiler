/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_MODULA_TAB_H_INCLUDED
# define YY_YY_MODULA_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    KW_ARRAY = 258,                /* KW_ARRAY  */
    KW_AND = 259,                  /* KW_AND  */
    KW_BEGIN = 260,                /* KW_BEGIN  */
    KW_CASE = 261,                 /* KW_CASE  */
    KW_CONST = 262,                /* KW_CONST  */
    KW_DIV = 263,                  /* KW_DIV  */
    KW_DO = 264,                   /* KW_DO  */
    KW_DOWNTO = 265,               /* KW_DOWNTO  */
    KW_ELSE = 266,                 /* KW_ELSE  */
    KW_ELSIF = 267,                /* KW_ELSIF  */
    KW_END = 268,                  /* KW_END  */
    KW_FOR = 269,                  /* KW_FOR  */
    KW_FROM = 270,                 /* KW_FROM  */
    KW_IF = 271,                   /* KW_IF  */
    KW_IMPORT = 272,               /* KW_IMPORT  */
    KW_IN = 273,                   /* KW_IN  */
    KW_LOOP = 274,                 /* KW_LOOP  */
    KW_MOD = 275,                  /* KW_MOD  */
    KW_MODULE = 276,               /* KW_MODULE  */
    KW_NOT = 277,                  /* KW_NOT  */
    KW_OF = 278,                   /* KW_OF  */
    KW_OR = 279,                   /* KW_OR  */
    KW_PROCEDURE = 280,            /* KW_PROCEDURE  */
    KW_RECORD = 281,               /* KW_RECORD  */
    KW_REPEAT = 282,               /* KW_REPEAT  */
    KW_THEN = 283,                 /* KW_THEN  */
    KW_TO = 284,                   /* KW_TO  */
    KW_TYPE = 285,                 /* KW_TYPE  */
    KW_UNTIL = 286,                /* KW_UNTIL  */
    KW_VAR = 287,                  /* KW_VAR  */
    KW_WHILE = 288,                /* KW_WHILE  */
    STRING_CONST = 289,            /* STRING_CONST  */
    CHAR_CONST = 290,              /* CHAR_CONST  */
    INTEGER_CONST = 291,           /* INTEGER_CONST  */
    FLOAT_CONST = 292,             /* FLOAT_CONST  */
    ASSIGN = 293,                  /* ASSIGN  */
    LE = 294,                      /* LE  */
    GE = 295,                      /* GE  */
    NEQ = 296,                     /* NEQ  */
    RANGE = 297,                   /* RANGE  */
    IDENT = 298,                   /* IDENT  */
    NEG = 299                      /* NEG  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 10 "modula.y"

	char s[MAX_STR_LEN + 1];
	int i;
	double d;

#line 114 "modula.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_MODULA_TAB_H_INCLUDED  */
