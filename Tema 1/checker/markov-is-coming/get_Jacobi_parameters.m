function [G, c] = get_Jacobi_parameters(Link)
  [m, n] = size(Link);

  % starile traniztorii, fara WIN si LOSE
  M = m - 2;
  N = n - 2;
  G = zeros(M, N);
  c = zeros(M, 1);

  % G va avea tranzitiile dntre starile tranzitorii
  for i = 1:M
    for j = 1:N
      G(i, j) = Link(i, j);
    endfor
  endfor

  % c va avea tranzitiile de la starile tranzitorii la starea WIN
  for i = 1:M
    c(i) = Link(i, N + 1);
  endfor
end
