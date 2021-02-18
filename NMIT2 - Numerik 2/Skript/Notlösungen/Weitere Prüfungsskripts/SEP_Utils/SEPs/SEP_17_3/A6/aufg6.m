clear;
clc;
hold off;
close all;

rng(12345);

% Aufgabe a)
T = 1/100;
a = 0;
b = T;
t = a:0.0001:b-0.0001;
func = @(t) f(t);
g_func = @(t) g(t);

% Aufgabe b) g(t) berechnen
w = 2*pi/T;

n = 10;

A = zeros(1, n+1);
B = zeros(1, n+1);

A(0+1) = 2/T * integral(g_func, a, b); % A_0

for k = 1:n
    A(k+1) = 2/T * integral(@(t) g_func(t).*cos(k*w*t), a , b);   % A(k)
    B(k+1) = 2/T * integral(@(t) g_func(t).*sin(k*w*t), a , b);   % B(k)
end

% Grafik
% ======================

f_fourier = A(0+1)/2*ones(size(t));
for k = 1:n
    f_fourier = f_fourier + A(k+1)*cos(k*w*t) + B(k+1)*sin(k*w*t);
end

plot(t, f_fourier);
hold on;
plot(t, func(t));
plot(t, g_func(t));
legend('f(t)', 'g(t)');