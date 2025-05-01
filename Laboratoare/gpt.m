function x = gpt(A, b)
  [n, ~] = size(A);
  perm = 1:n;

  for p = 1:n-1
    [max_val, max_idx] = max(abs(A(p:n, p:n))(:));
    [row_idx, col_idx] = ind2sub(size(A(p:n, p:n)), max_idx);
    row_idx = row_idx + (p - 1);
    col_idx = col_idx + (p - 1);

    if row_idx ~= p
      A([p, row_idx], :) = A([row_idx, p], :);
      b([p, row_idx]) = b([row_idx, p]);
    endif

    if col_idx ~= p
      A(:, [p, col_idx]) = A(:, [col_idx, p]);
      perm([p, col_idx]) = perm([col_idx, p]);
    endif

    for i = p+1:n
      tp = A(i, p) / A(p, p);
      A(i, p) = 0;
      A(i, p+1:n) = A(i, p+1:n) - tp * A(p, p+1:n);
      b(i) = b(i) - tp * b(p);
    endfor
  endfor

  x = sst(A, b);
  x(perm) = x;
endfunction
