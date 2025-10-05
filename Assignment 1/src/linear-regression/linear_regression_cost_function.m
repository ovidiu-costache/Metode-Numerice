function [Error] = linear_regression_cost_function(Theta, Y, FeatureMatrix)
  % sar peste primul theta, care este zero
  theta_nou = Theta(2:end);

  [m, n] = size(FeatureMatrix);
  suma_erori = 0;

  for i = 1:m
    predictie = 0;
    for j = 1:n
      predictie = predictie + FeatureMatrix(i, j) * theta_nou(j);
    endfor
    eroare = predictie - Y(i);
    suma_erori += eroare ^ 2;
  endfor

  Error = suma_erori / (2 * m);
end
