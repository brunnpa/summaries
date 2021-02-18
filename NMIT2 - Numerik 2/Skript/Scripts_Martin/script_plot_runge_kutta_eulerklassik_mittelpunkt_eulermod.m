%{
Skript f�r die Aufgabe 2 der Serie 6

(Beschreibung zu den einzelnen Teilaufgaben sind jeweils vor der
Teilaufgabe zu finden)
%}

% Werte initialisieren
R = 4;
r = 0.02;
a = 0;
b = 24000;
n = 6;
y_vals(1) = 6.5;
dh_dt = @(x,y) -(r.^2 * (2*9.81*y(1))^0.5)/(2*y(1)*R-y(1).^2);

%{
Teilaufgabe a)
Wassertankaufgabe mittels Runge-Kutta-Verfahren l�sen
%}

[x, y] = Martin_Ponbauer_Vele_Ristovski_Gruppe8_S6_Aufg1(dh_dt, a, b, n, y_vals(1));

%{
Teilaufgabe b)
Gleiche Aufgabe mit den anderen Verfahren l�sen
INWEIS: Funktion aus vorherigem Praktikum �bernommen, Namen gek�rzt,
Richtungsfelder-Plot auskommentiert
%}

%[x, y_euler, y_Mittelpunkt, y_modeuler] = S5_Aufg3(dh_dt, a, b, n, y_vals(1));
[x, y_euler] = func_dgl_euler_klassisch(f,a,b,n, y_vals(1));
[x, y_Mittelpunkt] = func_dgl_mittelpunkt(f,a,b,n, y_vals(1));
[x, y_modeuler] = func_dgl_euler_modifiziert(f,a,b,n, y_vals(1));

%{
Teilaufgabe c)
Plotten aller 4 L�sungen samt Legende
%}

plot(x,y);
grid minor;
hold on;
xlim([0 24000]);
plot(x, y_euler);
plot(x, y_Mittelpunkt);
plot(x, y_modeuler);
legend('Runge-Kutta', 'Euler', 'Mittelpunkt', 'modifizierter Euler');