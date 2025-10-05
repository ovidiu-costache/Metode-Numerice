function signal = apply_reverb(signal, impulse_response)
  impulse_response = stereo_to_mono(impulse_response);
  rezultat = conv(signal, impulse_response);

  % Normalizare
  rezultat = rezultat / max(abs(rezultat));

  signal = rezultat(:);
end
