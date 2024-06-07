%Computes the loop time value for a given delay line length
%K = delay line length 
%Fs = sampling frequency [Hz]

function tau = computeLoopTimeFromDelayLineLength(K,Fs)
  tau = K/Fs;
  endfunction
