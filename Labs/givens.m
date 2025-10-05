function [Q, R] = givens(A)
  [m, n] = size(A);
  Q = eye(m);

  for i = 1:n
    for j = m:-1:(i+1)
      if A(j, i) != 0
        r = norm([A(i, i); A(j, i)]);
        c = A(i, i) / r;
        s = -A(j, i) / r;

        G = eye(m);
        G([i j], [i j]) = [c -s; s c];

        A = G * A;
        Q = G * Q;
      endif
    endfor
  endfor

  Q = Q';
  R = A;
endfunction
