%audio capture script

% Define the base directory to save the file
baseDir = './audio/audio_in/';

% Ensure the directory exists
if ~exist(baseDir, 'dir')
    mkdir(baseDir);
end

% Prompt the user for the file name
fileName = input('Enter the name of the audio file (without extension): ', 's');

% Full path to save the file
filePath = [baseDir, fileName, '.ogg'];

% Define recording parameters
fs = 44100; % Sampling frequency in Hz
nBits = 16; % Number of bits per sample
nChannels = 1; % Number of audio channels (1 for mono, 2 for stereo)
recordDuration = 10; % Duration of the recording in seconds

% Create an audiorecorder object
recObj = audiorecorder(fs, nBits, nChannels);

% Inform the user that recording will start
disp('Start speaking...');

% Record the audio
recordblocking(recObj, recordDuration);

% Inform the user that recording has ended
disp('Recording ended.');

% Get the audio data
audioData = getaudiodata(recObj);

% Save the audio data to a file
audiowrite(filePath, audioData, fs);

% Inform the user that the file has been saved
disp(['Audio saved to ', filePath]);


