% Beispiel Serie 2 - Aufgabe 4 a,b

clc;
format long;

% Masse in kg
m = 10;

% Unterteilung des Intervalls in n Subintervalle
n = 5;

% Intervallgrenze a
a = 20;

% Intervallgrenze b
b = 5;

% Hauptfunktion fuer Geschwindigkeitsveraenderung
f = @(v) m / R(v);

% Funktion fuer Widerstand laut Angabe
R = @(v) -v * sqrt(v);

% Berechnung von h
h = (b-a)/n;

fprintf('h = (b-a)/n\n');
fprintf('  = (%.5f - %.5f)/%d\n', b,a,n);
fprintf('  = %f\n', h);

xRf_vals = zeros(n,1); % Array fuer Anzeige von verwendeten x-Werten von Rf
xRf = a; % x definieren mit linker Intervallsgrenze als Startwert

% ======================================================================= %
% Berechnung von x-Werten fuer summierte Rf
% ======================================================================= %

for i = 1:n
    if(i == 1)
       xRf = xRf + h/2;
    else
       xRf = xRf + h; % Else the full width h is added
    end
    xRf_vals(i) = xRf;
end

fprintf('\nx-Werte fuer Rechteckregel: \n');
disp(xRf_vals);


% ======================================================================= %
% Berechnung fuer summierte Rechteckregel
% ======================================================================= %

fprintf('\n\nBerechnung mittels summierter Rechteckregel:\n');

rfSum = 0; % Variable fuer Rechteckregel Summenbildung

for i = 1:n
    rfResult = f(xRf_vals(i)); % Berechnung von rf-Wert fuer aktuellen x-Wert
    rfSum = rfSum + rfResult; % Bildung der Summe fuer Rechteckregel
    fprintf('f(%.3f) = %.12f\n',xRf_vals(i), rfResult); % Resultat von f(x) anzeigen
end

rf = h * rfSum;
fprintf('\nRf = h * Sum(f(1)...f(n))\n');
fprintf('   = %f * %f\n', h, rfSum);
fprintf('   = %f\n', rf);


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




