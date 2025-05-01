function [x, p] = SOR(A, b, x0, tol, maxiter, w)
  [n, ~] = size(A);
  x = x0;

  for p = 1:maxiter
     for i = 1:n
       suma1 = A(i, 1:i-1) * x(1:i-1);
       suma2 = A(i, i+1:n) * x0(i+1:n);
       x(i) = (1 - w) * x0(i) + (w / A(i, i)) * (b(i) - suma1 - suma2);
     endfor

     if norm(x - x0) < tol
       break;
     endif
     x0 = x;
  endfor
endfunction

