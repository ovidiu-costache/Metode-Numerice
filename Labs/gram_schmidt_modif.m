function [Q, R] = gram_schmidt_modif(A)
  [m, n] = size(A);
  R = zeros(n, n);
  Q = A;

  Q(:,1) = A(:,1) / norm(A(:,1));
  R(1,:) = Q(:,1)' * A;

  for i = 1:n-1
    for j = i+1:n
      Q(:,j) = Q(:,j) - (Q(:,j)' * Q(:,i)) * Q(:,i);
    endfor
    Q(:,i+1) = Q(:,i+1) / norm(Q(:,i+1));
    R(i+1,:) = Q(:,i+1)' * A;
  endfor
endfunction
