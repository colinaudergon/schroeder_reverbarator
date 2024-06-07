function generateImpulseAudio(Fs, savePath,pulse_length,signal_length)
  % Ensure the savePath ends without a trailing slash
  if savePath(end) == '/'
    savePath = savePath(1:end-1);
  endif
  
  if pulse_length < signal_length
    
  
  % Construct the filename
  filename = strcat(savePath, "/impulse.ogg");
  
  % Create the impulse signal
  duration = signal_length; % duration of 10 seconds
  y = zeros(Fs * duration, 1); % create a zero array for 10 seconds
  
  y(1:Fs*pulse_length) = 0.5; % create an impulse of 10 ms duration
  
  disp("Writes audio file")
  % Write the audio file
  audiowrite(filename, y, Fs);
  
  figure;
  plot(y);
  xlabel("index [n]");
  ylabel("Amplitude (Normalized)");
  title(['Audio pulse']);
  drawnow;
  
  newAudioPlayer = audioplayer (y, Fs, 24);
  disp(newAudioPlayer);
  
  
else
  error("Pulse length greater than signal length");
  
endif

endfunction