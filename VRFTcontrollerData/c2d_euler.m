%==========================================================================
%
% c2d_euler  Transforms a continuous transfer function to a discrete 
% transfer function using the forward and backward Euler methods.
%
%   Hz = c2d_euler(Hs,T,'forward')
%   Hz = c2d_euler(Hs,T,'backward')
%
% See also c2d.
%
% Copyright © 2021 Tamas Kis
% Last Update: 2021-10-09
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/documentation/Continuous_to_Discrete_Transfer_Function_Transformation_Using_the_Euler_Methods.pdf
%
% REFERENCES:
%   [1] Franklin et. al., "Digital Control of Dynamic Systems", 3rd Ed.
%   [2] https://www.mathworks.com/matlabcentral/answers/96275-how-can-i-convert-a-transfer-function-object-from-the-control-system-toolbox-into-a-symbolic-object
%   [3] https://gist.github.com/maruta/1035254
%   [4] https://www.mathworks.com/matlabcentral/fileexchange/27302-syms-to-tf-conversion
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   Hs      - (1×1 tf or zpk) continous transfer function
%   T       - (1×1 double) sampling period
%   type    - (char) 'forward' or 'backward'
%   output  - (OPTIONAL) (char) specifies output type ('tf' or 'zpk')
%
% -------
% OUTPUT:
% -------
%   Hz      - (1×1 tf or zpk) discrete transfer function
%
%==========================================================================
function Hz = c2d_euler(Hs,T,type,output)
    
    % ----------------------------------------------------
    % Sets unspecified parameters to their default values.
    % ----------------------------------------------------
    
    % defaults "output" to 'tf'
    if (nargin < 4) || isempty(output)
        output = 'tf';
    end
    
    % --------------------------------------
    % Continuous-to-discrete transformation.
    % --------------------------------------
    
    % symbolic variable for z;
    z = sym('z');
    
    % specified Euler approximation of s
    if strcmpi(type,'backward')
        s = (z-1)/(T*z);
    elseif strcmpi(type,'forward')
        s = (z-1)/T;
    elseif strcmpi(type,'tustin')
        s = 2*(z-1)/(T*(z+1));
    end
    
    % converts transfer function object to symbolic function object
    [num,den] = tfdata(Hs);
    Hz = poly2sym(cell2mat(num),z)/poly2sym(cell2mat(den),z);
    
    % performs Euler transformation
    Hz = simplify(subs(Hz,s));
    
    % obtains numerator and denominator of symbolic expression in MATLAB's
    % "polynomial form"
    [sym_num,sym_den] = numden(Hz);
    num = sym2poly(sym_num);
    den = sym2poly(sym_den);

    % creates discrete transfer function model
    Hz = tf(num,den,T);
    
    % converts discrete transfer function model to discrete zero-pole-gain
    % model if specified
    if strcmpi(output,'zpk')
        Hz = zpk(Hz);
    end
    
end