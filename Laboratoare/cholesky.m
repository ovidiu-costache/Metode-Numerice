function L = cholesky(A)
  n = size(A, 1);
  L = zeros(n, n);

  for p = 1:n
    for i = p:n
      s = L(p, 1:p-1) * L(i, 1:p-1)';
      if i == p
        L(p, p) = sqrt(A(p, p) - s);
      else
        L(i, p) = (A(i, p) - s) / L(p, p);
      endif
    endfor
  endfor
endfunction
