/** 
 * File: keywords.h
 * Author: Wei Tong
 * 
 * Portions Copyright (c) 2013, Wei Tong
 * Portions Copyright (c) 1996-2012, PostgreSQL Global Development Group
 * Portions Copyright (c) 1994, Regents of the University of California
 *
 * LICENSE 	
 *
 *	PostgreSQL License
 *
 *	Permission to use, copy, modify, and distribute this software and its 
 *	documentation for any purpose, without fee, and without a written 
 *	agreement is hereby granted, provided that the above copyright notice 
 *	and this paragraph and the following two paragraphs appear in all copies.
 *	
 *	IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY FOR 
 *	DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING 
 *	LOST PROFITS, ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, 
 *	EVEN IF THE UNIVERSITY OF CALIFORNIA HAS BEEN ADVISED OF THE POSSIBILITY OF 
 *	SUCH DAMAGE.
 *
 *	THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES, 
 *	INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY 
 *	AND FITNESS FOR A PARTICULAR PURPOSE. THE SOFTWARE PROVIDED HEREUNDER IS ON 
 *	AN "AS IS" BASIS, AND THE UNIVERSITY OF CALIFORNIA HAS NO OBLIGATIONS TO 
 *	PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
 *
 *
 * IDENTIFICATION
 *      sqlparser/include/keywords.h
 */

#ifndef __SQLPARSER_INCLUDE_KEYWORDS_H__
#define __SQLPARSER_INCLUDE_KEYWORDS_H__

#define UNRESERVED_KEYWORD		0
#define COL_NAME_KEYWORD		1
#define TYPE_FUNC_NAME_KEYWORD	2
#define RESERVED_KEYWORD		3
#define TERADATA_KEYWORD		4

#define NAMEDATALEN				20
#define TRANSLATIONS_TYPES_LEN	40

typedef struct __scan_keyword st_scan_keyword;

struct __scan_keyword {
	const char *	name;
	int		value;
	int 		category;
};

extern const st_scan_keyword scan_keywords[];
extern const char *translations_types[];
extern const char *character_set_types[];

extern const int num_scan_keywords;
extern const int num_translations_types;
extern const int num_character_set_types;

const st_scan_keyword *
scan_keyword_loopup(
	const char *text, 
	const st_scan_keyword *keywords, 
	int num_keywords);

const char *
scan_translations_types(
	const char *text, 
	int num_types);

const char *
scan_character_set_types(
	const char *text, 
	int num_types);

#endif // __SQLPARSER_INCLUDE_KEYWORDS_H__