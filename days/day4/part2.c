#include <stdio.h>

int main() {
  char x[200][200];
  int i = 1, j = 1;
  int n, m;
  char c;
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
  char tl, tr, bl, br;
  for(i = 1; i <= n; i++) {
    for(j = 1; j <= m; j++) {
      tl = x[i - 1][j - 1];
      tr = x[i - 1][j + 1];
      bl = x[i + 1][j - 1];
      br = x[i + 1][j + 1];

      if (x[i][j] != 'A') {
        continue;
      }

      if ((tl ^ tr ^ bl ^ br) == 0 && ((tl == 'M' && br == 'S') || (tl == 'S' && br == 'M'))) {
        ans++;
      }
    }
  }
  printf("%d", ans);
}
