%% Ambisonic B-format
clear variables
clc
%% Read file
[x, fs] = audioread('P4-audio.wav');

%% Code B-format
Azimuth = [0, 90, 180, -90, 0, 0, 0, 0];
Elevation = [9, 0, 0, 0, 0, 45, 0, 90];

%% Call the function for result
soundResult = create_B_format(x, Azimuth, Elevation);

%% Coding function
function y = create_B_format(signal, Azimuth, Elevation)
% Creates the Ambisonic B-format from an input signal using Azimuth and
% Elevation values.
% Input:    - signal: monophonic vector signal
%           - Azimuth: Opening horizontal angle, can be a vector
%           - Elevation: Median anhle (Z), can be a vector
%               - If Azimuth and elevation are vectors, they must be the
%               same size
% Output:   - y: monophonic B-format signal, if the inputs are vectors this
%               will be the concatenation of the same sound by the length
%               of the vectors.

% Error checking
if length(Azimuth) ~= length(Elevation)
    display('ERROR: Wrong Azimuth/Elevation vector size'); 
    y = 0;
	return
end

len = length(signal);
% Size 4 for each ambisonics channel
y = zeros(4, len*length(Azimuth));

% Coding and creating output sound vector
for i = 1:length(Azimuth)
    % W-channel (pressure)
    y(1,(i*len-len+1):(i*len)) = signal./sqrt(2);
    
    % X-channel (velocity on front)
    y(2,(i*len-len+1):(i*len)) = signal.*cos(Azimuth(i)).*cos(Elevation(i));
    
    % Y-channel (velocity on sides)
    y(3,(i*len-len+1):(i*len)) = signal.*sin(Azimuth(i)).*cos(Elevation(i));
    
    % Z-channel (velocity on top)
    y(4,(i*len-len+1):(i*len)) = signal.*sin(Elevation(i));

end
end
