function [Y, InitialMatrix] = parse_csv_file(file_path)
  fin = fopen(file_path, 'rt');
  antet = fgetl(fin);

  linii = {};
  i = 1;
  while 1
    linie = fgetl(fin);
    if ischar(linie) == 0
      break;
    endif
    % sterg caracterele albe
    linii{i} = strtrim(linie);
    i = i + 1;
  endwhile
  fclose(fin);

  % nr de linii
  m = length(linii);
  % folosesc prima linie pt a afla nr de campuri, adica coloane
  coloane = strsplit(linii{1}, ',');
  n = length(coloane);

  Y = zeros(m, 1);
  InitialMatrix = cell(m, n - 1);
  for i = 1:m
    element = strsplit(linii{i}, ',');
    % convertesc primul element la numar, pt a retine pretul
    pret = str2double(element{1});
    Y(i) = pret;
    % continui parcurgerea elementelor de pe linie
    for j = 2:n
      % daca elementul este sir de caractere, ramane la fel
      if ischar(element{j})
        InitialMatrix{i, j-1} = element{j};
      else
        InitialMatrix{i, j-1} = str2double(element{j});
      endif
    endfor
  endfor
end
