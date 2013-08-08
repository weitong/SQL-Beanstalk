/*
 * File: types.h
 *      
 * Author: Wei Tong
 *
 * IDENTIFICATION
 *      tools/yayaccc/include/types.h
 *
 */
#ifndef __TOOLS_YAYACCC_INCLUDE_UTIL_H__
#define __TOOLS_YAYACCC_INCLUDE_UTIL_H__

#define MALLOC(t) ((t*)(malloc(sizeof(t))))
#define NMALLOC(t,n) ((t*)(malloc(sizeof(t)*n)))
 
#ifdef JDEBUG
        #define jdb printf
#else 
        #define jdb {}
#endif

#endif /* __TOOLS_YAYACCC_INCLUDE_UTIL_H__ */

