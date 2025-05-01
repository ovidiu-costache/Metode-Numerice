function [Error] = lasso_regression_cost_function(Theta, Y, FeatureMatrix, lambda)
  [m, n] = size(FeatureMatrix);

  % calculez suma (y - h)^2
  suma_eroare = 0;
  for i = 1:m
    suma_eroare = suma_eroare + (Y(i) - FeatureMatrix(i, 1:n) * Theta(2:length(Theta))) ^ 2;
  endfor
  E1 = suma_eroare / m;

  % calculez norma lui L1 din formula
  norm_L1 = 0;
  for j = 1:length(Theta)
    norm_L1 = norm_L1 + abs(Theta(j));
  endfor

  % R este termenul de regularizare, lambda*norma L1
  R = lambda * norm_L1;
  Error = E1 + R;
end
