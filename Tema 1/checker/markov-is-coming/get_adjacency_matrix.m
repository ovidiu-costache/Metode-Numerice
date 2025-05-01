function [Adj] = get_adjacency_matrix(Labyrinth)
    [m, n] = size(Labyrinth);
    dim = m * n + 2;
    Adj = zeros(dim, dim);

    for i = 1:m
      for j = 1:n
        stare = (i - 1) * n + j;
        val = Labyrinth(i, j);
        temp = val;
        % extrag cei 4 biti pt punctele cardinale
        biti = zeros(1, 4);
        for k = 4:-1:1
          biti(k) = mod(temp, 2);
          temp = floor(temp / 2);
        endfor

        % Nord
        if biti(1) == 0
          if i == 1
            % iesire spre WIN
            urm = m * n + 1;
           else
             % nodul de sus
             urm = (i - 2) * n + j;
           endif
             Adj(stare, urm) = 1;
         endif

         % Sud
         if biti(2) == 0
           if i == m
             % iesire spre WIN
             urm = m * n + 1;
           else
             % nodul de jos
             urm = i * n + j;
           endif
           Adj(stare, urm) = 1;
         endif

         % Est
         if biti(3) == 0
           if j == n
             % iesire spre LOSE
             urm = m * n + 2;
           else
             % nodul din dreapta
             urm = (i - 1) * n + (j + 1);
           endif
           Adj(stare, urm) = 1;
         endif

         % Vest
         if biti(4) == 0
           if j == 1
             % iesire spre LOSE
             urm = m * n + 2;
           else
             % nodul din stanga
             urm = (i - 1) * n + (j - 1);
           endif
           Adj(stare, urm) = 1;
          endif
      endfor
    endfor

    stare_WIN = m * n + 1;
    stare_LOSE = m * n + 2;
    Adj(stare_WIN, stare_WIN) = 1;
    Adj(stare_LOSE, stare_LOSE) = 1;
end
