function [decoded_path] = decode_path (path, lines, cols)
    index = [];
    % pastrez indicii care e afla in labirint
    for i = 1:length(path)
      if path(i) <= lines * cols
        index(end+1) = path(i);
      endif
    endfor

    n = length(index);
    decoded_path = zeros(n, 2);

    % calculez coordonatele pt fiecare index valid
    for i = 1:n
      poz = index(i);
      % linia curenta
      l = floor((poz - 1) / cols) + 1;
      % coloana curenta
      c = mod(poz - 1, cols) + 1;
      decoded_path(i, 1:2) = [l, c];
    endfor
end
