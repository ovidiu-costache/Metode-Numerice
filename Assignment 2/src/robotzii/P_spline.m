function y_interp = P_spline (coef, x, x_interp)
  % si(x)   = ai + bi(x - xi) + ci(x - xi)^2 + di(x - xi)^3, i = 0 : n - 1
  % coef = [a0, b0, c0, d0, a1, b1, c1, d1, ..., an-1, bn-1, cn-1, dn-1]
  % x = [x0, x1, ..., xn]
  % y_interp(i) = P_spline(x_interp(i)), i = 0 : length(x_interp) - 1
  % Be careful! Indexes in Matlab start from 1, not 0

  % TODO: Calculate y_interp using the Spline coefficients

  nr_intervale = length(x) - 1;
  y_interp = zeros(length(x_interp), 1);

  % Pentru fiecare punct la care vrem sa evaluam spline-ul
  for k = 1:length(x_interp)
    xi = x_interp(k);

    % Cautam intervalul [x(i), x(i+1)] in care se afla xi
    interval = 0;
    for i = 1:nr_intervale
      % Daca xi este exact la limita dreapta, il includem in ultimul interval
      if (xi >= x(i) && (xi < x(i+1) || (i == nr_intervale && xi == x(nr_intervale+1))))
        interval = i;
        break;
      endif
    endfor

    % Extragem coeficientii pentru polinomul de pe intervalul gasit
    poz = 4*(interval-1) + 1;
    a = coef(poz);
    b = coef(poz+1);
    c = coef(poz+2);
    d = coef(poz+3);

    dx = xi - x(interval); % diferenta fata de capatul stanga al intervalului

    % Calculam valoarea spline-ului in punctul xi
    y_interp(k) = a + b*dx + c*dx^2 + d*dx^3;
  endfor
end
