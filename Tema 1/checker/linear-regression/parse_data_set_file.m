function [Y, InitialMatrix] = parse_data_set_file(file_path)
  fin = fopen(file_path, 'rt');

  m = fscanf(fin, "%d", 1);
  n = fscanf(fin, "%d", 1);
  Y = zeros(m, 1);
  InitialMatrix = cell(m, n);

  for i = 1:m
    Y(i) = fscanf(fin, "%f", 1);

    for j = 1:n
      InitialMatrix{i, j} = fscanf(fin, "%s", 1);
    endfor
  endfor
  fclose(fin);
end
