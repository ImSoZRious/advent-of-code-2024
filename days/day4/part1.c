#include <stdio.h>

struct D {
  int di, dj;
};

int main() {
  char x[200][200];
  int i = 1, j = 1;
  int n, m;
  char c;
  struct D d[8] = {
    {
      .di = -1,
      .dj = -1,
    },
    {
      .di = -1,
      .dj = 0,
    },
    {
      .di = -1,
      .dj = 1,
    },
    {
      .di = 0,
      .dj = -1,
    },
    {
      .di = 0,
      .dj = 1,
    },
    {
      .di = 1,
      .dj = -1,
    },
    {
      .di = 1,
      .dj = 0,
    },
    {
      .di = 1,
      .dj = 1,
    },
  };
  while((c = getchar()) != EOF) {
    if (c == '\r') {
      continue;
    } else if (c == '\n') {
      i += 1;
      n = i;
      m = j;
      j = 1;
    } else {
      x[i][j] = c;
      j += 1;
    }
  }
  for(i = 0; i <= n + 1; i++) {
    x[i][0] = 'a';
    x[i][m+1] = 'a';
  }
  for(j = 0; j <= m + 1; j++) {
    x[0][j] = 'a';
    x[n+1][j] = 'a';
  }
  int k, di, dj, ans = 0;
  for(i = 0; i <= n + 1; i++) {
    for(j = 0; j <= m + 1; j++) {
      for(k = 0; k < 8; k++) {
        di = d[k].di;
        dj = d[k].dj;
        if (i + 3 * di > n || i + 3 * di < 1 || j + 3 * dj > m || j + 3 * dj < 1) {
          continue;
        }

        if (x[i][j] == 'X' && x[i + di][j + dj] == 'M' && x[i + 2 * di][j + 2 * dj] == 'A' && x[i + 3 * di][j + 3 * dj] == 'S') {
          ans++;
        }
      }
    }
  }
  printf("%d", ans);
}
