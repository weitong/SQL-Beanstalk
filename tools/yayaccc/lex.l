%{
/* 
 * File: lex.l
 * Author: Wei Tong
 * 
 *
 * IDENTIFICATION
 *	tools/yayaccc/lex.l
 */

#include "syn.tab.h"
#include "./include/yayaccc.h"

int_32 	g_lineno 	= 1;
int_32 	g_columnno 	= 1;
uint_32 g_error 	= 0;

uint_32	g_error_lex 	= 0;
uint_32	g_error_syn 	= 0;

#define YY_USER_ACTION yylloc.first_line = yylloc.last_line = g_lineno; \
        yylloc.first_column = g_columnno; yylloc.last_column = g_columnno + yyleng-1; \
        g_columnno += yyleng;

static st_node *
create_token_node(char *name, en_type_tag tag, char *value);

%}

%%

"//".*$ {}
"/*"([*]*(([^*/])+([/])*)*)*"*/" {}

"{"[ \t]*"}" {}

[\n] { g_lineno++; }

[ \t\r]+ {}	/* white space */

":" {
	yylval.node_value = create_token_node("COLON",  RES_T, 0); 
	return COLON; 
}

"|" {
	yylval.node_value = create_token_node("VBAR",  RES_T, 0); 
	return VBAR; 
}

";" {
	yylval.node_value = create_token_node("SEMI", RES_T, 0); 
	return SEMI; 
}

[\%A-Za-z][A-Za-z0-9_]*|'[^'\n]*' {
	JOUT("LEX: NAME (%s)\n", yytext); 
	yylval.node_value = create_token_node("NAME", STR_T, yytext); 
	return NAME; 
}

. {
        g_error ++;
        g_error_lex ++;
        fprintf(stderr, "[%d]Error type 1 at line %d: Mysterious charact \'%s\'\n", \
                g_error, g_lineno, yytext);
}

%%

st_node *
create_token_node(char *name, en_type_tag tag, char *value)
{
	st_node *p = (st_node *) malloc(sizeof(st_node));
	p->first_child = NULL;
	p->next_sibling = NULL;
	
	p->content = (st_entry *) malloc(sizeof(st_entry));
	(p->content)->name = (char *)malloc(sizeof(char)*(strlen(name) + 1));
	memcpy(p->content->name, name, strlen(name)+1);

	(p->content)->tag = tag;
	(p->content)->line = g_lineno;
	
	if (STR_T == tag) {
		p->content->str_value = (char *)malloc(sizeof(char)*(strlen(value) + 1));
		memcpy(p->content->str_value, value, strlen(value) + 1);
	} else {
		p->content->str_value = NULL;
	}

	return p;
}
