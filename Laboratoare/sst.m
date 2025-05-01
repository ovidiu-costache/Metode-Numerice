function x = sst(A, b)
  n = size(A, 1);
  x = zeros(n, 1);

  for i = n:-1:1
    x(i) = (b(i) - A(i, i+1:n) * x(i+1:n)) / A(i, i);
  endfor
endfunction
