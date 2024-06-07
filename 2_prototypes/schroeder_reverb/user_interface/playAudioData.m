function playAudioData(hObject,~,Fs)
  global processed_audio;
  player = audioplayer (processed_audio, Fs);
  playblocking (player);
endfunction