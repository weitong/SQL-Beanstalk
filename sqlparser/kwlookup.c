/*-------------------------------------------------------------------------
 *
 * File: kwlookup.c
 *	  lexical token lookup for key words in SQL Parser
 *
 *
 * LICENSE 	
 *	see license file
 *
 * IDENTIFICATION
 *	sqlparser/kwlookup.c
 *
 *-------------------------------------------------------------------------
 */

#include <ctype.h>
#include "./include/parser.h"

/*
 * scan_keyword_loopup - see if a given word is a keyword
 *
 * Returns a pointer to the st_scan_keyword table entry, or NULL if no match.
 *
 * The match is done case-insensitively.  Note that we deliberately use a
 * dumbed-down case conversion that will only translate 'A'-'Z' into 'a'-'z',
 * even if we are in a locale where tolower() would produce more or different
 * translations.  This is to conform to the SQL99 spec, which says that
 * keywords are to be matched in this way even though non-keyword identifiers
 * receive a different case-normalization mapping.
 */
const st_scan_keyword *
scan_keyword_loopup(
	const char *text, 
	const st_scan_keyword *keywords, 
	int num_keywords)
{
	int	len, i;
	char	word[NAMEDATALEN];

	const st_scan_keyword *low;
	const st_scan_keyword *high;

	len = strlen(text);
	/* We assume all keywords are shorter than NAMEDATALEN. */
	if (len >= NAMEDATALEN)
		return NULL;

	/*
	 * Apply an ASCII-only downcasing. We must not use tolower() since it 
	 * may produce the wrong translation in some locales (eg, Turkish).
	 */
	for (i = 0; i < len; ++i) {
		char ch = text[i];

		if (ch >= 'A' && ch <= 'Z')
			ch += 'a' - 'A';
		word[i] = ch;
	}
	word[len] = '\0';

	/*
	 * Now do a binary search using plain strcmp() comparison.
	 */
	low = keywords;
	high = keywords + (num_keywords - 1);
	while (low <= high) {
		const st_scan_keyword 	*middle;
		int 	difference;

		middle = low + (high - low) / 2;
		difference = strcmp(middle->name, word);
		if (difference == 0)
			return middle;
		else if (difference < 0)
			low = middle + 1;
		else
			high = middle - 1;
	}

	return NULL;
}


/*
 * scan_translations_types 
 * 
 * 	see if a given word is a translations types between character code
 *	Returns a string of the type, if not exist, return NULL
 *
 */
const char *
scan_translations_types(
	const char *text, 
	int num_types)
{
	int	len, i;
	char word[TRANSLATIONS_TYPES_LEN];

	len = strlen(text);
	if (len >= TRANSLATIONS_TYPES_LEN)
		return NULL;

	for (i = 0; i < len; ++i) {
		char ch = text[i];

		if (ch >= 'a' && ch <= 'z')
			ch -= 'a' - 'A';
		word[i] = ch;
	}
	word[len] = '\0';

	for (i = 0; i < num_types; ++i) {
		int difference;

		difference = strcmp(translations_types[i], word);
		if (difference == 0)
			return translations_types[i];
	}
	return NULL;

}


/*
 * scan_character_set_types 
 * 
 * 	see if a given word is a character set type
 *	Returns a string of the type, if not exist, return NULL
 *
 */
const char *
scan_character_set_types(
	const char *text, 
	int num_types)
{
	int	len, i;
	char word[NAMEDATALEN];

	len = strlen(text);
	if (len >= NAMEDATALEN)
		return NULL;

	for (i = 0; i < len; ++i) {
		char ch = text[i];

		if (ch >= 'a' && ch <= 'z')
			ch -= 'a' - 'A';
		word[i] = ch;
	}
	word[len] = '\0';

	for (i = 0; i < num_types; ++i) {
		int difference;

		difference = strcmp(character_set_types[i], word);
		if (difference == 0)
			return character_set_types[i];
	}
	return NULL;

}