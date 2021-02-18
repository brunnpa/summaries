function [ y, p_func ] = Aitken_Neville( x, y, xj )
%example call
%[ y, p ] = Aitken_Neville( [0, 2500, 5000, 10000], [1013, 747, 540, 226], 1250 )
%Input args: 
% x: St?tzstellen
% y: Funktionswerte der St?tzstellen
% xj: Stelle an der Interpolation berechnet werden soll
%Ouputs: Interpolierter Funktionswert an Stelle x
%y = Pn(xj) = pnn(xj)
%p = Aitken neville schema
if size(x,2) ~= size(y, 2)
    error('input vectors x and y must have to same size');
end

n = size(x,2);
p = zeros(n,n);
syms p_func;
for i = 1:n
    p(i, 1) = y(i);  
    p_func(i,1) = y(i);
end
syms x_est;
diff = 1;

for j=2:n
    for i=(1+diff):n
        a = p_func(i-1, j-1);
        des_1 = (x(i)-x_est).*a;
        b = p_func(i,j-1);
        des_2 = (x_est-x(i-j+1)).*b;
        des = des_1 + des_2;
        div = x(i) - x(i-j+1);
        p_func(i,j) = des./div;
    end
    diff = diff + 1;
end
disp(p);
p_function = matlabFunction(p_func(n,n));
y = p_function(xj);
