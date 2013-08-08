%{

/* 
 * File: syn.y
 * Author: Wei Tong
 * 
 * IDENTIFICATION
 *	tools/yayaccc/syn.y
 */



#include "./include/yayaccc.h"
#include "lex.yy.c"

st_node	*tree_root = (st_node *)0;

inline void 
set_content(st_node **node, int_32 line, char *name) 
{
	(*node)->content->line = line;
	((*node)->content)->name = (char *)malloc(sizeof(char)*(strlen(name) + 1));
	memcpy((*node)->content->name, name, strlen(name)+1);

	(*node)->content->str_value = NULL;
}

%}

/* declared tokens */
%union {
        char *str_value;
        st_node *node_value;
};

%token <node_value> NAME COLON SEMI VBAR STRING
%type <node_value> rule cons_list cons node_list rules rule_list
	

%%


rules
	: rule_list {
		JOUT("SYNTAX: rules -> rule_list\n");
		$$ = cons_subtree(1, $1);
		set_content(&$$, @$.first_line, "rules");
		tree_root = $$;
	};

rule_list
	: rule {
		JOUT("SYNTAX: rule_list -> rule \n");
		$$ = cons_subtree(1, $1);
		set_content(&$$, @$.first_line, "rule_list"); 
	}
	| rule rule_list {
		JOUT("SYNTAX: rule_list -> rule rule_list \n");
		$$ = cons_subtree(2, $1, $2);
		set_content(&$$, @$.first_line, "rule_list"); 
	};

rule
	: NAME COLON cons_list SEMI {
		JOUT("SYNTAX: rule -> NAME \n");
		$$ = cons_subtree(4, $1, $2, $3, $4);
		set_content(&$$, @$.first_line, "rule");
	};

cons_list
        : cons {
		JOUT("SYNTAX: cons_list -> cons \n");
		$$ = cons_subtree(1, $1);
		set_content(&$$, @$.first_line, "cons_list"); 	
        }
        | cons VBAR cons_list {
		JOUT("SYNTAX: cons_list -> cons VBAR \n");
		$$ = cons_subtree(3, $1, $2, $3);
		set_content(&$$, @$.first_line, "cons_list"); 	
        };

cons
	: {
		JOUT("SYNTAX: cons -> NULL  \n");
		$$ = cons_subtree(1, NULL);
		set_content(&$$, @$.first_line, "cons"); 	
	}
	| node_list {
		JOUT("SYNTAX: cons -> node_list \n");
		$$ = cons_subtree(1, $1);
		set_content(&$$, @$.first_line, "cons"); 	
	};


node_list
	: NAME {
		JOUT("SYNTAX: node_list -> NAME \n"); 
                $$ = cons_subtree(1, $1);
		set_content(&$$, @$.first_line, "node_list"); 	
	}
	| NAME node_list {
		JOUT("SYNTAX: node_list -> NAME node_list \n");
		$$ = cons_subtree(2, $1, $2);
		set_content(&$$, @$.first_line, "node_list"); 	
	};
%%

yyerror(char *msg) 
{
	g_error_syn ++;
	g_error ++;
	fprintf(stderr, "[%d]Error type at line %d: %s\n", g_error, g_lineno, msg);
}
