function    [ISf]   =   SfSum(a, b, f, n)
% Test:     [ISf]   =   SfSum(2, 4, @(x) 1/x, 4)
%                   =   0.693154530654531
% Zweck: Integrationsberechnung anhand der Summierten Simpson-Regel
%        Implementation durch die hergeleitete Summierte Simpson-Regel
% Params:
% a:    Untere Integrationsgrenze
% b:    Obere Integrationsgrenze
% f:    Zu integrierende Funktion
% n:    Anzahl Subintervalle
% Algorithmus:
% 1)    Erzeugung von Subintervallen
% 2)    Anwenden der Summierten Simpsonregel

% Check
if (b <= a)
    error("b muss als obere Intervallgrenze grösser als a sein")
end

% Hilfsgrössen
h   =  ((b - a) / n);

% 1) x_k berechnen
x_k = zeros(1,n+1);
x_k(1) = a;

for k =2:n
    x_k(k) = a + k * h;
end

% 2) Die 1. Summe berechnen: sum_k=1^n-1 f(x_k) Berechnen
sum_1 = 0;
for k=2:n
    sum_1 = sum_1 + f(x_k(k));
end

% 3) Die 2. Summe berechnen: sum_k=1^n f( (x_(k-1) + x_k) * 1/2)
sum_2 = 0;
for k=2:(n+1)
    sum_2 = sum_2 + f( (x_k(k-1) + x_k(k))*1/2 );   
end

% 4) Berechnung der Summierten Simpson-Formel
ISf     =   h/3 * ( 1/2*f(a) + sum_1 + 2*sum_2 + 1/2*f(b));