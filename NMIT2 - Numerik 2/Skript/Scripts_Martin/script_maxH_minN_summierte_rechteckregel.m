clc;
format long;

% ====================================================================== %
% Loesung zu Serie 3 Aufgabe 1
% ====================================================================== %

% Untere Intervallsgrenze
a = 1;

% Obere Intervallsgrenze
b = 2;

% Maximal erlaubter Fehler
max_error = 10^(-5);

% Funktion laut Angabe
f = @(x) log(x^2);

% 1. Ableitung
fDiff = @(x) 2/x;

% 2. Ableitung
fDiff2 = @(x) -2/(x^2);

% Funktion zur Berechnung von maximaler Schrittweite h mittels SumRf um das Integral auf
% einen Fehler von maximal [max_error] berechnen zu koennen
H_Summierte_Rechteckregel = @(max_error, maxFxDiff2, a, b) sqrt( (max_error * 24) / ((b-a) * maxFxDiff2) );

% Funktion zur Berechnung der benoetigten Subintervalle
% Das Resultat wird auf eine ganze Zahl aufgerundet
N = @(a,b,h) ceil( (b-a)/h );


fprintf('===============================================================\n');
fprintf('* Berechnung mittels summierter Rechteckregel                 *\n');
fprintf('===============================================================\n');

[maxFx, xForMaxFx] = func_maximum(a,b,fDiff2);

% Maximale Schrittweite mittels SumRf bei dem Fehler <= [max_error]
h_max = H_Summierte_Rechteckregel(max_error,maxFx,a,b);

% Anzahl benoetiger Subintervalle um das Integral auf einen Fehler von
% maximal [max_error] berechnen zu koennen
n = N(a,b,h_max);

fprintf('\nh_max = sqrt( (max_error * 24) / (b-a) * max(fDiff2(x)) )\n');
fprintf('\n      = sqrt( (%.12f * 24) / (%.5f- %.5f) * %d) )\n', max_error, b, a, maxFx);
fprintf('\n      = sqrt( %.12f / %.12f )\n', max_error*24, (b-a) * maxFx);
fprintf('\n      = %.12f\n\n', h_max);

fprintf('\nn_min = (b-a)/h\n');
fprintf('\n      = (%.5f - %.5f)/%.12f\n',b,a,h_max);
fprintf('\n      = %.12f\n', (b-a)/h_max);
fprintf('\n      = ˙~%d\n', n);

fprintf('\n\nDie maximale Schrittweite h betraegt %.12f\n', h_max);
fprintf('Die minimale Anzahl benoetigter Subintervalle n betraegt %.d\n\n', n);