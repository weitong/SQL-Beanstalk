/**
 * File: tree.c
 * Author: Wei Tong
 * Description: Syntax Tree, a Basic Data Structure.
 *
 * IDENTIFICATION
 *      tools/yayaccc/tree.c
 */
#include "./include/yayaccc.h"

/*
 * create a new node
 */
st_node *
create_node(uint_32 level) 
{
	st_node *new_node =  MALLOC(st_node);
	new_node->first_child = NULL;
	new_node->next_sibling = NULL;
	new_node->level = level;
	new_node->content = MALLOC(st_entry);
	new_node->content->tag = NIL_T;
	return new_node;
}

inline void 
traverse_wrap(int_32 (*trav_func)(st_node *, int_32), st_node *root) 
{
	traverse(trav_func, root, 0);
}

/**
 * traverse the tree by a preorder, and the trev_func
 * function is used to do something on each node. the
 * level used to tag the level of the node.
 */
void 
traverse(int_32 (*trav_func)(st_node *, int_32), st_node *root, int_32 level) 
{
	if ((*trav_func)(root, level) == 1) {
		if (NULL != root->first_child)
			traverse(trav_func, root->first_child, level + 1);
    	        if (NULL != root->next_sibling)
			traverse(trav_func, root->next_sibling, level);
	} else {
		if (NULL != root->next_sibling)
			traverse(trav_func, root->next_sibling, level);
	}
}

/*
 * get the first child of the  parent
 */
inline st_node *
get_first_child(st_node *parent) 
{
	return parent->first_child;
}

/*
 * get the sibling 
 */
inline st_node *
get_sibling(st_node *sibling) 
{
	return sibling->next_sibling;
}

/*
 * set the child node as a child of the parent node
 */
st_node *
insert_child(st_node *parent, st_node *cur) 
{
	st_node	*tmp = NULL, 
			*pose = NULL;
	int i = 0;

	if (NULL == parent || NULL == cur) 
		return parent;
	tmp = parent->first_child;
	
	if (NULL == tmp) {
		parent->first_child = cur;
		return parent;
	}
	
	while (NULL != tmp) {
		pose = tmp;
		tmp = tmp->next_sibling;
		++ i;
	}
	pose->next_sibling = cur;
	return parent;
}

/*
 * append a child of the parent
 */
st_node *
append_child(st_node *parent, st_node *cur)
{
        parent->first_child = cur;
        return cur;
}

/*
 * append a sibling of the node  
 */ 
st_node *
append_sibling(st_node *prev, st_node *cur) 
{       
        prev->next_sibling = cur;
        return cur;
}

/* construct a subtree with the params, and
   return the root of the root of the tree. */
st_node *
cons_subtree(int_32 num, ...) 
{
	st_node *root = create_node(0);
	st_node *child = NULL, *sibling = NULL;
	int_32 i;

	va_list arg_ptr;
	va_start(arg_ptr, num);

	for (i = 1; i <= num; ++i) {
		child = va_arg(arg_ptr, st_node *);
		root = insert_child(root, child);
	}
	va_end(arg_ptr);
	return root;
}

/* get the n th(rd/nd) child */
st_node *
get_child(st_node *parent, int_32 n) 
{
	st_node *child = parent->first_child;
	if (NULL == parent)
                return NULL;
	while (0 != n && NULL != child) {
		child = child->next_sibling;
		--n;
	}
	return child;
}

