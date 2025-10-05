function val = TwoPoints(f, h, x0)
  val = (f(x0 + h) - f(x0)) / h;
endfunction
