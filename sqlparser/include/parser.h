/** 
 * File: parser.h
 * Author: Wei Tong
 * 
 * IDENTIFICATION
 *      sqlparser/include/parser.h
 */


#ifndef __SQLPARSER_INCLUDE_PARSER_H__
#define __SQLPARSER_INCLUDE_PARSER_H__


/* debug option */
#define JTEST
#ifndef JTEST
	#define JBG
#endif

#ifdef JBG
	#define JOUT(format, args...) {printf(format, ##args);}
#else
	#define JOUT(format, args...) {}
#endif



#include "stdio.h"
#include "stdlib.h"
#include "stdarg.h"
#include "string.h"
#include "assert.h"


#include "util.h"
#include "tree.h"
#include "types.h"
#include "xml.h"
#include "rules.h"
#include "ids.h"
#include "keywords.h"

#endif /* __SQLPARSER_INCLUDE_PARSER_H__ */