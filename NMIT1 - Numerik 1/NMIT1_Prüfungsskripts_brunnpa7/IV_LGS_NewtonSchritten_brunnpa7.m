% NEWTONVERFAHREN NACH ANZAHL SCHRITTEN
% 
% INPUT
% n = Anzahl Schritte -> anpassen !!!
%
% OUTPUT
% func     = Funktion, die iteriert werden soll
% x0       = startWert der Iteration
% n        = Anzahl Iterationen
% easyMode = boolean ob nach vereinfachtem Newton-Verfahren rechnen soll
% 
% BEISPIELVERFAHREN
% [result] = IV_LGS_NewtonSchritten_brunnpa7
%

function [result] = IV_LGS_NewtonSchritten_brunnpa7
format long;
% Funktion definieren
f = @(x) x^2 - 2;
% Ableitung der Funktion definieren
fStrich = @(x) 2*x;

% Startwert festlegen
x0 = 2;
% Anzahl Schritte definieren
n= 2;
% easyMode = true, falls im vereinfachten Newton-Verfahren gerechnet werden soll
easyMode = false;

% Resultat als Vektor von 0 initialisieren
result=zeros(n,1); 

x = x0; 
 
for i = 1:n 
    if(easyMode)
        x = x - (f(x) / fStrich(x0));
    else
        x = x - (f(x) / fStrich(x));
    end
   
    fprintf('Step %d: %.10f\n', i, x);
    result(i) =x;
end
end