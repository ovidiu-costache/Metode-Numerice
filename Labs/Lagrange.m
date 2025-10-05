function val = Lagrange(x, y, c)
  n = length(x);
  val = 0;

  for j = 1:n
    L = 1;
    for i = 1:n
      if i != j
        L = L * (c - x(i)) / (x(j) - x(i));
      endif
    endfor
    val = val + y(j) * L;
  endfor
endfunction
