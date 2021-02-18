% Inputwerte bestimmen (Aufgabe 10.3 S. 170)
t = 0:(1/(44.1*10^3)):0.005;
v0 = 200;
% Funktion erstellen
f = @(t) sin(2.*pi.*v0.*t) + 0.5 .* sin(2.*pi.*4.*v0.*t) + 0.8 .* cos(2.*pi.*2*v0.*t) + 0.4 .* cos(2.*pi.*12.*v0.*t);
fVal = f(t);

% [k, A, B] = DFT(t, f(t));

% Anzahl Schritte berechnen
n = floor(length(fVal)/2);
% Frequenz berechnen
T = t(2*n) - t(1);

omega = 2*pi/T;

% Fourierkoeffizienten Vektoren vorbereiten
A = zeros(n+1,1);
B = zeros(n+1,1);

% A0 Koeffizient berechnen
A(1) = 1/(2*n) * sum(fVal(1:end-1));

% Ak Koeffizienten berechnen
for k = 2:n
    A(k) = 1/n * sum(fVal(1:end-1) .* cos((k-1).*omega.*t(1:end-1)));
end

% An Berechnen
A(n+1) = 1/(2*n)*sum(fVal(1:end-1) .* cos(n.*omega.*t(1:end-1)));

%B0 eintragen
B(1) = 0;

%Bk berechnen
for k = 2:n
    B(k) = 1/n * sum(fVal.*sin((k-1).*omega.*t));
end
%Bn eintragen
B(n+1) = 0;

k = 0:n;

subplot(2,2,1)
plot(t, f(t));

n = floor (length(t)/2);
T = t(2*n)-t(1);
freq = k/T;
%Power-Spektrum berechnen
pow = 1/4 * (A.^2 + B.^2)/length(t);
subplot(2,2,2)
plot(freq, pow), xlim([0 3000]);
subplot(2,2,3)
stem(freq, A), xlim([0 3000]);
subplot(2,2,4)
stem(freq, B), xlim([0 3000]);