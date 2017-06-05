function [ y ] = ambis_uhj_decoder( x )
% 
% Information courtesy of:
%       https://wiki.xiph.org/Ambisonics
%       https://en.wikipedia.org/w/index.php?title=Ambisonic_UHJ_format
%
% SUMMARY: This function implements a decoder to convert a c-format signal
% to a b-format signal.
% Note:    When decoding a c-format signal, if the number of channels it's
% inferior to four, we will lose the b-format Z channel and upwards.        
% 
% INPUT:   
%       - x:    C-format signal    (matrix)
%
% OUTPUT:
%       - y:    B-format signal    (3/4-channel signal)
%

%% Error control
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
L = x(:,1);
R = x(:,2);
S = (L + R)./2;
D = (L - R)./2;

switch (nch)
    
    case 2    % Stereo signal
        y = ones(m,3);
        y(:,1) = 0.982.*S + 1i.*0.164.*D;
        y(:,2) = 0.419.*S - 1i.*0.828.*D;
        y(:,3) = 0.763.*D + 1i.*0.385.*S;
        
        
    case 3    % Three channel signal  
        y = ones(m,3);
        T = x(:,3);
        y(:,1) = 0.982.*S + 1i.*0.197.*(0.828.*D + 0.768.*T);
        y(:,2) = 0.419.*S - 1i.*(0.828.*D + 0.768.*T);
        y(:,3) = 0.796.*D - 0.676.*T + 1i.*0.187.*S;
        
        
    case 4    % Four channel signal   
        y = ones(m,4);
        T = x(:,3);
        Q = x(:,4);
        y(:,1) = 0.982.*S + 1i*0.197.*(0.828.*D + 0.768.*T);
        y(:,2) = 0.419.*S - 1i*(0.828.*D + 0.768.*T);
        y(:,3) = 0.796.*D - 0.676.*T + 1i*0.187.*S;
        y(:,4) = 1.023.*Q;
      
end

end
