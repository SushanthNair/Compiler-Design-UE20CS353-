#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sym_tab.h"

table* init_table()	
{
	/*
        allocate space for table pointer structure eg (t_name)* t
        initialise head variable eg t->head
        return structure
    	*/
    table* t = (table*)malloc(sizeof(table));
    t->head = NULL;
    return t;
}

symbol* init_symbol(char* name, int size,char* value, int type, int lineno, int scope) //allocates space for items in the list
{
	/*
        allocate space for entry pointer structure eg (s_name)* s
        initialise all struct variables(name, value, type, scope, length, line number)
        return structure
    	*/
    symbol* s = (symbol*)malloc(sizeof(symbol));
    s->name = name;
    s->val = value;
    s->type = type;
    s->scope = scope;
    s->len = size;
    s->line = lineno;
    s->next = NULL;
    return s;
}

void insert_symbol(table* t,char* name, int size,char* value, int type, int lineno, int scope)/* 
 arguments can be the structure s_name already allocated before this function call
 or the variables to be sent to allocate_space_for_table_entry for initialisation        
*/
{
    /*
        check if table is empty or not using the struct table pointer
        else traverse to the end of the table and insert the entry
    */
    symbol* s = t->head;
    symbol* q = init_symbol(name, size, value, type, lineno, scope);
    if(s == NULL)
    {
        s->next = q;
    }
    while(s->next!=NULL)
    {
        s = s->next;
    }
    s->next = q;
}

int check_sym_tab(table* t,char* name) //return a value like integer for checking
{
    /*
        check if table is empty and return a value like 0
        else traverse the table
        if entry is found return a value like 1
        if not return a value like 0
    */
    symbol* s = t->head;
    while(s!=NULL)
    {
        if(strcmp(s->name,name)==0)
        {
            return 1;
        }
        s = s->next;
    }
    return 0;
}

void insert_val(table* t,char* name,char* value,int line)
{
    /*
        if value is default value return back
        check if table is empty
        else traverse the table and find the name
        insert value into the entry structure
    */
    symbol* s = t->head;
    while(s!=NULL)
    {
        if(strcmp(s->name,name)==0)
        {
            s->val = value;
            s->line = line;
            return;
        }
        s = s->next;
    }
}

void display_sym_tab(table* t)
{
    /*
        traverse through table and print every entry
        with its struct variables
    */
    symbol* s = t->head;
    printf("NAME\tLENGTH\tTYPE\tVALUE\tLINENO\tSCOPE\n");
    while(s!=NULL)
    {
        printf("%s\t%d\t%d\t%s\t%d\t%d\n",s->name,s->len,s->type,s->val,s->line,s->scope);
        s = s->next;
    }
}