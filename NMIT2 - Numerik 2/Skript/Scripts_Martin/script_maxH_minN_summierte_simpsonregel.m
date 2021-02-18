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

% 3. Ableitung
fDiff3 = @(x) 4/(x^3);

% 4. Ableitung
fDiff4 = @(x) -12/(x^4);

% Funktion zur Berechnung von maximaler Schrittweite h mittels SumSf um das Integral auf
% einen Fehler von maximal [max_error] berechnen zu koennen
H_Summierte_Simpsonregel = @(max_error, maxFxDiff4, a, b) nthroot( (max_error * 2880) / ((b-a) * maxFxDiff4), 4);


% Funktion zur Berechnung der benoetigten Subintervalle
% Das Resultat wird auf eine ganze Zahl aufgerundet
N = @(a,b,h) ceil( (b-a)/h );


fprintf('===============================================================\n');
fprintf('* Berechnung mittels summierter Simpsonregel                  *\n');
fprintf('===============================================================\n');


[maxFx, xForMaxFx] = func_maximum(a,b,fDiff4);

% Maximale Schrittweite mittels SumSf bei dem Fehler <= [max_error]
h_max = H_Summierte_Simpsonregel(max_error,maxFx,a,b);

% Anzahl benoetiger Subintervalle um das Integral auf einen Fehler von
% maximal [max_error] berechnen zu koennen
n = N(a,b,h_max);

fprintf('\nh_max = sqrt( (max_error * 2880) / (b-a) * max(fDiff4(x)) )\n');
fprintf('\n      = sqrt( (%.12f * 2880) / (%.5f- %.5f) * %d) )\n', max_error, b, a, maxFx);
fprintf('\n      = sqrt( %.12f / %.12f )\n', max_error*2880, (b-a)*maxFx);
fprintf('\n      = %.12f\n\n', h_max);

fprintf('\nn_min = (b-a)/h\n');
fprintf('\n      = (%.5f - %.5f)/%.12f\n',b,a,h_max);
fprintf('\n      = %.12f\n', (b-a) / h_max);
fprintf('\n      = ˙~%d\n', n);

fprintf('\n\nDie maximale Schrittweite h betraegt %.12f\n', h_max);
fprintf('Die minimale Anzahl benoetigter Subintervalle n betraegt %.d\n\n', n);
