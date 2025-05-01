function [U S V] = mysvd(A)
  % Proba:
  % U*S*V' = A
  [m, n] = size(A);
  U = zeros(m, m);
  S = zeros(m, n);
  V = zeros(n, n);
  if  m >= n
    [vecp, valp] = eig(A'*A);
    [valp, i] = sort(abs(diag(valp)),'descend'); % calculez matricea V
    V = vecp(:, i);
    % calculez matricea S
    s = sqrt(valp);
    S = [diag(s); zeros(m-n, n)];
    % calculez coloanele 1:n din matricea U
    for j = 1:n
      if s(j) > eps
        U(:, j) = A * V(:, j) / s(j);
      endif
    endfor
    % pentru a calcula coloanele n+1:m din U folosim algoritmul Gram-Schimidt
    U = [U(:, 1:n) rand(m, m-n)];
    U = Gram_Schmidt(U); % ortonormalizare
  else
    [vecp, valp] = eig(A*A');
    [valp, i] = sort(abs(diag(valp)),'descend'); % calculez matricea U
    U = vecp(:, i);
    s = sqrt(valp);
    S = [diag(s), zeros(m, n-m)];
    for j = 1:m
      if s(j) > eps
        V(:, j) = A' * U(:, j) / s(j);
      endif
    endfor
    V = [V(:, 1:m) rand(n, n-m)];
    V = Gram_Schmidt(V);
  endif
endfunction
