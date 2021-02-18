func = @(z,t) (-11*z)+(60*exp(-3*t));
a = 0;
b = 4.8;
n = 30;
x0 = 0;
y0 = 0;


n30 = Mod_Euler_Verfahren(func, x0, y0, n , a, b);
n = 50;
n50 = Mod_Euler_Verfahren(func, x0, y0, n , a, b);
n = 100;
n100 = Mod_Euler_Verfahren(func, x0, y0, n , a, b);

figure(1);
hold on;
plot(0:((b-a)/30):4.8, n30);
plot(0:((b-a)/50):4.8, n50);
plot(0:((b-a)/100):4.8, n100);

%Gitter erstellen
[X,Y] = meshgrid(-2:0.25:4, 0:0.25:4.8);

%Steigungen berechnen
f = @(X,Y) ((-11).*X) + (60*exp((-3).*Y));
Ydiff = f(X,Y);

%Pfeile zeichnen
%quiver(X, Y, ones(size(X)) ./ sqrt(1 + Ydiff.^2) , Ydiff ./ sqrt(1 + Ydiff.^2));
% obiges mit gleich langen Pfeilen unten ohne
quiver(X, Y, ones(size(X)), Ydiff);
title('Richtungsfeld');

legend('n = 30', 'n = 50', 'n = 100', 'Richtungsvektor');