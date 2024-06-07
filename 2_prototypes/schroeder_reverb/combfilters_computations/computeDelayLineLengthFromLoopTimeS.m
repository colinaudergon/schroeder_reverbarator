%Computes the delay line length for a given loop time value in S
%Tau = loop time [s]
%Fs = sampling frequency [Hz]
function k = computeDelayLineLengthFromLoopTimeS(Tau,Fs)
 k = ceil((Tau)*Fs); 
endfunction
