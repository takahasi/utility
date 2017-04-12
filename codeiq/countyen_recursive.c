#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define COIN_NUM 1000
#define COIN_PATTERNS 6

static const int l[COIN_PATTERNS] = {1, 5, 10, 20, 50, 100};
static int m[COIN_PATTERNS] = {0, 0,  0,  0,  0,   0};

int countyen(int rest, int idx)
{
    int i, count = 0;

    if (rest > 0) {
        for (i = idx; i >= 0; i--) {
            if (rest >= l[i]) {
                m[i]++;
                if (m[i] <= 1000) {
                    count += countyen(rest - l[i], i);
                }
                m[i]--;
            }
        }
        return count;
    } else {
        //printf("%d,%d,%d,%d,%d,%d\n", m[0], m[1], m[2], m[3], m[4], m[5]);
        return 1;
    }
}

int main(void)
{
    int i,l;
    char s[80];

    for (; ~scanf("%s",s); ) {
        l = strlen(s);
        for (i = 0; i < l; i++) {
            s[i] = toupper(s[i]);
        }
    }
    printf("%d\n", countyen(atoi(s), COIN_PATTERNS - 1));
    return 0;
}
