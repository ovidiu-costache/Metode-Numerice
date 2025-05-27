function [S f t] = spectrogram(signal, fs, window_size)
  lungime = length(signal);
  nr_ferestre = floor(lungime / window_size);

  fft_size = 2 * window_size;

  % Initializez matricea spectrograma
  S = zeros(fft_size/2, nr_ferestre);

  % Parcurg fiecare fereastra
  for indice = 1:nr_ferestre
    % Indexul de inceput si sfarsit pentru fragmentul curent
    inceput = (indice - 1) * window_size + 1;
    sfarsit = inceput + window_size - 1;

    % Fragmentul de semnal pt fereastra curenta
    fragment = signal(inceput:sfarsit);
    fereastra = hanning(window_size);

    % Aplic fereastra Hann pe fragment
    frag = zeros(window_size, 1);
    for k = 1:window_size
      frag(k) = fragment(k) * fereastra(k);
    endfor

    spectru = fft(frag, fft_size);
    % Pastrez doar prima jumatate (simetrie fata de mijloc)
    spectru = spectru(1:fft_size/2);
    S(:, indice) = abs(spectru);
  endfor

  % Vectorul de frecvente (axa Y in spectograma)
  f = (0:(fft_size/2 - 1))' * fs / fft_size;
  % Vectorul de timp (axa X in spectograma)
  t = ((0:nr_ferestre-1) * window_size) / fs;
  t = t'; % ca sa fie vector coloana
end
