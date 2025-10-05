function [Labyrinth] = parse_labyrinth(file_path)
  fin = fopen(file_path, 'rt');
  m = fscanf(fin, "%d", 1);
  n = fscanf(fin, "%d", 1);
  Labyrinth = zeros(m, n);

  for i = 1:m
     for j = 1:n
       Labyrinth(i, j) = fscanf(fin, "%d", 1);
     endfor
  endfor

  fclose(fin);
end
