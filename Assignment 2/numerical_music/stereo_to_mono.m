function mono = stereo_to_mono(stereo)
  [nr_sample, nr_canale] = size(stereo);
  mono = zeros(nr_sample, 1);

  % Adaug valorile la mono pt fiecare canal
  for canal = 1:nr_canale
    mono = mono + stereo(:, canal);
  endfor

  % Impart la nr de canale pentru a obtine media
  mono = mono / nr_canale;

  % Normalize
  mono = mono / max(abs(mono));
end
