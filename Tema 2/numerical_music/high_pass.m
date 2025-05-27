function signal = high_pass(signal, fs, cutoff_freq)
  nr_sample = length(signal);
  spectru = fft(signal);
  frecvente = (0:nr_sample - 1) * fs / nr_sample;

  % Masca pt high-pass, 1 daca frecv > cutoff_freq
  masca = zeros(nr_sample, 1);
  if mod(nr_sample, 2) == 0
    for k = 1:nr_sample / 2
      if frecvente(k) > cutoff_freq
        masca(k) = masca(nr_sample + 1 - k) = 1;
      endif
    endfor
  else
    for k = 1:(nr_sample - 1) / 2
      if frecvente(k) > cutoff_freq
        masca(k) = masca(nr_sample + 1 - k) = 1;
      endif
    endfor
  endif

  % Spectrul filtrat
  spec = zeros(size(spectru));
  for i = 1:nr_sample
    spec(i) = spectru(i) * masca(i);
  endfor

  % Transformata inversa pe partea reala
  semnal_final = ifft(spec);

  % Normalizez la amplitudinea originala
  semnal_final = semnal_final / max(abs(semnal_final));

  signal = semnal_final(:);
end
