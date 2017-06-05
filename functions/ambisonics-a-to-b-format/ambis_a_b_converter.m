function [ y ] = ambis_a_b_converter( x, kind )
% Ambisonics A to B format converter
% This function converts an input A-format ambisonic signal to a B-format
% input signal.
% 
% NOTE: There is  variations in the way the a-format signal microphones are
% arranged when recorded, we cover two of them.
% First of all the nomenclature it's:
% 	F/B	-	Front/Back
%   L/R -	Left/Right
%   U/D -	Up/Down
% 
% First kind (Example mics: Soundfield/Core Sound):
%
%       FLU-FRD-BLD-BRU
%
% Second kind (Example: DPA-4)
%
%       FLD-FRU-BLU-BRD
%
% FUNCTION INPUTS:
%   x       =	original signal  -  (numerical matrix)
%   kind    =   type of a-format -  (1 for first kind, 2 for second kind, defaults first kind)
%
% FUNCTION OUTPUTS:
%   y       =   b-format signal
%

%% Error control
if nargin < 2
    kind = 1;
end

%% Error control and initiate variables
[m,n] = size(x);
if m < n
    nch = m;
    len =n;
    x = x';
else 
    nch = n;
    len = m;
end

if nch ~= 4
    disp('Incorrect input signal, please check this is a correct a-format signal');
    return
else
    y = zeros(m,4);
end
%% Core function
if kind == 1
    % Loading channels into separate variables
    FLU = x(:,1);
    FRD = x(:,2);
    BLD = x(:,3);
    BRU = x(:,4);
    
    % Conversion matrix for first kind
    W = FLU + FRD + BLD + BRU;
    X = FLU + FRD - BLD - BRU;
    Y = FLU - FRD + BLD - BRU;
    Z = FLU - FRD - BLD + BRU;
    y = [W,X,Y,Z];
    
else if kind == 2
    FLD = x(:,1);
    FRU = x(:,2);
    BLU = x(:,3);
    BRD = x(:,4);
    
    % Conversion matrix for second kind
    W = FLD + FRU + BLU + BRD;
    X = FLD + FRU - BLU - BRD;
    Y = FLD - FRU + BLU - BRD;
    Z = -FLD + FRU + BLU - BRD;
    y = [W,X,Y,Z];
    end
    

end

