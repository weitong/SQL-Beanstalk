/* 
 * File: main.c
 * Author: Wei Tong
 * 
 * IDENTIFICATION
 *      sqlparser/main.c
 */

#include "./include/parser.h"
#include "assert.h"

extern FILE             *yyin;
extern st_node          *tree_root;
extern uint_32          g_error;

extern const st_scan_keyword scan_keywords[];
extern const int num_scan_keywords;

static inline void 
output_xml() 
{
        printf("<?xml version=\"1.0\"?>\n");
        if (tree_root != NULL) {
                generate_xml(tree_root, 1);
        } else {
                fprintf(stderr, "%s\n", "tree_root is NULL;");
        }
}

int
main(int argc, char **argv) 
{
        int i = 0;
        if (argc > 1) {
                if (!(yyin = fopen(argv[1], "r"))) {
                perror(argv[1]);
                return 1;
                }
        }
        yyrestart(yyin);
        yyparse();

	if (g_error > 0) {
	       fprintf(stderr, "Damn Error\n");
	       return 1;
	}
        output_xml();
        return 0;
}