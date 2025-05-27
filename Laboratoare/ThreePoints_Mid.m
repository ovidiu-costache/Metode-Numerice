function val = ThreePoints_Mid(f, h, x0)
  val = (f(x0 + h) - f(x0 - h)) / (2 * h);
endfunction
