%Computes the gain for a given T60
%T60 = desired Time for -60dB output magnitude [s]
%K = delay line length 
%Fs = sampling frequency [Hz]
function g = computeGainFromT60(T60,K, Fs)
  g = 0.001^(K/(Fs*T60));
endfunction