function [ x, y ] = mittelpunkt(f,a,b,n,y0)
%Input args
% f: function handle (elementwise vector ops)
% a: start interval
% b: end interval
% n: num steps
% y0: start value
% von ausgangspunkt wird y_mid in mitte des intervalls geschätzt;
% steigung an punkt (x_mid, y_mid) zur schätzung von y(i+1)
% Konsistenzordnugn = Konvergenzordnung = 2
h = (b-a)./n;
y = zeros(1, n+1);
x = zeros(1, n+1);
x(1) = a;
y(1) = y0;
for i=1:n
    %Schätze Mittelpunkt
    x_mid = x(i) + h/2;
    y_mid = y(i) + h/2 * f(x(i), y(i));
    %Verwende Steigung an Mittelpunkt zur Schätzung von y(i+1)
    x(i+1) = x(i) + h;
    y(i+1) = y(i) + h .* f(x_mid,y_mid);
end

end

