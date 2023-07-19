%==========================================================================
%
% mag_phase  Magnitude and phase of a transfer function (i.e. linear
% system) at a specific point in the frequency domain.
%
%   [mag,phase] = mag_phase(sys,x)
%   [mag,phase] = mag_phase(sys,x,units)
%
% Copyright © 2021 Tamas Kis
% Last Update: 2022-07-06
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/files/Magnitude_and_Phase_of_a_Linear_System.pdf
%
% REQUIREMENTS:
%   • Control System Toolbox
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   sys     - (1×1 tf, zpk, or ss) continuous- or discrete-time linear 
%             system
%   x       - (1×1 complex double) location in frequency domain
%               --> s = x in continuous domain
%            	--> z = x in discrete domain
%   units   - (OPTIONAL) (char) 'deg' or 'rad'
%
% -------
% OUTPUT:
% -------
%   mag     - (1×1 double) magnitude of transfer function at s = x or z = x
%   phase   - (1×1 double) phase of transfer function at s = x or z = x
%               --> [deg] if units = 'deg' (default if "units" not input)
%               --> [rad] if units = 'rad'
%
% -----
% NOTE:
% -----
%   --> "sys" can be input as a transfer function model (tf), state space
%       model (ss), or a zero-pole-gain model (zpk)
%
%==========================================================================
function [mag,phase] = mag_phase(sys,x,units)
    
    % sets units to degrees by default
    if nargin < 3 || isempty(units)
        units = 'deg';
    end
    
    % magnitude
    mag = norm(evalfr(sys,x));
    
    % phase [deg]
    phase = atan2d(imag(evalfr(sys,x)),real(evalfr(sys,x)));
    
    % converts phase to radians if necessary
    if strcmpi(units,'rad')
        phase = phase*(pi/180);
    end
    
end