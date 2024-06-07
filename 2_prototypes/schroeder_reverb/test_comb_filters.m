clear all

%test the comb filter implementation

Fs = 44100;

cmf1_reverb_time = 2;
tl = 0.00575 *1000;

cmf1=combFilter(tl,cmf1_reverb_time,Fs); 

% Create a sample input signal
pulse_length = 1*Fs
pulse = zeros(1,pulse_length);
pulse(1) = 1;

 cmf1= cmf1.filterOutput(pulse);
pulse_out = cmf1.content;
scaled_pulse_out = pulse_out/max(pulse_out)-mean(pulse_out);

disp("difference between pulse 1 and 2:")

p1 = scaled_pulse_out(1,255 + cmf1.delayLineSize)
p2 = scaled_pulse_out(1,255 + 2*cmf1.delayLineSize)

disp("gain:")
disp(p2/p1 )


% Plot the input and output signals
##subplot(3, 1, 1);
##stem(pulse);
##title('Input Signal');
##xlabel('Sample');
##ylabel('Amplitude');
##
##subplot(3, 1, 2);
##stem(pulse_out);
##title('Output Signal');
##xlabel('Sample');
##ylabel('Amplitude');
##
##subplot(3, 1, 3);
##stem(scaled_pulse_out);
##title('Scaled Output Signal');
##xlabel('Sample');
##ylabel('Amplitude');


filename = "./audio/audio_out/comb_filter_impulse_response.ogg";
##audiowrite(filename, scaled_pulse_out, Fs);