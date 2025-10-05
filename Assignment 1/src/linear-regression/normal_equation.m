function [Theta] = normal_equation(FeatureMatrix, Y, tol, iter)
  [m, n] = size(FeatureMatrix);

  A = FeatureMatrix' * FeatureMatrix; % A = X' * X
  b = FeatureMatrix' * Y; % b = X' * Y

  % verific daca A este poz def
  [L, p] = chol(A);
  if p != 0
    Theta = zeros(n+1, 1);
    return;
  endif

  x = zeros(n, 1); % x0 = 0
  r = b; % r0 = b, pt ca x0 = 0
  v = r;
  tol_patrat = tol^2;

  k = 1;
  while k <= iter && (r' * r) > tol_patrat
    % aplic formulele din pseudocod
    t_k = (r' * r) / (v' * (A * v));
    x = x + t_k * v;
    r_k = r - t_k * (A * v);
    s_k = (r_k' * r_k) / (r' * r);
    v = r_k + s_k * v;
    r = r_k;

    k = k + 1;
  endwhile

  Theta = [0; x];
end
