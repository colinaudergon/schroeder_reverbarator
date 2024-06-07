
clear all
%test the all pass filter implementation

Fs = 44100;

apf1_reverb_time = 2;
tl = 0.00575 *1000;

apf1 =allPassFilters(tl,apf1_reverb_time,Fs); 

% Create a sample input signal
pulse_length = 1*Fs
pulse = zeros(1,pulse_length);
pulse(1) = 1;


filename = "./audio/audio_out/all_pass_filter_impulse_response.ogg";


% Apply the filter to the input signal
apf1 = apf1.filterOutput(pulse);
pulse_out = apf1.content;
% Scales the pulse for a correct audio output
scaled_pulse_out = pulse_out/max(pulse_out)-mean(pulse_out);

% Plot the input and output signals
subplot(3, 1, 1);
stem(pulse);
title('Input Signal');
xlabel('Sample');
ylabel('Amplitude');

subplot(3, 1, 2);
stem(pulse_out);
title('Output Signal');
xlabel('Sample');
ylabel('Amplitude');

subplot(3, 1, 3);
stem(scaled_pulse_out);
title('Scaled Output Signal');
xlabel('Sample');
ylabel('Amplitude');

##audiowrite(filename, pulse_out/max(pulse_out)-mean(pulse_out), Fs);