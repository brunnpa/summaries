% Aufg. 10.1

clear all
close all
clc

% T-periodische Funktion
% ======================
T = pi;             % Periodendauer
w = 2*pi/T          % Grund-Kreisfrequenz
a = 0;
b = pi;
S = pi^2/4;                 % Spitzenwert
f = @(t) -t.^2 + pi*t;      % Beschreibung der Fkt. im Intervall [a, b]
 
% Berechnung der Koeffizienten der Fourier-Reihe bis zum Grad n
% =============================================================
n = 10;

A = zeros(1, n+1);
B = zeros(1, n+1);

A(0+1) = 2/T * integral(f, a, b) % A_0

for k = 1:n
    A(k+1) = 2/T * integral(@(t) f(t).*cos(k*w*t), a , b)   % A(k)
    B(k+1) = 2/T * integral(@(t) f(t).*sin(k*w*t), a , b)   % B(k)
end

% Grafik
% ======================
figure(1)
hold off

t = a-4*T:0.001:b+4*T;

plot(t, f(t));
hold all

f_fourier = A(0+1)/2*ones(size(t));
for k = 1:n
    f_fourier = f_fourier + A(k+1)*cos(k*w*t) + B(k+1)*sin(k*w*t);
    if k==1 || k==2 || k==5 || k==n
        plot(t, f_fourier)
    end
end
grid
legend('original', 'fourier k=1', 'fourier k=2', 'fourier k=5', 'fourier k=n')
ylim([-.2*S, 1.2*S])

