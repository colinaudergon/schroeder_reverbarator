classdef allPassFilters
  properties
    reverbTime = 0; %T60 time (silence) [s]
    loopTime = 0; % for data to go trough the delay line [ms]
    delayLineSize = 0;
    
    a = 0;
    b = 1;
    
    filterOut = 0;
    gain = 0;
    content = 0;
  endproperties
  methods
    function apf = allPassFilters(loopTime,reverbTime,samplingFrequency)
      
      apf.reverbTime = reverbTime; %s
      apf.loopTime = loopTime/1000; %ms
      
      apf.delayLineSize = ceil(apf.loopTime * samplingFrequency);
      disp("Delay line size: ")
      disp(apf.delayLineSize);
      apf.gain = 0.001^(apf.delayLineSize/(samplingFrequency*apf.reverbTime));
      disp("Gain: ");
      disp(apf.gain);
      apf.content = zeros(1,apf.delayLineSize-1);  
      
      apf.a = [1, zeros(1, apf.delayLineSize-1), -apf.gain]; % Denominator: 1 - g*z^-N
      
    endfunction
    
    function apf = filterOutput(apf,audioIn)
      apf.content = filter(apf.b, apf.a, audioIn);
      apf.filterOut = apf.content;
    endfunction
    
  endmethods
endclassdef