function recoms = recommendations(path, liked_theme, num_recoms, min_reviews, num_features)
  % TODO: Get the best `num_recoms` recommandations similar with 'liked_theme'.
  mat = read_mat(path);
  mat = preprocess(mat, min_reviews);
  [nr_clienti, nr_teme] = size(mat);

  % Calculez SVD redus
  k = min([num_features, nr_clienti, nr_teme]);
  [~, ~, V] = svds(mat, k); % V: nr_teme x k

  % Calculez similaritatea cosinus intre tema preferata si toate temele
  similaritati = zeros(1, nr_teme);
  v_liked = V(liked_theme, :); % vectorul temei preferate
  for i = 1:nr_teme
    v_tema = V(i, :);
    similaritati(i) = cosine_similarity(v_liked', v_tema');
  endfor

  % Sortez crescator temele dupa similaritate
  [~, ord] = sort(similaritati);

  % Elimin tema preferata din lista
  new_ord = [];
  for i = 1:length(ord)
    if ord(i) != liked_theme
      new_ord(end + 1) = ord(i);
    endif
  endfor
  ord = new_ord;

  % Inversez vectorul pentru a obtine ordinea descrescatoare
  ord = ord(end:-1:1);
  % Iau primii num_recoms indici
  recoms = ord(1:min(num_recoms, length(ord)));
end
