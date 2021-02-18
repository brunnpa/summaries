%Aitken Neville
x = [0.5 0.6 0.7 0.8];
y = [0.6915 0.7257 0.7580 0.7881];
x_est = 0.52;
[ y_est, p_schema ] = Aitken_Neville( x, y, x_est )

%Kubische Splinefunktion
x = [0 1 2 3];
y = [2 1 2 2];
xx = [0.5, 1.5, 2.5];
[yy] = kubische_splinefunktion(x,y,xx)
clf;
plot(x,y, 'bo');
hold on;
xx2 = [0:0.1:3];
[yy2] = kubische_splinefunktion(x,y,xx2);
plot(xx2,yy2,'g');
%vergleich zu polynom von grad 3
x2 = linspace(0,3, 1000);
p = polyfit(x,y,3);
y1 = polyval(p,x2);
plot(x2,y1, 'r');