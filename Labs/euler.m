function [x, y] = euler(f, x0, y0, h, n)
  x = x0:h:(x0 + n*h);
  y = zeros(1, n+1);
  y(1) = y0;

  for i = 1:n
    y(i+1) = y(i) + h * f(x(i), y(i));
  endfor
endfunction
