%Function that creates the filters and process the audio data

function y = reverbProcess(audioInput,tl_cmfs,tr_cmf,tl_apfs,tr_apfs, Fs)
  
  cmfReverbTime = tr_cmf;

  tl_cmf1 = tl_cmfs(1); %ms
  tl_cmf2 = tl_cmfs(2); %ms
  tl_cmf3 = tl_cmfs(3); %ms
  tl_cmf4 = tl_cmfs(4); %ms
   
  cmf1 = combFilter(tl_cmf1,cmfReverbTime,Fs);
  cmf2 = combFilter(tl_cmf2,cmfReverbTime,Fs);
  cmf3 = combFilter(tl_cmf3,cmfReverbTime,Fs);
  cmf4 = combFilter(tl_cmf4,cmfReverbTime,Fs);

  % creates 2 all pass filters
  tl_apf1 = tl_apfs(1); %ms
  tl_apf2 = tl_apfs(2); %ms

  tr_apf1 = tr_apfs(1); %s
  tr_apf2 = tr_apfs(2); %s

  apf1 = allPassFilters(tl_apf1,tr_apf1,Fs);
  apf2 = allPassFilters(tl_apf2,tr_apf2,Fs);

  % passes the audio throught the filters

   % Apply the input signal to each comb filter
  cmf1 = cmf1.filterOutput(audioInput);
  cmf2 = cmf2.filterOutput(audioInput);
  cmf3 = cmf3.filterOutput(audioInput);
  cmf4 = cmf4.filterOutput(audioInput);

  combinedOutput = cmf1.filterOut + cmf2.filterOut + cmf3.filterOut + cmf4.filterOut;

  apf1 = apf1.filterOutput(combinedOutput);
  apf2 = apf2.filterOutput(apf1.filterOut);
  
  y = apf2.filterOut;
  endfunction