/*
 * File: util.h
 *      
 * Author: Wei Tong
 *
 * IDENTIFICATION
 *      sqlparser/include/util.h
 *
 */

#ifndef __SQLPARSER_INCLUDE_UTIL_H__
#define __SQLPARSER_INCLUDE_UTIL_H__

#define MALLOC(t) ((t*)(malloc(sizeof(t))))
#define NMALLOC(t,n) ((t*)(malloc(sizeof(t)*n)))

#define LENGTH(array) (sizeof(array) / sizeof((array)[0]))

#ifdef JDEBUG
        #define jdb printf
#else 
        #define jdb {}
#endif

#endif /* __SQLPARSER_INCLUDE_UTIL_H__ */
