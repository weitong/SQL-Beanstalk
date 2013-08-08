/** 
 * File: memory.h
 * Author: Wei Tong
 *
 * IDENTIFICATION
 *      sqlparser/include/memory.h
 */

#ifndef __SQLPARSER_INCLUDE_MEMORY_H__
#define __SQLPARSER_INCLUDE_MEMORY_H__

extern void *
mem_alloc (long nbytes, const char *file, int line);

extern void 
mem_free(void *ptr, const char *file, int line);


#define ALLOC(nbytes) \
	mem_alloc((nbytes), __FILE__, __LINE__)

#define NEW(p) ((p) = ALLOC((long)sizeof *(p)))

#define FREE(ptr) ((void)(mem_free((ptr), \
	__FILE__, __LINE__), (ptr) = 0))

#endif /* __SQLPARSER_INCLUDE_MEMORY_H__ */