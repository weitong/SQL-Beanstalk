%{
/*
 * 	File: scan.l
 * 	Author: Wei Tong
 *		
 *		lexical scanner for Mini Parser
 *	
 *	The rules are designed so that the scanner never has to backtrack,
 * 	in the sense that there is always a rule that can match the input
 * 	consumed so far.
 *
 * 	IDENTIFICATION
 *		sqlparser/scan.l
 * 
 */
#include "gram.tab.h"
#include "./include/parser.h"

int_32 g_lineno = 1;
int_32 g_columnno = 1;
uint_32 g_error = 0;
uint_32 lex_num = 0;

#define YY_USER_ACTION yylloc.first_line = yylloc.last_line = g_lineno; \
        yylloc.first_column = g_columnno; yylloc.last_column = g_columnno + yyleng-1; \
        g_columnno += yyleng;
        
extern const st_scan_keyword scan_keywords[];
extern const char *translations_types[];
extern const char *character_set_types[];

extern const int num_scan_keywords;
extern const int num_translations_types;
extern const int num_character_set_types;

static st_node *
create_token_node(char *name, en_type_tag tag, char *value);

static inline int_32 
oct_to_i(char *oct); 

static inline int_32 
hex_to_i(char *hex);


FILE *fcomment;


%}



%option noyywrap
%option yylineno


A	"a"|"A"
B	"b"|"B"
C	"c"|"C"
D	"d"|"D"
E	"e"|"E"
F	"f"|"F"
G	"g"|"G"
H	"h"|"H"
I	"i"|"I"
J	"j"|"J"
K	"k"|"K"
L	"l"|"L"
M	"m"|"M"
N	"n"|"N"
O	"o"|"O"
P	"p"|"P"
Q	"q"|"Q"
R	"r"|"R"
S	"s"|"S"
T	"t"|"T"
U	"u"|"U"
V	"v"|"V"
W	"w"|"W"
X	"x"|"X"
Y	"y"|"Y"
Z	"z"|"Z"


/* 
 * definition of some ws characters
 *
 *
 */
 
lex_space		[ \t\n\r\f]
lex_horiz_space		[ \t\f]
lex_newline		[\n\r]
lex_non_newline		[^\n\r]
lex_scomment		"--".*$
lex_mcomment		"/*"([*]*(([^*/])+([/])*)*)*"*/"
lex_dollar			"\$"


/*
command_maxerror	{lex_dot}{M}{A}{X}{E}{R}{R}{O}{R}
command_dotquit		{lex_dot}{Q}{U}{I}{T}
command_dotif		{lex_dot}{I}{F}
command_dotelse		{lex_dot}{E}{L}{S}{E}
command_dotset		{lex_dot}{S}{E}{T}
command_dotexport	{lex_dot}{E}{X}{P}{O}{R}{T}
command_logoff		{lex_dot}{L}{O}{G}{O}{F}{F}

lex_maxerror		^{command_maxerror}.*$|{lex_horiz_space}+{command_maxerror}.*$
lex_dotquit			^{command_dotquit}.*$|{lex_horiz_space}+{command_dotquit}.*$
lex_dotif			^{command_dotif}.*$|{lex_horiz_space}+{command_dotif}.*$
lex_dotelse			^{command_dotelse}.*$|{lex_horiz_space}+{command_dotelse}.*$
lex_dotset			^{command_dotset}.*$|{lex_horiz_space}+{command_dotset}.*$
lex_dotexport		^{command_dotexport}.*$|{lex_horiz_space}+{command_dotexport}.*$
lex_dotlogoff		^{command_logoff}.*$|{lex_horiz_space}+{command_logoff}.*$
*/

lex_maxerror		{lex_dot}{M}{A}{X}{E}{R}{R}{O}{R}.*$
/*lex_maxerror		^{lex_horiz_space}*{lex_dot}{M}{A}{X}{E}{R}{R}{O}{R}.*$*/
lex_dotquit1		^{lex_horiz_space}*{lex_dot}{Q}{U}{I}{T}
lex_dotquit2		^{lex_horiz_space}*{lex_dot}{Q}{U}{I}{T}.*$
lex_dotif			^{lex_horiz_space}*{lex_dot}{I}{F}.*$
lex_dotelse			^{lex_horiz_space}*{lex_dot}{E}{L}{S}{E}.*$
lex_dotset			^{lex_horiz_space}*{lex_dot}{S}{E}{T}.*$
lex_dotexport		^{lex_horiz_space}*{lex_dot}{E}{X}{P}{O}{R}{T}.*$
lex_dotlogoff		^{lex_horiz_space}*{lex_dot}{L}{O}{G}{O}{F}{F}.*$
lex_dotimport		^{lex_horiz_space}*{lex_dot}{I}{M}{P}{O}{R}{T}.*$
lex_dotos			^{lex_horiz_space}*{lex_dot}{O}{S}.*$
lex_dotlabel		^{lex_horiz_space}*{lex_dot}{L}{A}{B}{E}{L}.*$
lex_dotexit			^{lex_horiz_space}*{lex_dot}{E}{X}{I}{T}.*$
lex_dotremark		^{lex_horiz_space}*{lex_dot}{R}{E}{M}{A}{R}{K}.*$

/* a trick */
using_command_trick	^{U}{S}{I}{N}{G}.*$

lex_writespace		({lex_space}+|{lex_scomment})

/*
 * You should pay attention to the copyright in this part.
 *
 * Portions Copyright (c) 2012, Joe Tong
 * Portions Copyright (c) 1996-2012, PostgreSQL Global Development Group
 * Portions Copyright (c) 1994, Regents of the University of California
 * 
 *
 * To ensure that {quotecontinue} can be scanned without having to back up
 * if the full pattern isn't matched, we include trailing whitespace in
 * {quotestop}.  This matches all cases where {quotecontinue} fails to match,
 * except for {quote} followed by whitespace and just one "-" (not two,
 * which would start a {comment}).  To cover that we have {quotefail}.
 * The actions for {quotestop} and {quotefail} must throw back characters
 * beyond the quote proper.
 */
lex_quote 		'
lex_quotestop		{lex_quote}{lex_whitespace}*
lex_quotecontinue	{lex_quote}{lex_whitespace_with_newline}{lex_quote}
lex_quotefail		{lex_quote}{lex_whitespace}*"-"



/* bit string */
lex_bstart		[bB]{lex_quote}
lex_binside		[^']*

/* hexadecimal number */
lex_hstart		[xX]{lex_quote}
lex_hinside		[^']*

/* quoted string */
lex_estart		[eE]{lex_quote}
lex_einside		[^\\']+
lex_eescape		[\\][^0-7]
lex_eoctesc		[\\][0-7]{1,3}
lex_ehexesc		[\\]x[0-9A-Fa-f]{1,2}

/* extended quote */
lex_qstart		{lex_quote}
lex_qdouble		{lex_quote}{lex_quote}
lex_qinside		[^']+

lex_dstring		{lex_string}{lex_string}
lex_string		'[^'\n]*'|{lex_dquote}[^"\n]*{lex_dquote}



/* double quote */
lex_dquote		\"
lex_dstart		{lex_dquote}
lex_dstop		{lex_dquote}
lex_ddouble		{lex_dquote}{lex_dquote}
lex_dinside		[^"]+


/* digit */
lex_digit		[0-9]
lex_sql_identifier	[A-Za-z_][A-Za-z0-9_]*
lex_sh_identifier	$\{{lex_sql_identifier}\}
lex_ext_identifier	[:A-Za-z_\$][A-Za-z0-9_\$\{\}]*
lex_sh_prec			\$\{
/* special characters */



lex_eq 				"=" 
lex_lt 				"<"
lex_gt 				">"
lex_plus			"+"
lex_minus			"-"
lex_mul				"*"
lex_div				"/"
lex_mod				"%"|{M}{O}{D}
lex_power			"^"
lex_lp				"("
lex_rp 				")"
lex_lb				"["
lex_rb				"]"
lex_lc				"{"
lex_rc 				"}"
lex_comma			","
lex_semi			";"
lex_colon 			":"
lex_ampersand		"&"
lex_dot 			"."

lex_typecast		"::"
lex_dot_dot			\.\.
lex_vbar_vbar		"||"
lex_colon_equals	":="
lex_ne 				"<>"
lex_ge 				">="
lex_le 				"<="



/*
 *
 * You should pay attention to the copyright in this part.
 *
 * Portions Copyright (c) 2012, Joe Tong
 * Portions Copyright (c) 1996-2012, PostgreSQL Global Development Group
 * Portions Copyright (c) 1994, Regents of the University of California
 * 
 * "self" is the set of chars that should be returned as single-character
 * tokens.  "op_chars" is the set of chars that can make up "Op" tokens,
 * which can be one or more characters long (but if a single-char token
 * appears in the "self" set, it is not to be returned as an Op).  Note
 * that the sets overlap, but each has some chars that are not in the other.
 *
 * If you change either set, adjust the character lists appearing in the
 * rule for "operator"!
 */
lex_self		[,()\[\].;\:\+\-\*\/\%\^\<\>\=]
lex_op_chars		[\~\!\@\#\^\&\|\`\?\+\-\*\/\%\<\>\=\|]
lex_operator		{lex_op_chars}+


/* numeric lexical */
lex_integer		{lex_digit}+
lex_decimal		(({lex_digit}*\.{lex_digit}+)|({lex_digit}+\.{lex_digit}*))
lex_decimalfail		{lex_digit}+\.\.
lex_real		({lex_integer}|{lex_decimal})[Ee][-+]?{lex_digit}+
lex_realfail1		({lex_integer}|{lex_decimal})[Ee]
lex_realfail2		({lex_integer}|{lex_decimal})[Ee][-+]

lex_param		\${lex_integer}
lex_other		.

%%

{lex_newline} {
	g_lineno ++;
}



{lex_mcomment} {
	
}

{lex_scomment} {
	JOUT("SCOMMENT\n");

}

{lex_writespace} {

}

{lex_maxerror} {
	JOUT("MAXERROR\n");
}

{lex_dotquit2} {
	JOUT("DOTQUIT2\n");
}

{lex_dotquit1} {
	char c = input();
	while(c != '\n' && c != EOF && c != ';') c = input();
	JOUT("DOTQUIT1\n");
}

{lex_dotlabel} {
	JOUT("DOTLABEL\n");
}

{lex_dotif} {
	JOUT("DOTIF\n");
}

{lex_dotset} {
	JOUT("DOTSET\n");
}

{lex_dotexport} {
	JOUT("DOTEXPORT\n");
}

{lex_dotimport} {
	JOUT("DOTIMPORT\n");
}

{lex_dotos} {
	JOUT("DOTOS\n");
}

{lex_dotlogoff} {
	JOUT("DOTLOGOGG\n");
}


{lex_dotremark} {
	JOUT("DOT REMARK\n");
}
{lex_dotexit} {
	JOUT("DOTEXIT\n");
}

{using_command_trick} {
	JOUT("USING COMMAND\n");
}

{lex_decimal} {
	JOUT("FLOAT: %s \n", yytext); 
	yylval.node_type = create_token_node("FCONST", STR_T, yytext); 
	return FCONST;
}

{lex_dstring} {
	JOUT("string LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SCONST", STR_T, yytext); 
	return SCONST;
}

{lex_string} {
	JOUT("string LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SCONST", STR_T, yytext); 
	return SCONST;
}

{lex_dot_dot} {
	JOUT("DOT DOT LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_DOT_DOT", RES_T, 0); 
	return SQL_DOT_DOT;
}

{lex_colon_equals} {
	JOUT("lex_colon_equals LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_COLON_EQUALS", RES_T, 0); 
	return SQL_COLON_EQUALS;
}

{lex_typecast} {
	JOUT(" lex_typecast LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_TYPECAST", RES_T, 0); 
	return SQL_TYPECAST;
}

{lex_ne} {
	JOUT("lex_ne LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_NE", RES_T, 0); 
	return SQL_NE;
}

{lex_ge} {
	JOUT("LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_GE", RES_T, 0); 
	return SQL_GE;
}

{lex_le} {
	JOUT("LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_LE", RES_T, 0); 
	return SQL_LE;
}

{lex_ampersand} {
	JOUT("LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_AMPERSAND", RES_T, 0); 
	return SQL_AMPERSAND;
}

{lex_dot} {
	JOUT(" lex_dot LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_DOT", RES_T, 0); 
	return SQL_DOT;
}

{lex_eq} {
	JOUT("LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_EQ", RES_T, 0); 
	return SQL_EQ;
}

{lex_lt} {
	JOUT("LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_LT", RES_T, 0); 
	return SQL_LT;
}

{lex_gt} {
	JOUT("LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_GT", RES_T, 0); 
	return SQL_GT;
}

{lex_plus} {
	JOUT("LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_PLUS", RES_T, 0); 
	return SQL_PLUS;
}

{lex_minus} {
	JOUT("LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_MINUS", RES_T, 0); 
	return SQL_MINUS;
}

{lex_mul} {
	JOUT("LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_MUL", RES_T, 0); 
	return SQL_MUL;
}

{lex_div} {
	JOUT("LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_DIV", RES_T, 0); 
	return SQL_DIV;
}

{lex_mod} {
	JOUT("LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_MOD", RES_T, 0); 
	return SQL_MOD;
}

{lex_power} {
	JOUT("LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_POWER", RES_T, 0); 
	return SQL_POWER;
}

{lex_lp} {
	JOUT("LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_LP", RES_T, 0); 
	return SQL_LP;
}

{lex_rp} {
	JOUT("LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_RP", RES_T, 0); 
	return SQL_RP;
}

{lex_lb} {
	JOUT("LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_LB", RES_T, 0); 
	return SQL_LB;
}

{lex_rb} {
	JOUT("LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_RB", RES_T, 0); 
	return SQL_RB;
}

{lex_comma} {
	JOUT("LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_COMMA", RES_T, 0); 
	return SQL_COMMA;
}

{lex_semi} {
	JOUT("LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_SEMI", RES_T, 0); 
	return SQL_SEMI;
}

{lex_colon} {
	JOUT("LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("SQL_COLON", RES_T, 0); 
	return SQL_COLON;
}

{lex_integer} {
	JOUT("LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("ICONST", STR_T, yytext); 
	return ICONST;
}

{lex_operator} {
	JOUT("lex_operator LEX: %s \n", yytext); 
	yylval.node_type = create_token_node("Op", STR_T, yytext); 
	return Op;
}

{lex_ext_identifier} {
	const st_scan_keyword	*keyword;
	char *keyword_str;
	char *transtype_str, *charset_str;
	const char *transtype_tmp, *charset_tmp;
	int_32 keyword_len, transtype_len, charset_len;
	int_32 i;

	//char 	*ident;

	keyword = scan_keyword_loopup(yytext, scan_keywords, num_scan_keywords);

	if (keyword != NULL) {
		//JOUT("LEX: %s \n", yytext);
		keyword_len = strlen(keyword->name) + 1;
		keyword_str = NMALLOC(char, keyword_len);

		for(i = 0; i < keyword_len; ++i) {
			keyword_str[i] = keyword->name[i];
		}

		keyword_str[i] = '\0';

		if (0 == strcmp(keyword_str, "lock") || 0 == strcmp(keyword_str, "locking")) {
			
			char c = input();
			while(c != '\n' && c != EOF && c != ';') c = input();
			JOUT("LOCK\n");
			goto DO_NOTHING;

		} /*else if (0 == strcmp(keyword_str, "exit")) {
			char c = input();
			while(c != '\n' && c != EOF && c != ';') c = input();
			JOUT("EXIT\n");
			goto DO_NOTHING;
		}*/

		// what' bt & et?
		if (0 == strcmp(keyword_str, "bt")) {
			JOUT("LEX: BT \n");
			return TD_BT;
		} else if (0 == strcmp(keyword_str, "et")) {
			JOUT("LEX: ET\n");
			return TD_ET;
		} 
		
		yylval.node_type = create_token_node(keyword_str, RES_T, 0);

		JOUT(" keyword ~~~~ %s, %d\n", keyword_str, keyword->value);
		return keyword->value;
	}


	/////////////////////////////////////////////////////////////////
	// This part handle the translations_types 

	transtype_tmp = scan_translations_types(\
		yytext, num_translations_types);
	
	if (transtype_tmp != NULL) {
		//to use a binary search to improve the performance
		JOUT("LEX TranslationsTypes : %s \n", yytext); 

		transtype_len = strlen(transtype_tmp) + 1;
		transtype_str = NMALLOC(char, transtype_len);

		for(i = 0; i < transtype_len; ++i) {
			transtype_str[i] = transtype_tmp[i];
		}

		transtype_str[i] = '\0';
		
		yylval.node_type = create_token_node(\
			"TranslationsTypes", STR_T, transtype_str); 

		return TranslationsTypes;
	}

	// //////////////////////////////////////////////////
	// this part handle the character set types

	charset_tmp = scan_character_set_types(\
		yytext, num_character_set_types);
	
	if (charset_tmp != NULL) {
		//to use a binary search to improve the performance
		JOUT("LEX TD_CharacterSetTypes : %s \n", yytext); 

		charset_len = strlen(charset_tmp) + 1;
		charset_str = NMALLOC(char, charset_len);

		for(i = 0; i < charset_len; ++i) {
			charset_str[i] = charset_tmp[i];
		}

		charset_str[i] = '\0';
		
		yylval.node_type = create_token_node("TD_CharacterSetTypes", STR_T, yytext); 
		return TD_CharacterSetTypes;
	}

	///////////////////////////////////////////////
	// this part handle the identification 

	//yylval->str = ident;
	JOUT(" id ~~~~~~ %s\n", yytext);
	yylval.node_type = create_token_node("SQL_SQL_IDENTIFIER", STR_T, yytext); 
	return SQL_SQL_IDENTIFIER;

DO_NOTHING:
	JOUT("IGNORE lex \n");
}

{lex_other} {
	g_error ++;

#ifndef JTEST
	fprintf(stderr, "[Error] Lex: %s cannot be recognized\n", yytext);
#endif

}


%%


static st_node *
create_token_node(char *name, en_type_tag tag, char *value)
{
	int namelen = 0;
	st_node *p = MALLOC(st_node);
	if (NULL == p) {
		fprintf(stderr, "%s\n", "Fail to alloc the memory");
		exit(-1);
	}
	
	p->content = MALLOC(st_entry);
	if (NULL == p->content) { 
		fprintf(stderr, "%s\n", "Fail to alloc the memory");
		exit(-1);
	}

	namelen = strlen(name) + 1;
	(p->content)->name = NMALLOC(char, namelen);
	if (NULL == (p->content)->name) {
		fprintf(stderr, "%s\n", "Fail to alloc the memory");
		exit(-1);
	}

	memcpy((p->content)->name, name, namelen);

	(p->content)->tag = tag;
	(p->content)->line = g_lineno;
	(p->content)->terminate = 1;

	switch(tag) {
		case STR_T:
			p->content->str_value = NMALLOC(char, (strlen(value) + 1));
			memcpy(p->content->str_value, value, strlen(value)+1);
			p->content->lno = ++ lex_num;
			break;
		case INT_T:
			(p->content)->int_value = atoi(value);
			p->content->lno = ++ lex_num;
			break;
		case FLOAT_T:
			(p->content)->float_value = atof(value);
			p->content->lno = ++ lex_num;
			break;
		case RES_T:
			(p->content)->str_value = "";
			p->content->lno = ++ lex_num;
			break;
		case SCOMMENT_T:
			p->content->str_value = NMALLOC(char, (strlen(value)+1));
			memcpy(p->content->str_value, value, strlen(value)+1);
			(p->content)->lno = lex_num;
			break;
		case MCOMMENT_T:
			p->content->str_value = NMALLOC(char, (strlen(value)+1));
			memcpy(p->content->str_value, value, strlen(value)+1);
			(p->content)->lno = lex_num;
			break;
		default:
			p->content->str_value = NULL; 
			(p->content)->lno = -1;
			break;

	}

	return p;
}

static inline int_32 
oct_to_i(char *oct) 
{
	int_32 n = *oct - '0';
	while (*(++oct) != '\0') n = n * 8 + *oct - '0';
	return n;
}

static inline 
int_32 hex_to_i(char *hex) 
{
	int_32 n = *hex - '0';
	while (*(++hex) != '\0') n = n*16 + *hex - '0';
	return n;
}
