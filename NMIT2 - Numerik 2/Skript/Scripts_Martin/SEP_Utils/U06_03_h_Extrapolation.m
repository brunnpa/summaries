max = 3; % max + 1 = Anzahl Startwerte
h = 0.1; % Ausgangsschrittweite
x0 = 2; %Startwet
syms x
f = log(x^2); %Funktion die abgeleitet werden soll

% Ableitung vorbereiten, falls diese später gebraucht wird für den
% Diskretisierungsfehler
fDiff = diff(f);
f = matlabFunction(f, 'vars', x); % ACHTUNG! Diesen Teil brauchts immer
fDiff = matlabFunction(fDiff, 'vars', x);

% Vorwärts- oder Rückwärtsfunktion definieren
Dnf = @(x0,h) (f(x0+h) - f(x0)) / h; 
% Dnf = @(x0,h) (f(x0) - f(x0-h))/h;

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
disp(E);
format short
