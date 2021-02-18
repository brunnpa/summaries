clear;
clc;
hold off;
close all;
format long;
% gewünschte Funktion
func = @(x) x.^2-2;
% Intervallgrenze a
a = 2;
% Intervallgrenze b
b = 0;
% Toleranz
tol = 10^-2;

xit = 0;
counter = 1;
while(abs(a-b) >= tol)
    x = (a+b)/2;
    if func(x)*func(a) > 0
        a = x;
    else
        b = x;
    end
    xit(counter) = x;
    if counter > 1
        if xit(counter) == xit(counter-1)
            error('ERROR: Maschinengenauigkeit reicht nicht aus für gewünschte Toleranz: %s!', tol);
        end
    end
    counter = counter + 1;
end
root = x;
n = length(xit);
sol = xit(n);