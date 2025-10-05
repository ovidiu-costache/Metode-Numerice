function [x, Y] = RK2_sistem(f, x0, Y0, h, n)
  x = x0:h:(x0 + n*h);
  m = length(Y0);
  Y = zeros(m, n+1);
  Y(:,1) = Y0;

  for i = 1:n
    k1 = f(x(i), Y(:,i));
    k2 = f(x(i) + h, Y(:,i) + h*k1);
    Y(:,i+1) = Y(:,i) + h/2 * (k1 + k2);
  endfor
endfunction
