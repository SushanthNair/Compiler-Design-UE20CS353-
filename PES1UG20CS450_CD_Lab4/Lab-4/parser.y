%{
	#include "abstract_syntax_tree.c"
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	void yyerror(char* s); 											// error 
	int yylex(); 													// 
	extern int yylineno; 											// 
%}

%union																// 
{
	char* text;
	expression_node* exp_node;
}



%token <text> T_ID T_NUM

%type <exp_node> E T F


%start START


%%
START : ASSGN	{ 
					printf("Valid syntax\n");
	 				YYACCEPT;										// If 
	 			}


ASSGN : T_ID '=' E	{
						
                        display_exp_tree($3);
					}
	;

E : E '+' T 	{
                    $$ = init_exp_node("+", $1, $3);
				}
	| E '-' T 	{
				
                    $$ = init_exp_node("-", $1, $3);
				}
	| T 	{ $$ = $1; }
	;
	
	
T : T '*' F 	{
					
                    $$ = init_exp_node("*", $1, $3);
				}
	| T '/' F 	{
					
                    $$ = init_exp_node("/", $1, $3);
				}
	| F {
			
            $$ = $1;
		}
	;

F : '(' E ')' { $$ = $2; }
	| T_ID 	{
				
                $$ = init_exp_node($1, NULL, NULL);
			}
	| T_NUM 	{
					
                $$ = init_exp_node($1, NULL, NULL);
				}
	;

%%



void yyerror(char* s)
{
	printf("Error :%s at %d \n",s,yylineno);
}



int main(int argc, char* argv[])
{
	yyparse();
	return 0;
}
