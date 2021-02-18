% Beispiel Serie 2 - Aufgabe 4 a,b

clc;
format long;

% Wert A
A = -6.3;
% Wert B
B = 5.4 .*exp(1) - 5; 

% Unterteilung des Intervalls in 2 Subintervalle
n = 2;

% Intervallgrenze a
a = 105;

% Intervallgrenze b
b = 20;

% Hauptfunktion D
f = @(v) v / (A-B*v^2);

% Berechnung von h
h = (b-a)/n;

fprintf('h = (b-a)/n\n');
fprintf('  = (%.5f - %.5f)/%d\n', b,a,n);
fprintf('  = %f\n', h);

xRf_vals = zeros(n,1); % Array fuer Anzeige von verwendeten x-Werten von Rf
xRf = a; % x definieren mit linker Intervallsgrenze als Startwert


% ======================================================================= %
% Berechnung von x-Werten fuer summierte Tz
% ======================================================================= %

xTz_vals = zeros(n,1); % Array fuer Anzeige von verwendeten x-Werten von Tz
xTz = b; % x definieren mit linker Intervallsgrenze als Startwert
xTz_vals(1) = xTz;

for i = 2:n
    xTz = xTz + abs(h);
    xTz_vals(i) = xTz;
end

fprintf('\nx-Werte fuer summierte Trapezregel: \n');
disp(xTz_vals);

% ======================================================================= %
% Berechnung fuer summierte Trapezregel
% ======================================================================= %

fprintf('\n\nBerechnung mittels summierter Trapezregel:\n');

tzSum = 0; % Variable fuer summierte Trapezregel Summenbildung

for i = 2:n  
    tzResult = f(xTz_vals(i)); % Berechnung von tz-Wert fuer aktuellen x-Wert
    tzSum = tzSum + tzResult; % Bildung der Summe fuer summierte Trapezregel
    fprintf('f(%.3f) = %.12f\n',xTz_vals(i), tzResult); % Resultat von f(x) anzeigen
end

tz = h * ( ( (f(a) + f(b) ) / 2) + tzSum );
fprintf('Tz = h * ( (f(a)+f(b)/2) + Sum(f(2)...f(n)) )\n');
fprintf('   = %f * (%f + %f)\n' ,h, (f(a)+f(b))/2,tzSum);
fprintf('   = %f\n', tz);




