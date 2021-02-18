function [l] = lagrange_polynomials(x)
%LAGRANGE_POLYNOMIALS returns lagrange polynomials from 0 to n
%x: Stützstellen
%l: Lagrange Polynome von 1 bis n
size_x = size(x,2);

syms x_est;
for i = 1:size_x
    l_i = 1;
    for j = 1:size_x
        if ~(j==i)
            l_i = l_i .* ((x_est-x(j))./(x(i)-x(j)));
         end
    end
    l(i) = l_i;
end
end

