function coef = spline_c2 (x, y)
  % Remember that the indexes in Matlab start from 1, not 0

  % si(x)   = ai + bi(x - xi) + ci(x - xi)^2 + di(x - xi)^3
  % si'(x)  =      bi         + 2ci(x - xi)  + 3di(x - xi)^2
  % si''(x) =                   2ci          + 6di(x - xi)

  nr_intervale = length(x) - 1;
  nr_necunoscute = 4 * nr_intervale;

  % initializez matricea sistemului si vectorul termenilor liberi
  A = zeros(nr_necunoscute, nr_necunoscute);
  b = zeros(nr_necunoscute, 1);

  linie = 1; % contor pentru linii

  % TODO 1: si(xi) = yi, i = 0 : n - 1
  for i = 1:nr_intervale
    poz = 4*(i-1) + 1;
    A(linie, poz) = 1;
    b(linie) = y(i);
    linie = linie + 1;
  endfor

  % TODO 2: s_n-1(xn) = yn
  poz = 4*(nr_intervale-1) + 1;
  distanta = x(nr_intervale+1) - x(nr_intervale);
  A(linie, poz) = 1;
  A(linie, poz+1) = distanta;
  A(linie, poz+2) = distanta^2;
  A(linie, poz+3) = distanta^3;
  b(linie) = y(nr_intervale+1);
  linie = linie + 1;

  % TODO 3: si(x_i+1) = s_i+1(x_i+1), i = 0 : n - 2
  for i = 1:nr_intervale-1
    distanta = x(i+1) - x(i);
    poz_stanga = 4*(i-1) + 1; % polinomul din stanga
    poz_dreapta = 4*i + 1; % polinomul din dreapta
    A(linie, poz_stanga) = 1;
    A(linie, poz_stanga+1) = distanta;
    A(linie, poz_stanga+2) = distanta^2;
    A(linie, poz_stanga+3) = distanta^3;
    A(linie, poz_dreapta) = -1;
    b(linie) = 0;
    linie = linie + 1;
  endfor

  % TODO 4: si'(x_i+1) = s_i+1'(x_i+1), i = 0 : n - 2
  for i = 1:nr_intervale-1
    distanta = x(i+1) - x(i);
    poz_stanga = 4*(i-1) + 1;
    poz_dreapta = 4*i + 1;
    A(linie, poz_stanga+1) = 1;
    A(linie, poz_stanga+2) = 2*distanta;
    A(linie, poz_stanga+3) = 3*distanta^2;
    A(linie, poz_dreapta+1) = -1;
    b(linie) = 0;
    linie = linie + 1;
  endfor

  % TODO 5: si''(x_i+1) = s_i+1''(x_i+1), i = 0 : n - 2
  for i = 1:nr_intervale-1
    distanta = x(i+1) - x(i);
    poz_stanga = 4*(i-1) + 1;
    poz_dreapta = 4*i + 1;
    A(linie, poz_stanga+2) = 2;
    A(linie, poz_stanga+3) = 6*distanta;
    A(linie, poz_dreapta+2) = -2;
    b(linie) = 0;
    linie = linie + 1;
  endfor

  % TODO 6: s0''(x0) = 0
  poz = 1;
  A(linie, poz+2) = 2;
  b(linie) = 0;
  linie = linie + 1;

  % TODO 7: s_n-1''(x_n) = 0
  poz = 4*(nr_intervale-1) + 1;
  distanta = x(nr_intervale+1) - x(nr_intervale);
  A(linie, poz+2) = 2;
  A(linie, poz+3) = 6*distanta;
  b(linie) = 0;

  % Solve the system of equations
  coef = A \ b;
end
