function G3_S2_Aufg2()
hold off;
clc;

% ----- Aufgabe 2a -----
steps=(2.01-1.99)/501;
x=1.99:steps:2.01;

f1 = x.^7 - 14*x.^6 + 84*x.^5 - 280*x.^4 + 560*x.^3 - 672*x.^2 + 448*x - 128;
f2 = (x-2).^7;

subplot(2,2,1);
plot(x, f1, 'color', 'r');
title('2a f1');

subplot(2,2,2);
plot(x, f2, 'color', 'b');
title('2a f2');

% bei f1 werden die Funktionswerte zu gross (im positiven wie auch im negativen) es gibt einen overflow.

% ----- Aufgabe 2b -----
x=-10^-14:10^-17:10^-14;
g=x./(sin(1+x) - sin(1));

subplot(2,2,3);
plot(x, g);
title('2b');
grid on;

% Nein, instabil. Weil man mit x = fast 0  und dadurch mit einem Nenner = fast 0 rechnet.
%Dies erzeugt eine grosse Gleitkommazahl was zu einem overflow führt.

% ----- Aufgabe 2c -----
x=-10^-14:10^-17:10^-14;
g = x./(2.*cos((x+2)./2) .* sin(x./2));

subplot(2,2,4);
plot(x, g);
title('2c');
grid on;

% Man bekommt jetzt eine genauere annäherung an lim x->0

end
