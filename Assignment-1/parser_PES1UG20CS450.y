%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	
	void yyerror (const char*);
	int yylex();
	extern int yylineno;
	extern char* yytext;
	int err = 0;
%}

%token T_INT T_ID T_CHAR T_DOUBLE T_FLOAT T_WHILE T_IF T_ELSE T_FOR T_DO T_INCLUDE T_MAIN T_STRLITERAL T_INC T_DEC T_EQCOMP T_NOTEQUAL T_GREATEREQ T_LESSEREQ T_OROR T_ANDAND T_NUM T_HEADER T_ARRAY

%start START

%%
START : PROG { if(err==0) {printf("Valid syntax\n"); YYACCEPT;} }
	;
	
	
PROG : T_INCLUDE '<' T_HEADER '>' PROG
       |MAIN PROG
       |DECLR ';' PROG
       | ASSGN ';' PROG
       | error ';' PROG
       |
       ;
     
DECLR : TYPE LISTVAR
	;
	
LISTVAR : LISTVAR ',' T_ID
	|ASSGN
	| ASSGN ',' LISTVAR
	| LISTVAR ',' ASSGN
	| ASSGN ',' ASSGN LISTVAR
	| T_ID
	|T_ARRAY
	|
	;
	 
TYPE : T_INT
       | T_FLOAT
       | T_DOUBLE
       | T_CHAR
       ;
       
ASSGN : T_ID '=' EXPR
	|
	;

EXPR : EXPR REL_OP E
       | E
       ;
      
E : E '+' T
    | E '-' T
    | T
    ;
    
T : T '*' F
    | T '/' F
    | F
    ;
    
F : '(' EXPR ')'
    | T_ID
    | T_INT
    | T_NUM
    ;

REL_OP : T_LESSEREQ
	 | T_GREATEREQ
	 | '<'
	 | '>'
	 | T_EQCOMP
	 | T_NOTEQUAL
	 | T_OROR
	 | T_ANDAND
	 ;
	 
MAIN : TYPE T_MAIN '(' LISTVAR ')' '{' STMT '}';

		
STMT : STMT_NO_BLOCK STMT
       | BLOCK STMT
       |
       ;
       
STMT_NO_BLOCK : DECLR ';'
	| ASSGN ';'
	| error ';'
	| T_IF EXPR STMT
	| T_IF EXPR STMT T_ELSE STMT
	| WHILE_S
	| DO_S
	| FOR_S
	| UNARY ';'
	;

UNARY: T_ID T_INC
	| T_ID T_DEC
	| T_INC T_ID
	| T_DEC T_ID
	;
BLOCK : '{' STMT '}';

WHILE_S: T_WHILE EXPR BLOCK
	;
DO_S: T_DO BLOCK T_WHILE EXPR ';'
	;

FOR_S: T_FOR '(' DECLR ';' EXPR ';' UNARY ')'BLOCK
	;

%%

void yyerror (const char* s){
	err=1;
	printf("%s at %d\n",s,yylineno);
}

int main()
{
	yyparse();
	return 0;
}
