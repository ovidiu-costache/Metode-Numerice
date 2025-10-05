function [Link] = get_link_matrix(Labyrinth)
    Adj = get_adjacency_matrix(Labyrinth);
    [n, n] = size(Adj);
    Link = zeros(n, n);

    for i = 1:n
      % calculez nr total de tranzitii
      tranzitii = sum(Adj(i, 1:n));
      if tranzitii > 0
        for j = 1:n
          % daca exista o muschie de la i la j
          if Adj(i, j) != 0
            % se calculeaza probabilitatea
            Link(i, j) = 1 / tranzitii;
          endif
        endfor
      endif
    endfor
end
