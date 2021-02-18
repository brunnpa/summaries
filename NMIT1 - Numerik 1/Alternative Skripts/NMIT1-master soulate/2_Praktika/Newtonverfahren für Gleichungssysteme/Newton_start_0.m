clear;
clc;
hold off;
close all;

%syms x1 x2;
syms x1 x2 x3;
% Aufgabe 6
% f(x) mit eingesetzten Punkten
f1(x1,x2,x3) = x1^.2+x2^.2+x3^.2 -83;         
f2(x1,x2,x3) = x1*x2+x2*x3+x1*x3 +29;
f3(x1,x2,x3) = x1*x2*x3 +105;

% Aufgabe b)
tol = 10^-4;
startwert = ([5; -4; 4]);


p1 = Newton_1(startwert, tol, f1, f2, f3);
