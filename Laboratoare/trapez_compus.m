function I = trapez_compus(f, a, b, n)
  h = (b - a) / n;
  s = f(a) + f(b);
  for i = 1:n-1
    xi = a + i * h;
    s = s + 2 * f(xi);
  endfor
  I = h / 2 * s;
endfunction
