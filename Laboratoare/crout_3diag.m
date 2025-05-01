function [L, U] = crout_3diag(d, a, c)
  d = [0; d];
  n = length(a);
  L = zeros(n, n);
  U = eye(n);

  L(1,1) = a(1);
  U(1,2) = c(1) / L(1,1);

  for i = 2:n-1
    L(i, i-1) = d(i);
    L(i, i) = a(i) - L(i, i-1) * U(i-1, i);
    U(i, i+1) = c(i) / L(i, i);
  endfor
  L(n, n-1) = d(n);
  L(n, n) = a(n) - L(n, n-1) * U(n-1, n);
endfunction
