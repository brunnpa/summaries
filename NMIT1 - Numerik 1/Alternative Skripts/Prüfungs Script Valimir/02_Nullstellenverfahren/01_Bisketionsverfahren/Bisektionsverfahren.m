%BISEKTIONSVERFAHREN
% Parameter
format long
% Auf wieviele Kommastrellen genau
nks = 3;
% Beginn Intervallgrenze bzw. a0
a0 = -1;
% Ende Intervallgrenze bzw. b0
b0 = 1;
% Variablen aus Funktion
syms x
% Funktion definieren
f(x) =  cos(x)*sin(x);

% ai startet mit Startwert a0 (Anfang Intervalgrenze)
ai = a0;
% bi startet mit Startwert b0 (Ende Intervallgrenze)
bi = b0;
% n initalisieren
n = 0;
while(abs(ceil(ai*(10^nks))- ceil(bi*(10^nks))) >= 1)
    disp(['  n                    a                   b']);
    disp([n ai bi]);
    ab_2 = (ai+bi)/2;
    fab = double(f(ab_2));
    if((fab*f(ai)) <= 0)
        bi = ab_2;
    else
        ai = ab_2;
    end
    n = n+1;
    disp(['  (a+b)/2              f[(a+b)/2]']);
    disp([ab_2 fab])
    disp('------------------------------------------------');
end
ai
bi
n
disp('Eventuell wegen rundung noch nicht richtig, ev. nks erh�hen!!!');