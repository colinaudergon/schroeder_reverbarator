function audioCaptureStart(recorder)
  if strcmpi(class(recorder), 'audiorecorder')
    record(recorder);
    disp("Recording started");
  else
    error("recorder must be an object of type audiorecorder")
  endif
  endfunction