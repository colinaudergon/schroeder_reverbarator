function stopRecordingCallback(hObject,~,recorder,hFig)
  audio_data = audioCaptureStop(recorder);
  Fs = get(recorder,"SampleRate");
  
  global processed_audio;
  global wet_dry_level;
  global tl_cmfs;
  global tr_cmf;
  global tl_apfs;
  global tr_apfs;
  
  reverbered_audio = scaleAudio(reverbProcess(audio_data,tl_cmfs,tr_cmf,tl_apfs,tr_apfs, Fs));
  processed_audio = audioDryWet(audio_data,reverbered_audio,wet_dry_level);
   
  figure(hFig); % Switch to the UI figure
  
  ax = axes('Units', 'pixels', 'Position', [500, 200, 250, 250]); % Specify position and size in pixels
  plot(ax, processed_audio);
  title('Processed Audio Signal');
  xlabel('Sample Number');
  ylabel('Amplitude');
  
endfunction