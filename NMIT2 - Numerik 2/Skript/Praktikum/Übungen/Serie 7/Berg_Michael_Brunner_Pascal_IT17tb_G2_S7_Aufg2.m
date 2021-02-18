% Testen: [x, yab4] = Berg_Michael_Brunner_Pascal_IT17tb_G2_S7_Aufg2(@(x,y) y ,0,1,1e3, 1)
% Adams-Bashforth Methode 4. Ordnung
function [x, yab4] = Berg_Michael_Brunner_Pascal_IT17tb_G2_S7_Aufg2(f,a,b,n,y0)
% Adams-Bashforth Methode 4. Ordnung aus Aufgabe 1
adams_4te_O = @(f,x,y,h,i) y(i) + (h/24)*((55*f(x(i),y(i)) - (59*f(x(i-1),y(i-1))) + (37*f(x(i-2),y(i-2))) - (9*f(x(i-3), y(i-3)))));

h = (b-a)/n;
x = zeros(n+1,1);
yab4 = zeros(n+1,1);



[x_,yab4_] = Berg_Michael_Brunner_Pascal_Gruppe2_S6_Aufg1(f,a,a+3*h,3, y0);
% Berechnen der Werte 0 bis 3
for i=1:4
    x(i) = x_(i);
    yab4(i) = yab4_(i);
end
% Berechnen der Werte 4 bis n
for i=5:n+1
    x(i) = x(i-1) + h;
    yab4(i) = adams_4te_O(f,x,yab4, h, i-1) ;
end

end