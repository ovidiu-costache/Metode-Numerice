function [x, Y] = euler_sistem(f, x0, Y0, h, n)
  x = x0:h:(x0 + n*h);
  m = length(Y0);
  Y = zeros(m, n+1);
  Y(:,1) = Y0;

  for i = 1:n
    Y(:,i+1) = Y(:,i) + h * f(x(i), Y(:,i));
  endfor
endfunction
