function [p] = lagrange_interpolation(x, y)
%Lagrange_Interpolation 
% x: Stützstellen
% y: Stützpunkte
% p(x_est): angenäherte funktion (Interpolierendes Polynom, gesuchter y-Wert)
% Bsp. x = [8 10 12 14];
%      y = [11.2 13.4 15.3 19.5];

l = lagrange_polynomials(x);
p_i = sum(l .* y);
p =  matlabFunction(p_i);
end

