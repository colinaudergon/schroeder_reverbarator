%Function to mix wet and dry audio signals
% audioDry: the dry audio signal
% audioWet: the wet audio signal
% mixLevelWet: level of wet signal at the output (normalized [0-1])

function y = audioDryWet(audioDry,audioWet,mixLevelWet)
  % Makes sure mix level is normalized
    if mixLevelWet < 0 || mixLevelWet > 1
      error('mixLevelWet should be between 0 and 1');
  end
    % Ensure the audio signals have the same length
  if length(audioDry) ~= length(audioWet)
      error('audioDry and audioWet must have the same length');
  end
  
  y = (1 - mixLevelWet) * audioDry + mixLevelWet * audioWet;
  endfunction