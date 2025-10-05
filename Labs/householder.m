function [Q, R] = householder(A)
  [m, n] = size(A);
  H = eye(m);

  for p = 1:min(m, n)
    x = A(p:m, p);
    v = x;
    v(1) = v(1) + sign(x(1)) * norm(x);
    v = v / norm(v);

    Hp = eye(m - p + 1) - 2 * (v * v');
    A(p:m, p:n) = Hp * A(p:m, p:n);
    H = H * [eye(p-1), zeros(p-1, m-p+1); zeros(m-p+1, p-1), Hp];
  endfor

  Q = H';
  R = A;
endfunction
