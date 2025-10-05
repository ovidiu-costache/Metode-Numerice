function val = ThreePoints_End(f, h, x0)
  val = (-3 * f(x0) + 4 * f(x0 + h) - f(x0 + 2*h)) / (2 * h);
endfunction
