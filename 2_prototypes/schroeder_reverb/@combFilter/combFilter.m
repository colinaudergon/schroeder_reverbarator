classdef combFilter
  properties
    reverbTime = 0; % T60 time (silence) [s]
    loopTime = 0; % for data to go through the delay line [ms]
    delayLineSize = 0;
    
    a = 0;
    b = 1;
    
    filterOut = 0;
    gain = 0;
    content = 0;
  endproperties
  
  methods
    % Constructor
    function c = combFilter(loopTime, reverbTime, samplingFrequency)
      c.reverbTime = reverbTime; % s
      c.loopTime = loopTime / 1000; % ms
      
      c.delayLineSize = ceil(c.loopTime * samplingFrequency);
      disp("Delay line size: ")
      disp(c.delayLineSize);
      c.gain = 0.001^(c.delayLineSize / (samplingFrequency * c.reverbTime));
      disp("Gain: ");
      disp(c.gain);
      c.content = zeros(1, c.delayLineSize);  
      
      % Filter coefficients
      c.a = [1, zeros(1, c.delayLineSize-1), -c.gain]; % Denominator: 1 - g*z^-N
      c.b = [c.gain, zeros(1, c.delayLineSize-1), 1]; % Numerator: g + z^-N
    endfunction
    
    % Method to apply the filter
    function c = filterOutput(c, audioIn)
      c.content = filter(c.b, c.a, audioIn);
      c.filterOut = c.content;
    endfunction
    
  endmethods
endclassdef