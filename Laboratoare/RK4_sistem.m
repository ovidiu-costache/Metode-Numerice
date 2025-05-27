function [x, Y] = RK4_sistem(f, x0, Y0, h, n)
  x = x0:h:(x0 + n*h);
  m = length(Y0);
  Y = zeros(m, n+1);
  Y(:,1) = Y0;

  for i = 1:n
    k1 = f(x(i), Y(:,i));
    k2 = f(x(i) + h/2, Y(:,i) + h/2*k1);
    k3 = f(x(i) + h/2, Y(:,i) + h/2*k2);
    k4 = f(x(i) + h, Y(:,i) + h*k3);
    Y(:,i+1) = Y(:,i) + h/6*(k1 + 2*k2 + 2*k3 + k4);
  endfor
endfunction
