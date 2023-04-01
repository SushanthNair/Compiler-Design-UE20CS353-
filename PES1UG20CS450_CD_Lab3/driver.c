#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include"sym_tab.h"

int main()
{
    int x,size,type,lineno,scope,wish;
    char *name,*value;
    table* t = init_table();
    do
    {
        printf("enter a choice: 1.enter a symbol 2.view table 3.update value 4.exit\n");
        scanf("%d",&x);
        switch(x)
        {
            case 1: printf("enter name,size,value,type,lineno and scope\n"); 
                    scanf("%s %d %s %d %d %d",name,&size,value,&type,&lineno,&scope);
                    insert_symbol(t,name,size,value,type,lineno,scope);
            break;
            case 2: display_sym_tab(t);
            break;
            case 3: printf("enter symbol name,new value and lineno\n");
                    scanf("%s %s %d",name,value,&lineno);
                    insert_val(t,name,value,lineno);
            break;
            case 4: exit(0);
            default: printf("enter valid number\n");
        }
        printf("do you wish to continue?\n");
        scanf("%d",&wish);
    }
    while(wish==1);
    return 0;
}