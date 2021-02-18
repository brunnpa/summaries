clc;
clear;

% Grundgrössen
f   = @(x) cos(x.^2);
m   = 4;
a   = 0;
b   = pi;

% Romberg Extrapolation
Romberg(a,b,f,m);