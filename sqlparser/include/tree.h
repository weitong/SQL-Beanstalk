/*
 * File: tree.h
 *      
 * Author: Wei Tong
 * 
 * This file includes a definition of the operations on syntax tree.
 *
 * IDENTIFICATION
 *      sqlparser/include/tree.h
 *
 */

#ifndef __SQLPARSER_INCLUDE_TREE_H__
#define __SQLPARSER_INCLUDE_TREE_H__

typedef struct __node_entry     st_entry;
typedef struct __tree_node      st_node;
typedef enum __type_tag         en_type_tag;

/* enumeratet the node type tag */
enum __type_tag {
        STR_T, 
        INT_T, 
        FLOAT_T, 
        RES_T,
        SCOMMENT_T,
        MCOMMENT_T,
        NIL_T
};

/*  the entry of the tree node */
struct __node_entry {
        char            *name;          // name of the syntax element
        en_type_tag     tag;            // tag of the syntax element
        int             line;           // lexical line
        int             terminate;      // 
        unsigned int    lno;            // lexical number
        int             rule;
        int             id;
        union {
                float   float_value;
                char    *str_value;
                int     int_value;
        };
};

/* definition of the tree node structure */
struct __tree_node {
        st_entry                *content;
        int                     level;
        struct __tree_node      *first_child, 
                                *next_sibling;
};

/* 
 * create a new tree node
 */
st_node *
create_node(unsigned int level);

/*
 * traverse the tree by a preorder, and the trev_func function is 
 * used to do some specified jobs on each node. The level is used 
 * to tag the level of the node.
 */
void 
traverse(int (*trav_func)(st_node *, int), st_node *root, int level);

void 
traverse_wrap(int (*trav_func)(st_node *, int), st_node *root);


/* 
 * get the nth(rd/nd) child
 */
st_node *
get_child(st_node *p, int c);

/*
 * set the child node as a child of the parend node 
 */
st_node *
append_child(st_node *parent, st_node *cur);

/* 
 * append a sibling of the node.
 */
st_node *
append_sibling(st_node *prev, st_node *cur);

/*
 * construct a subtree with params, and return the root of the tree. 
 */
st_node *
cons_subtree(int num, ...);

/* 
 * find the tree node in root with node id
 */


#endif /* __SQLPARSER_INCLUDE_TREE_H__ */
