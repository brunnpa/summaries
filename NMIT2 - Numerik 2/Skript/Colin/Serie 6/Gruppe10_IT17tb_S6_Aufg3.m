% Aufgabe 3
% Löst eine DGL mit allen 4 Verfahren und stellt es grafisch dar
% Eine weitere Grafik zeigt den globalen Fehler für alle vier Verfahren
% nach der i-ten Iteration

% Konstanten gemäss Vorgaben
a = 0;
b = 10;
h = 0.1;
n = (b-a)/h;
y(1) = 2;
DGL = @(x,y) (x.^2)/y;

fexakt = @(x) sqrt((2*x.^3)/3 +4);
% Lösung für Runge Kutta
[~, y_runge_kutta] = Gruppe10_IT17tb_S6_Aufg1(DGL, a, b, n, y(1));
% Lösung für die 3 Euler Verfahren
[x, y_eulerKlassisch,y_eulerMittelpunkt, y_eulerModifiziert] = HELPER_S5_Aufg3(DGL, a, b, n, y(1));

% Berechnen der absoluten Fehler
absoluter_Fehler_euler_klassisch = zeros(1, n+1);
absoluter_Fehler_euler_mittelpunkt = zeros(1, n+1);
absoluter_Fehler_euler_modifiziert = zeros(1, n+1);
absoluter_Fehler_runge_kutta = zeros(1, n+1);
for i=1:n+1  
    absoluter_Fehler_euler_klassisch(i) = abs(fexakt(x(i)) - y_eulerKlassisch(i));
    absoluter_Fehler_euler_mittelpunkt(i) = abs(fexakt(x(i)) - y_eulerMittelpunkt(i));
    absoluter_Fehler_euler_modifiziert(i) = abs(fexakt(x(i)) - y_eulerModifiziert(i));
    absoluter_Fehler_runge_kutta(i) = abs(fexakt(x(i)) - y_runge_kutta(i));
end

subplot(2,1,1);

% Top plot
plot(x,y_runge_kutta);
grid on;
hold on;
plot(x,y_eulerKlassisch);
plot(x,y_eulerMittelpunkt);
plot(x,y_eulerModifiziert);
legend('Runge-Kutta', 'Euler klassisch', 'Euler Mittelpunkt', 'Euler modifiziert');
title('Lösung Euler und Runge Kutta');
xlim([0 10]);
hold off;

% Bottom plot
subplot(2,1,2)
semilogy(x,absoluter_Fehler_runge_kutta);
hold on;
grid on;
semilogy(x,absoluter_Fehler_euler_klassisch);
semilogy(x,absoluter_Fehler_euler_mittelpunkt);
semilogy(x,absoluter_Fehler_euler_modifiziert);
title('Lokaler Fehler');
legend('Runge-Kutta', 'Euler klassisch', 'Euler Mittelpunkt', 'Euler modifiziert');
hold off;