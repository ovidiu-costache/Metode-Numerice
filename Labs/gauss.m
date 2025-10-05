function x = gauss(A, b)
  [n n] = size(A);
  z = zeros(n, 1);

  for p = 1:n-1
    for i = p+1:n
      tp = A(i, p) / A(p, p);
      A(i, p) = 0;
      A(i, p+1:n) = A(i, p+1:n) - tp * A(p, p+1:n);
      b(i) = b(i) - tp * b(p);
    endfor
  endfor

  x = sst(A, b);
endfunction
