function I = Simpson_simplu(f, a, b)
  m = (a + b) / 2;
  I = (b - a) / 6 * (f(a) + 4 * f(m) + f(b));
endfunction
