/*
 * File: keywords.c
 *	  lexical token lookup for key words in SQL Parser
 *
 * 
 * LICENSE 	
 *	see license file
 *
 *
 * IDENTIFICATION
 *	sqlparser/keywords.c
 *
 */


#include "./include/parser.h"
#include "gram.tab.h"
 
#define JOE_KEYWORD(a,b,c) {a,b,c},


const st_scan_keyword scan_keywords[] = {
#include "./include/kwlist.h"
};

const char * translations_types[] = {
	"LATIN_TO_GRAPHIC",
	"LATIN_TO_KANJISJIS", 
	"LATIN_TO_UNICODE", 
	"KANJI1_KANJIEBCDIC_TO_UNICODE", 
	"KANJI1_KAMJIEUC_TO_UNICODE",
	"KANJI1_KANJISJIS_TO_UNICODE",
	"KANJI1_SBC_TO_UNICODE",
	"KANJISJIS_TO_LATIN",
	"KANJISJIS_TO_GRAPHIC",
	"KANJISJIS_TO_UNICODE",
	"GRAPHIC_TO_LATIN",
	"GRAPHIC_TO_KANJISJIS",
	"GRAPHIC_TO_UNICODE",
	"GRAPHIC_TO_UNICODE_PADSPACE",
	"UNICODE_TO_LATIN",
	"UNICODE_TO_KANJI1_KANJIEBCDIC",
	"UNICODE_TO_KANJI1_KANJIEUC",
	"UNICODE_TO_KANJI1_KANJISJIS",
	"UNICODE_TO_KANJI1_SBC",
	"UNICODE_TO_GRAPHIC",
	"UNICODE_TO_KANJISJIS",
	"UNICODE_TO_UNICODE_FULLWIDTH",
	"UNICODE_TO_UNICODE_HALFWIDTH",
	"UNICODE_TO_UNICODE_FOLDSPACE",
	"UNICODE_TO_GRAPHIC_PADGRAPHIC",
	"UNICODE_TO_GRAPHIC_VARGRAPHIC"
};

const char *character_set_types[] = {
	"UNICODE",
	"LATIN",
	"KANJI1",
	"KANJISJIS",
	"GRAPHIC"
};


const int num_scan_keywords = LENGTH(scan_keywords);
const int num_translations_types = LENGTH(translations_types);
const int num_character_set_types = LENGTH(character_set_types);


/* 
"LATIN_TO_GRAPHIC" | 
"LATIN_TO_KANJISJIS" | 
"LATIN_TO_UNICODE" | 
"KANJI1_KanjiEBCDIC_TO_UNICODE" | 
"KANJI1_KanjiEUC_TO_UNICODE" | 
"KANJI1_KANJISJIS_TO_UNICODE" | 
"KANJI1_SBC_TO_UNICODE" |
"KANJISJIS_TO_LATIN" |
"KANJISJIS_TO_GRAPHIC" |
"KANJISJIS_TO_UNICODE" |
"GRAPHIC_TO_LATIN" |
"GRAPHIC_TO_KANJISJIS" |
"GRAPHIC_TO_UNICODE" |
"GRAPHIC_TO_UNICODE_PadSpace" |
"UNICODE_TO_LATIN" |
"UNICODE_TO_KANJI1_KanjiEBCDIC" |
"UNICODE_TO_KANJI1_KanjiEUC" |
"UNICODE_TO_KANJI1_KANJISJIS" |
"UNICODE_TO_KANJI1_SBC" |
"UNICODE_TO_GRAPHIC" |
"UNICODE_TO_KANJISJIS" |
"UNICODE_TO_UNICODE_Fullwidth" |
"UNICODE_TO_UNICODE_Halfwidth" |
"UNICODE_TO_UNICODE_FoldSpace" |
"UNICODE_TO_GRAPHIC_PadGraphic" |
"UNICODE_TO_GRAPHIC_VarGraphic"
*/
