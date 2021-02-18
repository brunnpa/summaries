% Clear Command Window
clc

% ====================================================================== %
% Script: differenzenformeln
%
% Beschreibung:
% In diesem Script werden die Differenzenformeln angewandet mit:
%   -> Vorwaertsdifferenzen (Df1)
%   -> Zentraldifferenzen (Df2)
%   -> Rueckwaertsdifferenzen (Df3)
% ====================================================================== %

x0 = 2;       % TODO: Startwert setzen

% Stammfunktion f(x)
f = @(x) log(x^2);   % TODO: Funktion setzen

% 1. Ableitung f'(x)
fDiff = @(x) 2/x;    % TODO: Funktion setzen

% 2. Ableitung f''(x)
fDiff2 = @(x) -2/x^2;  % TODO: Funktion setzen

% 3. Ableitung f'''(x)
fDiff3 = @(x) 4/x^3;   % TODO: Funktion setzen


% ======================================================================%
% Fuer Berechnung von h_opt siehe h_opt_faustformel.m
% ======================================================================%
machineAccuracy = 2^(-52);  % TODO: Maschinengenauigkeit festlegen

% Berechnung von optimalem h laut Formel aus Skriptum
h_opt = sqrt(4*machineAccuracy * (abs(fDiff(x0))/abs(fDiff2(x0))));


% ======================================================================%
% Differenzformeln fuer 1. Ableitung
% ======================================================================%
% Vorwaertsdifferenz    D1f = [f(x0 + h) - f(x0)] / h
% Zentraldifferenz      D2f = [f(x0 + h) - f(x0 - h)] / 2h
% Rueckwaertsdifferenz  D3f = [f(x0) - f(x0 - h)] / h
% ======================================================================%

% Vorwaertsdifferenz (1.Ableitung)
D1f = @(x0,h) (f(x0+h) - f(x0)) / h;

% Zentraldifferenz (1.Ableitung)
D2f = @(x0,h) (f(x0+h) - f(x0-h)) / (2*h);

% Rueckwaertsdifferenz (1.Ableitung)
D3f = @(x0,h) (f(x0) - f(x0-h)) / h;

% ======================================================================%
% Differenzformeln fuer 2. Ableitung
% ======================================================================%
% Vorwaertsdifferenz    D4f = [f(x0 + 2h) - 2f(x0 + h) + f(x0)] / (h^2)
% Zentraldifferenz      D5f = [f(x0 + h) - 2f(x0) + f(x0 - h)] / (h^2)
% Rueckwaertsdifferenz  D6f = [f(x0) - 2f(x0 - h) + f(x0 - 2h)] / (h^2)
% ======================================================================%

% Vorwaertsdifferenz (2.Ableitung)
D4f = @(x0,h) (f(x0+h) - f(x0)) / h;

% zentrale Differenz (2.Ableitung)
D5f = @(x0,h) (f(x0+h) - f(x0-h)) / (2*h);

% Rueckwaertsdifferenz (2.Ableitung)
D6f = @(x0,h) (f(x0) - f(x0-h)) / h;


% ======================================================================%
% Diskretisierungsfehler / Fehlerordnung
% ======================================================================%
% Diskretisierungsfehler D1f_err mit O(h)   = |D1f(x0,h) - f'(x0)|
% Diskretisierungsfehler D2f_err mit O(h^2) = |D2f(x0,h) - f'(x0)|
% ======================================================================%

D1f_err = @(x0,h) abs(D1f(x0,h) - fDiff(x0));
D2f_err = @(x0,h) abs(D2f(x0,h) - fDiff(x0));

fprintf('=============================================================================================\n');
fprintf('Differenzenformeln 1. Ableitung\n');
fprintf('=============================================================================================\n');

fprintf('h              D1f               D1f_err           D2f               D2f_err           D3f          \n');
fprintf('%e   %.12f    %.12f    %.12f    %.12f    %.12f\n', h_opt, D1f(x0, h_opt),D1f_err(x0, h_opt), D2f(x0,h_opt), D2f_err(x0,h_opt), D3f(x0, h_opt));

fprintf('\n\n=============================================================================================\n');
fprintf('Differenzenformeln 2. Ableitung\n');
fprintf('=============================================================================================\n');

fprintf('h              D4f               D5f               D6f          \n');
fprintf('%e   %.12f    %.12f    %.12f\n', h_opt, D4f(x0, h_opt), D5f(x0,h_opt), D6f(x0, h_opt));




fprintf('\n\n\n=============================================================================================\n');
fprintf('Beispiel: Tabelle von Differenzenformeln 1. Anleitung mit h von 10^-1 bis 10^-17\n');
fprintf('=============================================================================================\n');

fprintf('h                   D1f              D1f_err                  D2f              D2f_err \n');

for n = 2:17
  h = 10^(-n);
  
  d1f = D1f(x0,h);  
  err1 = abs(D1f(x0,h)-fDiff(x0));
  
  d2f = D2f(x0,h);
  err2 = abs(D2f(x0,h)-fDiff(x0));
  
  fprintf('%e        %.12f   %.12f           %.12f   %.12f\n', h, d1f, err1, d2f, err2 );
end

