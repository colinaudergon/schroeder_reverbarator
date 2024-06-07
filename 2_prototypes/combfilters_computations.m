clear all

%Computes the gain for a given T60
%T60 = desired Time for -60dB output magnitude [s]
%K = delay line length 
%Fs = sampling frequency [Hz]
function g = computeGainFromT60(T60,K, Fs)
  g = 0.001^(K/(Fs*T60));
endfunction

%Computes the loop time value for a given delay line length
%K = delay line length 
%Fs = sampling frequency [Hz]

function tau = computeLoopTimeFromDelayLineLength(K,Fs)
  tau = K/Fs;
  endfunction

%Computes the delay line length for a given loop time value in seconds
%Tau = loop time [s]
%Fs = sampling frequency [Hz]
function k = computeDelayLineLengthFromLoopTimeS(Tau,Fs)
 k = ceil(Tau*Fs); 
 endfunction

%Computes the delay line length for a given loop time value in ms
%Tau = loop time [s]
%Fs = sampling frequency [Hz]
function k = computeDelayLineLengthFromLoopTimeMs(Tau,Fs)
 k = ceil(Tau/1000*Fs); 
endfunction  


Fs = 44100;

%33 37 40 43 -> are coprime
% Computation comb filter n° 1
% 43ms
% T60 = 2s
tl_c1 = 43;
T60_c1 = 2;
K_c1 = computeDelayLineLengthFromLoopTimeMs(tl_c1,Fs);
g_c1 = computeGainFromT60(T60_c1,K_c1,Fs);


% Computation comb filter n° 2
% 40 ms 
% T60 = 1/3 of 2s
tl_c2 = 40;
T60_c2 = T60_c1/3;
K_c2 = computeDelayLineLengthFromLoopTimeMs(tl_c2,Fs);
g_c2 = computeGainFromT60(T60_c2,K_c2,Fs);


% Computation comb filter n° 3
% 37 ms 
% T60 = 1/6 of 2s
tl_c3 = 37;
T60_c3 = T60_c1/9;
K_c3 = computeDelayLineLengthFromLoopTimeMs(tl_c3,Fs);
g_c3 = computeGainFromT60(T60_c3,K_c3,Fs);

% Computation comb filter n° 4
% 33 ms 
% T60 = 1/27 of 2s
tl_c4 = 33;
T60_c4 = T60_c1/27;
K_c4 = computeDelayLineLengthFromLoopTimeMs(tl_c4,Fs);
g_c4 = computeGainFromT60(T60_c4,K_c4,Fs);



disp("Gain:")
disp(g_c1);
disp(g_c2);
disp(g_c3);
##disp(g_c4);

disp("Decay time")
disp(T60_c1);
disp(T60_c2);
disp(T60_c3);
disp(T60_c4);

disp("Delay lines sizes: ")
disp(K_c1);
disp(K_c2);
disp(K_c3);
disp(K_c4);