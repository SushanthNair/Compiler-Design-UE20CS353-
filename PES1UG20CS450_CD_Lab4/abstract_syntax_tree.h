typedef struct expression_node
{
    struct expression_node *left, *right;
    char* value;
}expression_node;

expression_node* init_exp_node(char* val, expression_node* left, expression_node* right);
void display_exp_tree(expression_node* exp_node);
