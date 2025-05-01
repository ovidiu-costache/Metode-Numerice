function [x, err, steps] = perform_iterative (G, c, x0, tol, max_steps)
  % am luat algoritmul pt Jacobi facut la laborator si l am adaptat la cerinta data
  n = length(x0);
  x = zeros(n, 1);
  err = 0;
  steps = 0;

  for p = 1:max_steps
    for i = 1:n
      x(i) = c(i) + G(i, 1:n) * x0;
    endfor

    err = norm(x - x0);
    if err < tol
      steps = p;
      break;
    endif

    x0 = x;
    steps = p;
  endfor
end
