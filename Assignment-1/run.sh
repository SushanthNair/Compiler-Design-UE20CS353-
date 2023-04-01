lex lex_PES1UG20CS450.l
yacc -d parser_PES1UG20CS450.y
gcc lex.yy.c y.tab.c -ll
./a.out < assignment-1_nested_do_while_valid.c > output_nested_do_while.txt
./a.out < assignment-1_nested_for_valid.c > output_nested_for.txt
./a.out < assignment-1_simple_do_while_valid.c > output_simple_do_while.txt
./a.out < assignment-1_simple_for_valid.c > output_simple_for.txt
./a.out < assign-1_test-1_invalid.c > output_invalid-1.txt
./a.out < assign-1_test-2_invalid.c > output_invalid-2.txt
