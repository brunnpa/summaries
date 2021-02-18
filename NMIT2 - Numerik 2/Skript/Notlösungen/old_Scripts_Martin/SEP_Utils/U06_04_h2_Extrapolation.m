% Berechnet die h^2-Extrapolation für eine Ableitung
% f = Die Funktion, welche Abgeleitet werden soll
% x0 = Die Stelle, die Abgeleitet werden soll
% h0 = Der Anfangsstartwert für h
% n = Das maximale m in der Formel (n+1 = maximale Tiefe)  
f = @(x) sin(x);
x0 = 1;
h0 = 0.1;
n = 3;

Dmatrix = zeros(n+1);
D2f = @(x0,h) (f(x0+h) - f(x0-h)) / (2*h); 

% Erste Spalte berechnen
for i = 1:(n+1)
    Dmatrix(i,1) = D2f(x0, h0/2^(i-1));
end

% Restliche Werte berechnen
for k = 2:(n+1)
    kReal = k-1;
    for i = 1:(n+1) - kReal
        Dmatrix(i,k) = (4^kReal * Dmatrix(i+1, k-1) - Dmatrix(i, k-1)) / (4^kReal - 1);
    end
end

D = Dmatrix(1,n+1);
disp(D);