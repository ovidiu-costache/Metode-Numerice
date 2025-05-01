function [Error] = ridge_regression_cost_function(Theta, Y, FeatureMatrix, lambda)
  [m, n] = size(FeatureMatrix);

  % calculez suma (h - y)^2
  suma_eroare = 0;
  for i = 1:m
    suma_eroare = suma_eroare + (FeatureMatrix(i, 1:n) * Theta(2:length(Theta)) - Y(i))^2;
  endfor
  E2 = suma_eroare / (2*m);

  % calculez suma patratelor elem din theta
  sum_L2 = 0;
  for j = 1:length(Theta)
    sum_L2 = sum_L2 + Theta(j)^2;
  endfor

  % R este termenul de regularizare, lambda * sumL2
  R = lambda * sum_L2;
  Error = E2 + R;
end
