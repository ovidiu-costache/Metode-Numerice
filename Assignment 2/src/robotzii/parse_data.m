function [x, y] = parse_data(filename)
  % file input format:
  % n
  % x0 x1 ... xn
  % y0 y1 ... yn

  % TODO 1: Open the file for reading
  fin = fopen(filename, "r");

  % TODO 2: Read n, x, y from the file
  n = fscanf(fin, "%d", 1);
  % citesc abscisele si ordonatele ca vectori linie
  x = fscanf(fin, "%f", n+1);
  y = fscanf(fin, "%f", n+1);
  % transform in vectori coloana
  x = x(:);
  y = y(:);

  % TODO 3: Close the file
  fclose(fin);
end
