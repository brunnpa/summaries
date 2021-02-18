% NMIT2 SEP - Aufgabe 1
% Valmir Selmani

max = 4; 
h = 0.1; 
x0 = 0.137; 
syms x
f = 1-log(x); 

fDiff = diff(f);
f = matlabFunction(f, 'vars', x);
fDiff = matlabFunction(fDiff, 'vars', x);

Dnf = @(x0,h) (f(x0+h) - f(x0)) / h; 

% Vektoren initialisieren
D = zeros(max+1);
E = zeros(max+1);

% Erste Spalte berechnen
for i = 1:(max+1)
    D(i,1) = Dnf(x0, h/2^(i-1));
    E(i,1) = abs(D(i,1) - fDiff(x0));
end

% Restliche Werte berechnen
for k = 2:(max+1)
    kReal = k-1;
    for i = 1:(max+1) - kReal
        D(i,k) = (2^kReal * D(i+1, k-1) - D(i, k-1)) / (2^kReal - 1);
        E(i,k) = abs(D(i,k) - fDiff(x0));
    end
end

format long
disp(D);
% Alle Fehler
disp(E);
format short
