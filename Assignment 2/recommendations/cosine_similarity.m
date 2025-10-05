function similarity = cosine_similarity(A, B)
  % TODO: Compute the cosine similarity between two column vectors.

  % Initializam variabilele pentru produsul scalar si norme
  prod_scalar = 0;
  norm_A = 0;
  norm_B = 0;

  for i = 1:length(A)
    prod_scalar = prod_scalar + A(i) * B(i); % produsul scalar
    norm_A = norm_A + A(i) ^ 2;
    norm_B = norm_B + B(i) ^ 2;
  endfor

  % Calculam normele finale (radacina patrata din suma patratelor)
  norm_A = sqrt(norm_A);
  norm_B = sqrt(norm_B);

  similarity = prod_scalar / (norm_A * norm_B);
end
