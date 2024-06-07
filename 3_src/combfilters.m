% Experimenting with comb filter generation and audio processing

clear all
%Adds the folder containing the function used to compute the propreties of the comb filters
addpath("./combfilters_computations");



function testCombFiltersWithClap(cfilters,Fs)
  
  %Opens audio file
  filename='./audio/audio_in/clap.ogg';
  [y,fss] = audioread(filename,'native');

  plot_length = length(y)
  audio_out = zeros(5,plot_length);

  info = audioinfo (filename);
  fs = info.SampleRate;

  nbits = info.BitsPerSample;
  if nbits < 0
  nbits = 24
  endif

  player = audioplayer (y(1:plot_length)./max(y(1:plot_length))-mean(y(1:plot_length)), fss, nbits);
  play(player);

  while(isplaying(player))
  end

  start_compute_time = time();
  for i = 1:4*plot_length
  % Compute filter outputs for y(i) using array operations
  filter_outputs = zeros(4, 1);

  for f = 1:4
    if i >= plot_length
       cfilters(f) = cfilters(f).filterOutput(y(ceil(i/4)));
      else
        cfilters(f) = cfilters(f).filterOutput(y(i));
      endif
       filter_outputs(f)=cfilters(f).filterOut;
  endfor

  % Store filter outputs in audio_out
  audio_out(1:4, i) = filter_outputs;

  % Compute audio_out(5, i)
  if i >= plot_length
  audio_out(5, i) = (sum(filter_outputs)+ y(ceil(i/4))/2);
  else
  audio_out(5, i) = (sum(filter_outputs)+ y(i)/2);
  endif
endfor

computation_time = time()-start_compute_time;
disp("loop computation time:")
disp(computation_time)

start_scaling_time = time();

%Scale the audio, removes possible dc offset
audio_out(5,:) = audio_out(5,:)./max(audio_out(5,:))- mean(audio_out(5,:));

end_scaling_time = time();
disp("scaling time:")
disp(end_scaling_time- start_scaling_time);

end_compute_time = time();
delta_time = end_compute_time - start_compute_time;
disp("Computation time: ");

disp(delta_time);

figure;
plot(audio_out(5,:));
xlabel("index [n]");
ylabel("Amplitude (Normalized)");
title(['clap with combFilter']);
drawnow;
audiowrite(filename, audio_out(5,:), Fs);


endfunction


function testCombFiltersWithImpulse(cfilters,Fs)
  
  %Opens audio file
  filename='./audio/audio_out/impulse.ogg';
  
  
  [y,fss] = audioread(filename,'native');

  plot_length = length(y)
  audio_out = zeros(5,plot_length);

  info = audioinfo (filename);
  fs = info.SampleRate;

  nbits = info.BitsPerSample;
  if nbits < 0
  nbits = 24
  endif

  player = audioplayer (y(1:plot_length)./max(y(1:plot_length))-mean(y(1:plot_length)), fss, nbits);
  play(player);

  while(isplaying(player))
  end

  start_compute_time = time();
  disp("Start time:");
  disp(start_compute_time);
  for i = 1:4*plot_length
  % Compute filter outputs for y(i) using array operations
  filter_outputs = zeros(4, 1);

  for f = 1:4
    if i >= plot_length
       cfilters(f) = cfilters(f).filterOutput(y(ceil(i/4)));
      else
        cfilters(f) = cfilters(f).filterOutput(y(i));
      endif
       filter_outputs(f)=cfilters(f).filterOut;
  endfor

  % Store filter outputs in audio_out
  audio_out(1:4, i) = filter_outputs;

  % Compute audio_out(5, i)
  if i >= plot_length
  audio_out(5, i) = (sum(filter_outputs)+ y(ceil(i/4))/2);
  else
  audio_out(5, i) = (sum(filter_outputs)+ y(i)/2);
  endif
endfor

computation_time = time()-start_compute_time;
disp("loop computation time:")
disp(computation_time)

start_scaling_time = time();

%Scale the audio, removes possible dc offset
audio_out(5,:) = audio_out(5,:)./max(audio_out(5,:))- mean(audio_out(5,:));

end_scaling_time = time();
disp("scaling time:")
disp(end_scaling_time- start_scaling_time);

end_compute_time = time();
delta_time = end_compute_time - start_compute_time;
disp("Computation time: ");
disp(delta_time);

figure;
plot(audio_out(5,:));
xlabel("index [n]");
ylabel("Amplitude (Normalized)");
title(['Audio pulse with combFilter']);
drawnow;
audiowrite("filtered_pulse.ogg",audio_out(5,:) , Fs)
endfunction

Fs = 44100;
pulse_length = 0.01;%s
signal_length = 1; %s
generateImpulseAudio(Fs,"./audio/audio_out",pulse_length,signal_length);

nbrOfFilters = 4;
decay_time_initial = 2;

%Loop time of comb filters
tl_combs = [43,40,33,37];

%Create array od zeros to contain comb filters parameters
delay_lines_sizes=zeros(1,nbrOfFilters);
gains = zeros(1,nbrOfFilters);
decay_times = zeros(1,nbrOfFilters);

for i = 1:nbrOfFilters
  
  if i != 1
    decay_times(i) = decay_times(i-1)*10;
  else
    decay_times(i) = decay_time_initial;
  endif
  delay_lines_sizes(i) = computeDelayLineLengthFromLoopTimeMs(tl_combs(i),Fs);
  gains(i) = computeGainFromT60(decay_times(i),delay_lines_sizes(i),Fs);
  delay_lines_sizes(i) = delay_lines_sizes(i);
  %Creates an array containing the combfilters objects
  cfilters(i) = combFilter(2*max(delay_lines_sizes),delay_lines_sizes(i),gains(i));
  disp(cfilters(i).gain)
endfor

disp("Gains");
disp(gains);
disp("Decay times");
disp(decay_times);
disp("Delay lines sizes");
disp(delay_lines_sizes);


disp("Test comb filters with impulse")
##testCombFiltersWithImpulse(cfilters,Fs);

##testCombFiltersWithClap(cfilters)




