/*
 * File: types.h
 *      
 * Author: Wei Tong
 *
 * IDENTIFICATION
 *      sqlparser/include/types.h
 *
 */


#ifndef __SQLPARSER_INCLUDE_TYPES_H__
#define __SQLPARSER_INCLUDE_TYPES_H__

#define BYTE_SIZE_32


/* To specify integer variable size, prefix 'u' means unsigned */
#ifdef BYTE_SIZE_32

typedef unsigned int    uint_32;
typedef int             int_32;
typedef unsigned short  uint_16;
typedef int             int_16;
typedef unsigned char   uint_8;
typedef int             int_8;
typedef unsigned char   boolean;

#endif /* BYTE_SIZE_32 */



#ifdef BYTE_SIZE_64
#endif /* BYTE_SIZE_64 */



#endif /* __SQLPARSER_INCLUDE_TYPES_H__ */
