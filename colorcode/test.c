/**
 * \file color_code_test.c
 */

#include <stdio.h>
#include <stdlib.h>

#define COL_BLK "\x1b[30m" /* Black text*/
#define COL_RED "\x1b[31m" /* Red text*/
#define COL_BLU "\x1b[34m" /* Blue text*/
#define COL_MAZ "\x1b[35m" /* Mazenda text */
#define COL_WHT "\x1b[37m" /* White text */
#define COL_DEF "\x1b[39m" /* Default text */


int main()
{
	printf(COL_WHT "This is White\n");
	printf(COL_BLK "This is Black\n");
	printf(COL_RED "This is Red\n");
	printf(COL_BLU "This is Blue\n");
	printf(COL_MAZ "This is Mazenda\n");
	printf(COL_DEF "This is Default\n");
}
