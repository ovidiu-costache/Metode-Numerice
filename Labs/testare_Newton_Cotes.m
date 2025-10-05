function testare_Newton_Cotes()
  format long;
	f = @(x) sin(x);
  a = 0;
  b = pi;
  n = 10; % n = 40;

  trapez_simplu = trapez_simplu(f, a, b)
  Simpson_simplu = Simpson_simplu(f, a, b)
  trapez_compus = trapez_compus(f, a, b, n)
  Simpson_compus = Simpson_compus(f, a, b, n)
endfunction
