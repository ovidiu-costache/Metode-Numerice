function [x, y] = RK2(f, x0, y0, h, n)
  x = x0:h:(x0 + n*h);
  y = zeros(1, n+1);
  y(1) = y0;

  for i = 1:n
    k1 = f(x(i), y(i));
    k2 = f(x(i) + h, y(i) + h*k1);
    y(i+1) = y(i) + h/2 * (k1 + k2);
  endfor
endfunction
