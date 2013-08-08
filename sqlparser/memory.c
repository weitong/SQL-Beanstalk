/** 
 * File: memory.c
 * Author: Wei Tong
 * 
 * IDENTIFICATION
 *      sqlparser/memory.c
 */

#include "./include/parser.h"


void *
mem_alloc(long nbytes, const char *file, int line)
{
	void *ptr;
	assert(nbytes > 0);
	ptr = malloc(nbytes);

	if (NULL == ptr) {
		if (file == NULL)
			fprintf(stderr, "%s\n", "Allocation Failed");
		else
			fprintf(stderr, "%s, file: %s, line: %d\n", \
				"Allocation Failed", file, line);
	}
	return ptr;
}

void 
mem_free(void *ptr, const char *file, int line) 
{
	if (ptr)
		free(ptr);
}