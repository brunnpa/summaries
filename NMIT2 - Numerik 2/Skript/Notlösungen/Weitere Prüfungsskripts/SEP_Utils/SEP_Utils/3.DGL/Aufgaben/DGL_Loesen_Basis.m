%% DGL Lösen mit Klassischem-Euler, Mittelpunkt, Modifiziertem-Euler
% * Plot
% * Fehler
clc; clear;
% Deklaration der Werte
f   = @(x, y) (x.^2)./y;              %DGL: dy/dx = x^2/y
a   = 0;
b   = 2.1;              % Intervall (a=0) <= x <= (b=2.1)
y0  = 2;                %y(0) = 2
h   = 0.7;
n   = (b-a)/h;

% Aufgabe a
[x, y_klassisch] = euler(f, a, b, n, y0);
plot(x, y_klassisch, 'm');
hold on;

% Aufgabe b
[x, y_mittelpunkt] = mittelpunkt(f, a, b, n, y0);
plot(x, y_mittelpunkt, 'g');

% Aufgabe c
[x, y_modifiziert] = modeuler(f, a, b, n, y0);
plot(x, y_modifiziert, 'b');

% Exakte Funktion definieren
yExakt = @(x) sqrt(((2 * x.^3)/3)+ 4);

% Exakte Funktion plotten
step = a:0.01:b;
plot(step, yExakt(step),'r');

legend('klassisch', 'mittelpunkt', 'modifiziert', 'exakt');
hold off;

% Fehlerberechnung
fprintf('Fehlerberechnung Euler-Verfahren\n');
fprintf('| klassisch    |  mittelpunkt | modifiziert  |\n'); 
for i=1:n
    xi = x(i);
    yEx = yExakt(xi);
    f_klassisch     = abs(yEx - y_klassisch(i));
    f_mittelpunkt   = abs(yEx - y_mittelpunkt(i));
    f_modifiziert   = abs(yEx - y_modifiziert(i));
    fprintf('| %.10f | %.10f | %.10f |\n', f_klassisch, f_mittelpunkt, f_modifiziert);
end

%% DGL Lösen mit Euler Mittel + Plot + Richtungsfeld
% Deklaration der Werte
clc; clear;
f   = @(x, y) (x.^2)./y;              %DGL: dy/dx = x^2/y
a   = 0;
b   = 2.1; % Intervall (a=0) <= x <= (b=2.1)
y0  = 2;                %y(0) = 2
h   = 0.7;
n   = (b-a)/h;

[~, y_euler]        = euler(f, a, b, n, y0);
[~, y_mittelpunkt]  = mittelpunkt(f, a, b, n, y0);
[x, y_modeuler]     = modeuler(f, a, b, n, y0);

% Minimum und Maximum der "genausten" Methode verwenden und
% Schrittweite berechnen
yMin    = min(y_mittelpunkt);
yMax    = max(y_mittelpunkt);
hy      = (yMax-yMin)/n;


% Richtungsfeld plotten
richtungsfeld(f, a, b, yMin, yMax, (b-a)/n, hy);

% Berechnete Werte plotten
hold on;
plot(x, y_euler, 'g');
plot(x, y_mittelpunkt, 'r');
plot(x, y_modeuler, 'm');
legend('Richtungsfeld','klassisch', 'mittelpunkt', 'modifiziert');
hold off;
%% RK4 mit Vergleich zur exaten Lösung
% * Fehler
% * Exakte Lösung
clc; clear;
% Voraussetzungen
f   = @(t, yt) t.^2 + 0.1 * yt;
a   = -1.5;
b   = 1.5;
n   = 5;
y0  = 0;

y_exact = @(t) (-10)*t.^2-200*t-2000+1722.5*exp(0.05*(2*t+3));

% Ausrechnen

[t, y_rk4]   =   rk4(f, a, b, n, y0);

plot(t,y_rk4)
hold on
% Exakte Loesung plotten
t_new = a:0.01:b;
plot(t_new, y_exact(t_new),'LineWidth', 1.5);
legend('runge Kutta', 'exakte LÃ¶sung');
hold off

%% AWP Lösen Adam Bashforth 4 und RK4, globalen Fehler berechnen
clc;clear
% * Nutze Adam Bashforth 
% * Nutze RK
% für x 2 [0; 1] mit der Adams-Bashforth.Methode 4. Ordnung 
% sowie dem klassischen Runge-Kutta Verfahren für
% n = 10^1 - 10^8
%
% * Benchmark
% * Plot

% Serie 7 Aufgabe 3

y0      = 1;
f       = @(x,y) y;         % dgl  dy(x) = y(x)
yexact = @(x) exp(x);

a       = 0;
b       = 1;

% Aufgabe a) AWP Lösen
for i = 1:8
    n(i) = 10^i;
    
    % Adams-Bashforth
    tic;
    [x_adams,yab4_adams] = adams4(f,a,b,n(i),y0);
    t_adams(i) = toc;
    glob_err_Adams(i) = abs(yexact(x_adams(length(x_adams))) - yab4_adams(length(yab4_adams)));

    % Runge-Kutta 
    tic
    [x_runge,y_runge] = rk4(f,a,b,n(i),y0);
    t_RK(i) = toc;
    glob_err_RK(i) = abs(yexact(x_runge(length(x_runge))) - y_runge(length(y_runge)));
end 

subplot(2,1,1);
loglog(n,glob_err_Adams,n,glob_err_RK);
title('Globaler Fehler');
xlabel('n');
ylabel('Fehler');
legend('globaler Fehler Adams-Bashforth','globaler Fehler Runge Kutta');

subplot(2,1,2);
semilogx(n,t_adams,n,t_RK);
title('Laufzeit');  
xlabel('n');
ylabel('Laufzeit');
legend('Laufzeit Adams-Bashforth','Laufzeit Runge Kutta');


% Aufgabe c
fprintf('\n Das Adams-Bashforth Verfahren ist hinsichtlich der Laufzeit und des globalen Fehlers besser als das Runge-Kutta Verfahren');