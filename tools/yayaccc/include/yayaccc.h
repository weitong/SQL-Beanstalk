/** 
 * File: yayaccc.h
 * Author: Wei Tong
 *  
 * IDENTIFICATION
 *      tools/yayaccc/include/yayaccc.h
 */
#ifndef __TOOLS_YAYACCC_INCLUDE_YAYACCC_H__
#define __TOOLS_YAYACCC_INCLUDE_YAYACCC_H__

#ifdef JBG
	#define JOUT(format, args...) {printf(format, ##args);}
#else
	#define JOUT(format, args...) {}
#endif


#include "stdio.h"
#include "stdlib.h"
#include "stdarg.h"
#include "string.h"

#include "util.h"
#include "tree.h"
#include "types.h"
#include "xml.h"


extern uint_32 g_error_lex;
extern uint_32 g_error_syn;

#endif /* __TOOLS_YAYACCC_INCLUDE_YAYACCC_H__ */
