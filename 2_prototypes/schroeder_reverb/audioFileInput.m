clear all
filename='cosine.ogg';
##filename = "clap.wav";
info = audioinfo (filename);
disp(info)

fs = info.SampleRate;
nbits = info.BitsPerSample;
if nbits < 0
  nbits = 24
  endif
[y,fss] = audioread(filename,'native');
class(y)
ndims(y)

  


player = audioplayer (y, fss, nbits);
play (player);

##audiowrite(filename, signal, fs);