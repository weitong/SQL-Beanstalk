/* 
 * File: main.c
 * Author: Wei Tong
 * 
 * IDENTIFICATION
 *      tools/yayaccc/main.c
 */

#include "./include/yayaccc.h"
#include "assert.h"

extern FILE     *yyin;
extern st_node  *tree_root;
extern uint_32  g_error;

static inline void 
output_xml() 
{       
        printf("<?xml version=\"1.0\"?>\n");
        generate_xml(tree_root, 1);
}


int
main(int argc, char **argv) 
{
        if (argc > 1) {
                if (!(yyin = fopen(argv[1], "r"))) {
                        perror(argv[1]);
                        return 1;
                }
        }
        yyrestart(yyin);
        yyparse();
	
	if (g_error > 0) {

		fprintf(stderr, "Damn Error %d, %d\n", g_error_lex, g_error_syn);	
		exit(-1);
	}
        
        output_xml();
        return 0;
}
