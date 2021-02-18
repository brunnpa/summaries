% Aus Aufgabenstellung -> Daten
t = [1900 1910 1920 1930 1940 1950 1960 1970 1980 1990 2000];
p = [75.995 91.972 105.711 123.203 131.669 150.697 179.323 203.212 226.505 249.633 281.422];

% Vektor erstellen wo gerechnet (interpoliert) werden soll
xx = 1900:0.1:2000;

% Spline Funktion
yy = spline(t,p,xx);
plot(t,p,'o');
hold on
plot(xx,yy,'b');

% Eigene Funktion
yy = Gruppe10_IT17tb_S10_Aufg2(t,p,xx);
plot(xx,yy,'r');

% 
tNeu = t-1900;
P = polyfit(tNeu, p, length(t)-1);
plot(t, polyval(P, tNeu));
legend('Messwerte', 'Spline MATLAB', 'Spline Aufgabe2', 'Polynom 10. Grad');
xlabel('Zeitpunkt in Jahren');
ylabel('Bevölkerung');
hold off;
