function y_interp = P_vandermonde (coef, x_interp)
  % P_vandermonde(x) = a0 + a1 * x + a2 * x^2 + ... + an * x^n
  % coef = [a0, a1, a2, ..., an]'
  % y_interp(i) = P_vandermonde(x_interp(i)), i = 0 : length(x_interp) - 1

  % TODO: Calcualte y_interp using the Vandermonde coefficients

  n = length(coef) - 1;
  y_interp = zeros(length(x_interp), 1);

  % pentru fiecare punct din x_interp calculez valoarea polinomului
  for k = 1:length(x_interp)
    suma = 0;
    for j = 1:n+1
      suma = suma + coef(j) * x_interp(k)^(j-1);
    endfor
    y_interp(k) = suma;
  endfor
end
