function y = scaleAudio(x)
  y = x/max(x) - mean(x);
  endfunction