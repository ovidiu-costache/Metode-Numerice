function x = gpps(A, b)
  [n, ~] = size(A);
  s = max(abs(A), [], 2);

  for p = 1:n-1
    [~, max_idx] = max(abs(A(p:n, p)) ./ s(p:n));
    max_idx = max_idx + (p - 1);

    if max_idx ~= p
      A([p, max_idx], :) = A([max_idx, p], :);
      b([p, max_idx]) = b([max_idx, p]);
      s([p, max_idx]) = s([max_idx, p]);
    endif

    for i = p+1:n
      tp = A(i, p) / A(p, p);
      A(i, p) = 0;
      A(i, p+1:n) = A(i, p+1:n) - tp * A(p, p+1:n);
      b(i) = b(i) - tp * b(p);
    endfor
  endfor

  x = sst(A, b);
endfunction
