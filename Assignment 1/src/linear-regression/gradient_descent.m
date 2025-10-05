function [Theta] = gradient_descent(FeatureMatrix, Y, n, m, alpha, iter)
  theta_vector = zeros(n, 1);

  for i = 1:iter
    % calculez h0 din formula
    h = FeatureMatrix * theta_vector;
    eroare = h - Y;
    % gradientul functiei de cost
    grad = (1/m) * (FeatureMatrix' * eroare);
    theta_vector = theta_vector - alpha * grad;
  endfor

  % adaug theta0 =  zero
  Theta = [0; theta_vector];
end
