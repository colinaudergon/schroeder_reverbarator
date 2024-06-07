%Computes the delay line length for a given loop time value in ms
%Tau = loop time [ms]
%Fs = sampling frequency [Hz]
function k = computeDelayLineLengthFromLoopTimeMs(Tau,Fs)
 k = ceil((Tau/1000)*Fs); 
endfunction
