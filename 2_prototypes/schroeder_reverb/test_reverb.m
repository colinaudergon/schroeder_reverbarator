
addpath("./audio_utils")


%Reads content of the clap audio file
filename='./audio/audio_in/test_speaking.ogg';
info = audioinfo (filename);
nbits = info.BitsPerSample;
if nbits < 0
  nbits = 24
  endif
[y,Fs] = audioread(filename,'native');

scaled_y = y/max(y) - mean(y);

% Creates 4 comb filters
cmfReverbTime = 1;

tl_cmf1 = 29.7; %ms
tl_cmf2 = 37.1; %ms
tl_cmf3 = 41.1; %ms
tl_cmf4 = 43.7; %ms
 
cmf1 = combFilter(tl_cmf1,cmfReverbTime,Fs);
cmf2 = combFilter(tl_cmf2,cmfReverbTime,Fs);
cmf3 = combFilter(tl_cmf3,cmfReverbTime,Fs);
cmf4 = combFilter(tl_cmf4,cmfReverbTime,Fs);

% creates 2 all pass filters
tl_apf1 = 96.83; %ms
tl_apf2 = 32.92; %ms

tr_apf1 = 0.005; %s
tr_apf2 = 0.0017; %s

apf1 = allPassFilters(tl_apf1,tr_apf1,Fs);
apf2 = allPassFilters(tl_apf2,tr_apf2,Fs);

% passes the audio throught the filters

 % Apply the input signal to each comb filter
cmf1 = cmf1.filterOutput(scaled_y);
cmf2 = cmf2.filterOutput(scaled_y);
cmf3 = cmf3.filterOutput(scaled_y);
cmf4 = cmf4.filterOutput(scaled_y);

combinedOutput = cmf1.filterOut + cmf2.filterOut + cmf3.filterOut + cmf4.filterOut;

apf1 = apf1.filterOutput(combinedOutput);
apf2 = apf2.filterOutput(apf1.filterOut);

audio_out = audioDryWet(scaled_y,apf2.filterOut,0.1);
##audio_out = apf2.filterOut/max(apf2.filterOut) - mean(apf2.filterOut);

% Plot the input and output signals
subplot(2, 1, 1);
plot(scaled_y(1:1000));
title('Input Signal');
xlabel('Sample');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(audio_out);
title('Combined Output Signal');
xlabel('Sample');
ylabel('Amplitude');

filename_out = "./audio/audio_out/test_speaking_wet10.ogg"
audiowrite(filename_out, audio_out, Fs);