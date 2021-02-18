clc;
format long;

max = 3; % max + 1 = Anzahl Startwerte
a = 2; % Untere Grenze
b = 4;% Obere Grenze
f = @(x) 1./x; % Funktion

% Korrekte L�sung berechnen
fIntCorrect = integral(f, a, b);

% Vektoren initialisieren
T = zeros(max+1);
E = zeros(max+1);

% Trapezregel definieren
T1f = @(n, h) trapezregel(f, a, b, n); 

% Startwerte berechnen
for i = 1:(max+1)
    n = 2^(i-1);
    h = (b-a)/2^(i-1);
    T(i,1) = T1f(n,h);
    E(i,1) = abs(T(i,1)-fIntCorrect);
end

% Restliche Werte berechnen
for k = 2:(max+1)
    kReal = k-1;
    for i = 1:(max+1) - kReal
        T(i,k) = (4^kReal * T(i+1, k-1) - T(i, k-1)) / (4^kReal - 1);
        E(i,k) = abs(T(i,k)-fIntCorrect);
    end
end

format long
disp(T);
disp(T(1,end));
disp(E);
format short

function [Tf] = trapezregel(f, a, b, n)
h = (b-a)/n;
Tf = (f(a) + f(b))/2;
for i=1:(n-1)
    Tf = Tf + f(a+i*h);
end

Tf = h * Tf;

end