% Clear Command Window
clc

% ====================================================================== %
% Script: h_opt berechnen
%
% Beschreibung:
% Um das h_opt zu berechnen muss die gegebene Funktion f aus der Angabe 
% übernommen werden. Ausserdem muss ein Startwer x0 gesetzt werden.
% ====================================================================== %

x0 = 2;                   % TODO: Startwert setzen

% Stammfunktion f(x)
f = @(x) log(x^2);

% 1. Ableitung f'(x)
fDiff = @(x) 2/x;

% 2. Ableitung f''(x)
fDiff2 = @(x) -2/x^2;

% 3. Ableitung f'''(x)
fDiff3 = @(x) 4/x^3;


% Maschinengenauigkeit spezifizieren (kommt meistens aus Angabe)
machineAccuracy = 2^(-52);


% h_opt mit Standardformel aus Skriptum
h_optimum_standard = sqrt(4*machineAccuracy * (abs(fDiff(x0)) / abs(fDiff2(x0))));

fprintf('h_opt = sqrt( 4 * eps * |fDiff(x0)| / |fDiff2(x0)| )\n');
fprintf('      = sqrt( 4 * eps * %.12f / %.12f )\n', abs(fDiff(x0)), abs(fDiff2(x0)));
fprintf('      = sqrt( %.21f ) \n', 4*machineAccuracy * (abs(fDiff(x0)) / abs(fDiff2(x0))));
fprintf('      = %.21f\n\n',h_optimum_standard);

% NOTE: OPTIONAL, nur falls verlangt
% h_opt mit Formel aus Angabe (muss ersetzt werden falls verlangt)
h_optimum_custom = nthroot(6*machineAccuracy * (abs(fDiff(x0))/abs(fDiff3(x0))),3);

fprintf('h_optimum_standardformel: %e\n', h_optimum_standard);
fprintf('h_optimum_custom: %e\n', h_optimum_custom);

% ================================================================%
% Loesungen mit f(x) = log(x^2) und Startwert x0=2
% ================================================================%
% h_optimum_standardformel: 4.214685e-08
% h_optimum_custom: 1.386353e-05
% ================================================================%



