xp = [0:20];
yp = sin(2*pi*xp/5);

xf = [0:0.05:20];
yf = sin(2*pi*xf/5);

for i = 1 : length(xf)
  lag(i) = Lagrange(xp, yp, xf(i));
  % new(i) = Newton(xp, yp, xf(i));
  % lin(i) = interp_liniara(xp, yp, xf(i));
endfor

plot(xf, yf, "r", xf, lag, "g", xp, yp, "ko", "markersize", 15);
legend("original", "Lagrange");
