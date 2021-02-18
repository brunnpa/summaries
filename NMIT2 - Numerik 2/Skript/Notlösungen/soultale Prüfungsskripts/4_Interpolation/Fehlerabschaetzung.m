clc
clear
%  EDIT -> nur da anpassen
% Aufgabe 8.2 Skript
% n+1 Ableitungen berechnen:
syms x
fx = 2^x; % EDIT
fx_1 = diff(fx);
fx_2 = diff(fx_1);
fx_3 = diff(fx_2);
% fx_4 = diff(fx_3);
% fx_5 = diff(fx_4);
% fx_6 = diff(fx_5);
% fx_7 = diff(fx_6);
% fx_8 = diff(fx_7);
% fx_9 = diff(fx_8);
% fx_10 = diff(fx_9);

% Kontrollieren ob monoton steigend oder fallend:
% Intervall:
a = -1; % EDIT
b = 3; % EDIT

fx_x_num = matlabFunction(fx_3); % EDIT x-te Ableitung von fx
i = a:0.1:b;
j = fx_x_num(i);
plot(i,j);

% Interpolationsfehler für Stelle x
x = 2; % EDIT

% Interpolierter Wert an Stelle x
x_stuetz = [-1 1 3]; % EDIT
y_stuetz = [0.5 2 8]; % EDIT
p = lagrange_interpolation(x_stuetz, y_stuetz); % EDIT interpolationsverfahren
fx_interpoliert = p(x);

% f(x) an Stelle x
fx = matlabFunction(fx);
fx_von_x = fx(x);

% Tatsächlicher Fehler
err_real = abs(fx_von_x - fx_interpoliert);

% Fehlerabschätzung:
x_temp1 = 1;
for k=1:length(x_stuetz)
    x_temp2 = x - x_stuetz(k);
    x_temp1 = x_temp1 * x_temp2;
end

% Geschätzter Fehler <=
err_estimate = (abs(x_temp1)/factorial(length(x_stuetz))) * max(j);