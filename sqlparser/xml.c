/*
 * File: xml.c
 * Author: Wei Tong
 *
 * This file is used to generate xml file, which is used to 
 * represented the syntax tree.
 *
 * IDENTIFICATION
 *      sqlparser/xml.c
 */


#include "./include/parser.h"

#define OUTPUT stdout


/*      
 * generate_xml    
 *      generate the xml of the syntax tree
 *
 */
void 
generate_xml(st_node *root, int_32 level) 
{  
        if (NULL == root->content) goto sibling;
        if (strcmp("empty", root->content->name) == 0) goto sibling ;

        /* 
         * if the node is a terminated node, eg. STRING, INT, FLOAT ... 
         * 
         */

        if (STR_T == root->content->tag) {
                fprintf(OUTPUT, "<STRING name=\"%s\" t=\"1\" id=\"%d\" lex=\"%d\">", root->content->name, \
                                root->content->id, root->content->lno);
                fprintf(OUTPUT, "%s", root->content->str_value);
                fprintf(OUTPUT, "</STRING>\n");
        } else if (INT_T == root->content->tag) {
                fprintf(OUTPUT, "<INT name=\"%s\" t=\"1\" id=\"%d\" lex=\"%d\">", root->content->name, \
                                root->content->id, root->content->lno);
                fprintf(OUTPUT, "%d", root->content->int_value);
                fprintf(OUTPUT, "</INT>\n");
        } else if (FLOAT_T == root->content->tag) {
                fprintf(OUTPUT, "<FLOAT name=\"%s\" t=\"1\" id=\"%d\" lex=\"%d\">", root->content->name, \
                                root->content->id, root->content->lno);
                fprintf(OUTPUT, "%f", root->content->float_value);
                fprintf(OUTPUT, "</FLOAT>\n");  
        } 

        /* 
         * if the node is a internal node, ...
         *
         *
         */
        else {
                if (0 == root->content->terminate) {
                        fprintf(OUTPUT, "<%s t=\"0\" id=\"%d\" rule=\"%d\">\n", root->content->name, \
                                root->content->id, root->content->rule);
                        if (NULL != root->first_child) 
                                generate_xml(root->first_child, level + 1);
                        fprintf(OUTPUT, "</%s>\n", root->content->name);

                } else {
                        fprintf(OUTPUT, "<%s name=\"%s\" t=\"1\" id=\"%d\" lex=\"%d\">", root->content->name, \
                                        root->content->name, root->content->id, root->content->lno);
                        fprintf(OUTPUT, "%s", root->content->name);
                        if (NULL != root->first_child)
                                generate_xml(root->first_child, level + 1);
                        fprintf(OUTPUT, "</%s>\n", root->content->name);
                }
        }



sibling:
        if (NULL != root->next_sibling)
                generate_xml(root->next_sibling, level);
}

