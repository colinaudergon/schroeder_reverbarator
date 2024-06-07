function y = audioCaptureStop(recorder)
    if strcmpi(class(recorder), 'audiorecorder')
    stop(recorder);
    disp("Recording stoped");
    y = getaudiodata(recorder);
  else
    error("recorder must be an object of type audiorecorder")
  endif
  endfunction