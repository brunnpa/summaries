function [ x, y ] = modeuler(f,a,b,n,y0)
%Input args
% f: function handle (elementwise vector ops)
% a: start interval
% b: end interval
% n: num steps
% y0: start value
% zur bestimmung von y(i+1) wird der durschnitt der steigungen 
% an den punkten x(i),y(i)=k1 und der darauf basierend schäztung der 
% steigung an punkt x(i+1), y(i+1)=k2 genommen
% Konsistenzordnugn = Konvergenzordnung = 2
h = (b-a)./n;
y = zeros(1, n+1);
x = zeros(1, n+1);
x(1) = a;   
y(1) = y0;
for i=1:n
    %klassisches euler verfahren => steigung k1 an x0,y0 => y_euler
    x(i+1) = x(i) + h;
    k1 = f(x(i),y(i));
    y_euler = y(i) + h .* k1;
    %berechne steigung an zuvor eruiertem punkt, y_euler
    k2 = f(x(i+1),y_euler);
    %berechnung von y(i) mittels durchschnitt der steigungen
    y(i+1) = y(i) + (h .* (k1+k2)./2);
    
end

end
