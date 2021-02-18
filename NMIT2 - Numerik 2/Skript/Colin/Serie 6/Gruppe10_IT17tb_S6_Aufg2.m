%% Aufgabe 2
% Ein kugelförmiger Wassertank mit dem Radius R = 4m wird durch ein kleines Loch mit Radius r = 0.02 an 
% seiner Unterseite entleert. Die Wasserhöhe h = h(t) im Tank (gemessen von seiner Unterseite) 
% gehorcht der DGL
%% Aufgabe 2a - Lösung mit klassischem Runge-Kutta Verfahren
% Konstanten gemäss Aufgabenstellung
R = 4;
r = 0.02;
a = 0;
b = 24000;
n = 10;
y(1) = 6.5;
g = 9.81;

formelWasserhoehe = @(x,y) -(r.^2 * (2*g*y(1))^0.5 )/(2*y(1)*R- y(1).^2 );

[x,y] = Gruppe10_IT17tb_S6_Aufg1(formelWasserhoehe, a, b, n, y(1));

plot(x,y,'--o');
grid on;
hold on;

%% Aufgabe 2b - Lösung mit Euler Verfahren
[x, y_eulerKlassisch, y_eulerMittelpunkt, y_eulerModifiziert] = HELPER_S5_Aufg3(formelWasserhoehe, a, b, n, y(1));

xlim([0 24000]);
plot(x,y_eulerKlassisch);
plot(x,y_eulerMittelpunkt);
plot(x,y_eulerModifiziert);
legend('Runge-Kutta', 'Euler klassisch', 'Euler Mittelpunkt', 'Euler modifiziert');