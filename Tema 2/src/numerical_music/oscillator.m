function x = oscillator(freq, fs, dur, A, D, S, R)
  t = 0:1/fs:(dur - 1/fs);
  nr_sample = length(t);

  % Unda sinusoidala
  unda = zeros(1, nr_sample);
  for i = 1:nr_sample
    unda(i) = sin(2 * pi * freq * t(i));
  endfor

  % Nr de esantioane pentru fiecare faza
  attack = floor(A * fs);
  decay = floor(D * fs);
  release = floor(R * fs);
  sustain = nr_sample - (attack + decay + release);
  if sustain < 0
    sustain = 0;
  endif

  envelope = zeros(1, nr_sample);

  % Atac: 0 la 1
  for i = 1:attack
    envelope(i) = (i-1) / max(1, attack-1);
  endfor

  % Decay: 1 la S
  for i = 1:decay
    poz = attack + i;
    envelope(poz) = 1 - (1-S) * (i-1) / max(1, decay-1);
  endfor

  % Sustain: S constant
  for i = 1:sustain
    poz = attack + decay + i;
    envelope(poz) = S;
  endfor

  % Release: S la 0
  for i = 1:release
    poz = attack + decay + sustain + i;
    envelope(poz) = S * (1 - (i-1)/max(1, release-1));
  endfor

  % Aplic envelope pe unda
  x = zeros(1, nr_sample);
  for i = 1:nr_sample
    x(i) = unda(i) * envelope(i);
  endfor

  x = x(:);
end
