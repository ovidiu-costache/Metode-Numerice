function Q = Gram_Schmidt(A)
  [m, n] = size(A);
  Q = zeros(m, n);

  for j = 1:n
    v = A(:, j);
    for i = 1:j-1
      r = Q(:, i)' * A(:, j);
      v = v - r * Q(:, i);
    endfor
    norm_v = norm(v);
    if norm_v > eps
      Q(:, j) = v / norm_v;
    else
      Q(:, j) = zeros(m, 1);
    endif
  endfor
endfunction
