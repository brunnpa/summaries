%G3_S8_Aufg3c
x=[1997 1999 2006 2010]-1997;
y=[150 104  172 152];

p=polyfit(x, y, 3);
xf=1:1:15;
yf=polyval(p, xf);
plot(xf+1997, yf);hold on;
grid

disp(['Schätzwert 2003: ', num2str(yf(2003-1997))]);
disp(['Schätzwert 2004: ', num2str(yf(2004-1997))]);