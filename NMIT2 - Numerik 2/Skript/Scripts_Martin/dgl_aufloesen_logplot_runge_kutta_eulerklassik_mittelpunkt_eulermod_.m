%{
Skript f�r die Aufgabe 3 der Serie 6

(Beschreibung zu den einzelnen Teilaufgaben sind jeweils vor der
Teilaufgabe zu finden)
%}

% Werte initialisieren
a = 0;
b = 10;
h = 0.1;
n = (b-a)/h;
y(1) = 2;
dy_dx = @(x,y) (x.^2)/y;

f_exakt = @(x) sqrt((2*x.^3)/3 + 4);

%{
Teilaufgabe a)
DGL mit vier Verfahren l�sen, plotten und zweite Grafik plottet den global
Fehler
%}

[x_kutta, y_kutta] = Martin_Ponbauer_Vele_Ristovski_Gruppe8_S6_Aufg1(dy_dx, a, b, n, y(1));

[x_euler, y_euler] = dgl_euler_klassisch(f, a, b, n, y(1));
[x_Mittelpunkt, y_Mittelpunkt] = dgl_euler_klassisch(f, a, b, n, y(1));
[x_modeuler, y_modeuler] = dgl_euler_klassisch(f, a, b, n, y(1));

% Fehler berechnen
for i=1:n+1
    fehler_runga_kutta(i) = abs(f_exakt(x(i)) - y_kutta(i));
    fehler_euler(i) = abs(f_exakt(x(i)) - y_euler(i));
    fehler_mittelpunkt(i) = abs(f_exakt(x(i)) - y_Mittelpunkt(i));
    fehler_modeuler(i) = abs(f_exakt(x(i)) - y_modeuler(i));
end

% L�sungen plotten
plot(x, y_kutta);
grid minor;
hold on;
plot(x, y_euler);
plot(x, y_Mittelpunkt);
plot(x, y_modeuler);
legend('Runge-Kutta', 'Euler', 'Mittelpunkt', 'modifizierter Euler');
title('L�sungen der Verfahren');
xlim([0 10]);

% Fehler plotten
figure();
semilogy(x, fehler_runga_kutta);
hold on;
grid minor;
semilogy(x, fehler_euler);
semilogy(x, fehler_mittelpunkt);
semilogy(x, fehler_modeuler);
title('Fehler der Verfahren');
legend('Runge-Kutta', 'Euler', 'Mittelpunkt', 'modifizierter Euler');