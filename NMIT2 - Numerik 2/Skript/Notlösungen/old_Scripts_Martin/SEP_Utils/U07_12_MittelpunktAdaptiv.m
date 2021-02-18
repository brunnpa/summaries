%% Lösung aus Serie 8 Aufgabe 3

a = 0;
b = 10;
f = @(t, y) -12*y + 30 * exp(-2*t);
y0 = 0;

% ------------------
% Teilaufgabe a
% ------------------
h = 0.01;
n = (b-a)/h;
[x_k, y_k] = eulerKlassisch(f, a, b, n, y0);
[x_m, y_m] = eulerMittelpunkt(f, a, b, n, y0);
figure
plot(x_k, y_k, x_m, y_m);
title('Teilaufgabe a');
legend('Euler klassisch', 'Mittelpunktverfahren');
xlabel('t');
ylabel('y');


% ------------------
% Teilaufgabe b
% ------------------
TOL = 1e-2;
h_A = h;
t_A = a;

y_A = 0; % Adaptives Verfahren
y_S = 0; % Steuerverfahren



k = 1;
while (t_A(k) < b)
    % Ein Schritt Mittelpunktsregel
    k1 = f(t_A(k), y_A(k));
    k2 = f(t_A(k)+ h_A(k)/2, y_A(k)+h_A(k)/2 * k1);
    y_A(k+1) = y_A(k) + h_A(k) * k2;
    t_A(k+1) = t_A(k) + h_A(k);
    
    % Ein Schritt Eulerverfahren
    y_S(k+1) = y_A(k) + h_A(k) * k1; % Weil k1 ja einfach die normale erste Funktionsauswertung ist
    
    % Schrittweite verdoppeln
    if (abs(y_A(k+1) - y_S(k+1)) < TOL/20)
        h_A(k+1) = 2 * h_A(k);
        k = k+1;
       continue;     
    end
    
    % Schrittweite verkleinern
    if (abs(y_A(k+1) - y_S(k+1)) >= TOL)
        h_A(k) = (1/2) * h_A(k);
        continue;
    end
    % Schritt gültig ohne Schrittweitensteuerung
    h_A(k+1) = h_A(k);
    k = k+1;
end

% ------------------
% Teilaufgabe c
% ------------------
yExakt = @(t) 3 .*(1-exp(-10.*t)) .* exp(-2.*t);

figure
subplot(2,1,1);
t = a:0.01:b;
plot(t_A, y_A, 'r', t, yExakt(t), '--b');
legend('Angenäherte Funktion', 'Exakte Funktion');
xlabel('t');
ylabel('y');

title('Teilaufgabe c');

subplot(2,1,2);
plot(t_A, h_A);
legend('adaptive Schrittweite');
xlabel('t');
ylabel('h');

% ------------------
% Teilaufgabe d
% ------------------
% Wenn die Toleranz zu gross gewählt ist, ist die angenäherte Kurve weniger
% genau und hat grössere Abweichungen von der exakten Funktion.
% Beispielsweise bei einer Toleranz von 1e-1.
% Umso kleiner die Toleranz, umso genauer das Ergebnis (bis zu einem
% gewissen Punkt aka Maschinengenauigkeit), jedoch dauert die Berechnung
% länger.