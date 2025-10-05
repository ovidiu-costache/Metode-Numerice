function x = sistem_cholesky(A, b)
  L = cholesky(A);
  y = sit(L, b);
  x = sst(L', y);
endfunction
