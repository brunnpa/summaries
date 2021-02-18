% Differenzenquotient bilden -> Numerische Ableitung einer Funktion
% f(x) = sin(x) * exp(x)
%
% Aufgrund der begrenzten Maschinengenauigkeit auf Rechnersystemen kann
% kann die Ableitung nicht unendlich genau bestimmt werden.
% Grenzwert h -> 0
% für h < 1e-8 wird das Resultat unpräzis. Deshalb sollte h höchstens 1e-8
% gewählt werden, damit die maximale Präzision erreicht wird.

clear all;
clc;

x = 1;
df_exact = cos(x) * exp(x) + sin(x) * exp(x);
fprintf(1, '  h \t\t [f(x+h)]/h \tabsolute error\trelative error\n')
for i=0:10
    h = 10^(-2*i);
    df = (sin(x+h) * exp(x+h) - sin(x) * exp(x)) / h;
    err_abs = abs(df-df_exact);
    err_rel = abs(err_abs/df_exact);
    fprintf(1, '%1.1e\t\t%1.8f\t\t%e\t%e\n', h, df, err_abs, err_rel)
end
