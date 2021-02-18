%FIXPUNKTITERATION
%Parameter:
format long
n_max = 30;             %Max Anzahl an Iterationen
x0 = 0.7;                 %Startpunkt
nks = 4;                %Auf wieviele Kommastrellen genau
syms x;                 %Variablen aus Funktion
F(x) = (x-0.3)^(1/3);          %Funktion


xn = x0;
xn1 = xn+2;
n = 0;
while( n <= n_max  && abs(ceil(xn*(10^nks))-ceil(xn1*(10^nks))) >= 1)
    if(n > 0) 
        xn = xn1; 
    end
    xn1 = double(F(xn));
    disp(['  n                    xn']);
    disp([n xn]);
    n = n+1;
end
disp(['  n                    xn']);
disp([n xn1]);
disp('Eventuell wegen rundung noch nicht richtig, ev. nks erhöhen!!!');