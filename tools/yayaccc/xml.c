/*
 * File: xml.c
 * Author: Wei Tong
 *
 * This file is used to generate xml file, which is used to 
 * represented the syntax tree.
 *
 *
  * IDENTIFICATION
 *      tools/yayaccc/xml.c
 */


#include "./include/yayaccc.h"

void 
generate_xml(st_node *root, int_32 level) 
{
        if (0 == strcmp("null", root->content->name)) 
                goto sibling ;

        if (root->content->str_value != NULL) {
                if (root->content->str_value[0] == '\'') {
                        printf("<%s value=\"TOKEN___\">\n", root->content->name);
                } else {
                        printf("<%s value=\"%s\">\n", root->content->name, root->content->str_value);
                }
        } else {
                printf("<%s>\n", root->content->name);
        }
	
        if (NULL != root->first_child)
                generate_xml(root->first_child, level + 1);
        
        printf("</%s>\n", root->content->name);

sibling:
        if (NULL != root->next_sibling)
                generate_xml(root->next_sibling, level);
}

