/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

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

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     NUMBER = 258,
     IDENT = 259,
     START = 260,
     STOP = 261,
     STARTWHILE = 262,
     ENDWHILE = 263,
     STARTDO = 264,
     ENDDO = 265,
     STARTFOR = 266,
     ENDFOR = 267,
     STARTIF = 268,
     THEN = 269,
     ENDIF = 270,
     EXECUTE = 271,
     SET = 272,
     PROC = 273,
     FUNC = 274,
     IMPL = 275,
     IMPLIES = 276,
     ISEQ = 277,
     DECL = 278,
     TO = 279,
     ARRAY = 280,
     OF = 281,
     IS = 282,
     TYPEWORD = 283,
     TYPEARROW = 284,
     CONST = 285,
     VAR = 286,
     DECLARATION = 287,
     END = 288,
     PROGRAM = 289,
     TERMINATE = 290
   };
#endif
/* Tokens.  */
#define NUMBER 258
#define IDENT 259
#define START 260
#define STOP 261
#define STARTWHILE 262
#define ENDWHILE 263
#define STARTDO 264
#define ENDDO 265
#define STARTFOR 266
#define ENDFOR 267
#define STARTIF 268
#define THEN 269
#define ENDIF 270
#define EXECUTE 271
#define SET 272
#define PROC 273
#define FUNC 274
#define IMPL 275
#define IMPLIES 276
#define ISEQ 277
#define DECL 278
#define TO 279
#define ARRAY 280
#define OF 281
#define IS 282
#define TYPEWORD 283
#define TYPEARROW 284
#define CONST 285
#define VAR 286
#define DECLARATION 287
#define END 288
#define PROGRAM 289
#define TERMINATE 290




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

