clear all
addpath("./audio_utils")
fs = 44100;
nbits = 16;
nchannels = 1;
recorder = audiorecorder (fs, nbits, nchannels);

audioCaptureStart(recorder);

userInput = input('Enter "stop" to end recording or press Enter to start recording: ', 's');
  while true
    if strcmpi(userInput, 'stop')
      y = audioCaptureStop(recorder);
      break;  
    endif
  endwhile
