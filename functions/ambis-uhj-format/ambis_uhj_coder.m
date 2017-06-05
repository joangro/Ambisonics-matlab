function [ y ] = ambis_uhj_coder( x, numCh )
% 
% Information courtesy of https://wiki.xiph.org/Ambisonics and
% https://en.wikipedia.org/w/index.php?title=Ambisonic_UHJ_format
%
% SUMMARY: Coder to convert a standard ambisonic b-format signal to UHJ
% format (also known as c-format). 
% The UHJ output signal can have a variable amount of output channels from 1 to 4.
%
% INPUTS: 
%       - x:        b-format signal (matrix)
%       - numCh:    number of channels on the output UHJ signal. Options:
%
%                   1	-	monophonic signal
%                   2	-	standard stereo signal (L/R)
%                   3   -   3 channels (full horizontal surround)
%                   4   -   4 channels (full spherical surround)
% OUTPUTS:
%       - y:        output UHJ signal (matrix)
%
%% Error control
if nargin < 2
    disp('Incorrect number of channels');
    return
end

%% Variable initialization
[m,n] = size(x);
if m < n
    nch = m;
    len =n;
    x = x';
else 
    nch = n;
    len = m;
end
%% Core function
% b-format variables
W = x(:,1);
X = x(:,2);
Y = x(:,3);
Z = x(:,4);


%% Core function
UHJ_S = 0.9396926.*W + 0.1855740.*X;
UHJ_D = 1i.*(-0.3420201.*W + 0.5098604.*X) + 0.6554516.*Y;

% Monophonic signal / first channel
L = (UHJ_S + UHJ_D)./2;
y = L;

% Stereo signal / second channel
if numCh > 1
    R = (UHJ_S - UHJ_D)./2;
    y = [L, R];    
end

% Third channel
if numCh > 2
T = 1i.*(-0.1432.*W + 0.6512.*X) - 0.7071.*Y; 
y = [L, R, T];
end

% Fourth channel
if numCh > 3
Q = 0.9772.*Z;
y = [L, R, T, Q];
end

end
