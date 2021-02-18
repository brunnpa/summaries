clf, clc, clear;
x = [0,1,2,3];
y = [ 2 1 2 2 ];
xx = [0:0.1:3]
yy = kubische_splinefunktion(x,y,xx)
plot(xx,yy,'b');
hold on;
plot(x,y,'bo');
yy2 = spline(x,y,xx)
plot(xx,yy2,'r');
yy3 = Gruppe_15_S10_Aufg2(x, y, xx);
plot(xx,yy2,'g')
x = [1900 1910 1920 1930 1940 1950 1960 1970 1980 1990 2000];
y = [75.995 91.972 105.711 123.203 131.669 150.697 179.323 203.212 226.505 249.633 281.422];

xx = 1900:2000;
yy = kubische_splinefunktion(x,y,xx);
s = spline(x,y,xq)

hold on;
plot(xx,yy, 'g');
legend('Data', 'Own Spline');