function val = interp_liniara(x, y, dy, c)
  n=length(x);

  for i-1:n-1
    if c>=x(i)&&c<=x(i+1)
      a=(y(i+1)-y(i))/(x(i+1)-x(i));
      b=(y(i)*x(i+1)-y(i+1)*x(i))/x(i+1)-x(i);
      val=a*c+b;
      break;
    endif
  endfor
endfunction
