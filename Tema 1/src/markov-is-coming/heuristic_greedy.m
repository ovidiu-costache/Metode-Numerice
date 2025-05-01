function [path] = heuristic_greedy(start_position, probabilities, Adj)
  nr_stari = size(Adj, 1);
  stare_WIN = nr_stari - 1;

  path = [start_position];
  vizitate = zeros(nr_stari, 1);
  vizitate(start_position) = 1;

  while (length(path) > 0)
    pozitie = path(end);
    if pozitie == stare_WIN
      return;
    endif

    vecin_gasit = 0;
    vecin_bun = -1;
    probabilitate = -999999999;

    for j = 1:nr_stari
      % daca exista legatura de la starea curenta si starea j, iar starea j nu a fost vizitata
      if (Adj(pozitie, j) > 0) && (vizitate(j) == 0)
        % verific probabilitatea starii j
        if (probabilities(j) > probabilitate)
          probabilitate = probabilities(j);
          vecin_bun = j;
          vecin_gasit = 1;
        endif
      endif
    endfor

    if vecin_gasit == 0
      path(end) = []; % elimin ultima stare din path
    else
      vizitate(vecin_bun) = 1;
      path = [path, vecin_bun];
    endif
  endwhile
end
