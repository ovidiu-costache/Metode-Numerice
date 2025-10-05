function I = Simpson_compus(f, a, b, n)
  if mod(n, 2) ~= 0
    error("n trebuie sa fie par pentru Simpson_compus");
  endif

  h = (b - a) / n;
  s = f(a) + f(b);

  for i = 1:n-1
    xi = a + i * h;
    if mod(i, 2) == 0
      s = s + 2 * f(xi);
    else
      s = s + 4 * f(xi);
    endif
  endfor

  I = h / 3 * s;
endfunction
