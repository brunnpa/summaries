% %H
% L = 1;
% %Ohm
% R = 80; 
% %F
% C = 4.*10.^-4;
% %Volt
% U = 100;
% 
% L.*q'' + R.*q' + (1./C).*q = U
% q'' = 100 - 80q' - 2500*q
% q(0) = q'(0) = 0
% 
% z1(t) = q(t)
% z2(t) = q'(t)
% 
% z1' = q'(t) = z2
% z2' = q''(t) 
% = 100 - 80q' - 2500*q
% = 100 - 80z2 - 2500z1
% 
% A = (0 1; -2500 -80) b = (0; 100)
%   
% h = 0.01
% t0 = 0
% t_mid = 0.005
% z'0 = [0;100]
% y_mid = y0 + 0.005 (0;100) = [0;0.5]
% t_i+1 = 0.01
% z'mid = [0.5;60]
% y_i+1 = y0  + 0.1 z'mid
%       = [0;0] + 0.01  [0.5;60]= [0.005; 0.6]
% z0 = (0;0)
% y0 = (0;100)
% 
% y_mid = 0.0 + 0.05*(0;100)

f