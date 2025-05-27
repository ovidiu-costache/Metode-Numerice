function reduced_mat = preprocess(mat, min_reviews)
  % TODO: Remove all user rows from `mat` that have strictly less then `min_reviews` reviews.

  % Initializez un vector pt indecsii clientilor ramasi
  idx = [];
  for i = 1:size(mat, 1)
    nr = 0; % numaram cate review-uri are clientul "i"
    for j = 1:size(mat, 2)
      if mat(i, j) != 0
        nr = nr + 1;
      endif
    endfor
    if nr >= min_reviews
      idx = [idx; i]; % adaugam indexul clientului care ramane
    endif
  endfor

  % Construim matricea redusa doar cu clientii care au destule review-uri
  reduced_mat = mat(idx, :);
end
