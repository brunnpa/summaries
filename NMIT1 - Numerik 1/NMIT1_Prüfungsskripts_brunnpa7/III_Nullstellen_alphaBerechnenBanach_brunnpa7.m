% ALPHA BERECHNEN
% 
% INPUT: 
% y = Ableitung der Funktion in die Hilfsfunktion eintragen
% startInt = Startintervall anpassen
% endInt = Endintervall anpassen
% 
% OUTPUT:
% alpha = berechneter alpha-Wert
% 
% BEISPIELAUFRUF:
% [alpha] = III_Nullstellen_alphaBerechnenBanach_brunnpa7

function [alpha] = III_Nullstellen_alphaBerechnenBanach_brunnpa7
    
    % Hilfsfunktion für die Berechnung der Ableitung innerhalb des
    % Intervalls
    function y = func_abl(x)
        % 1. Ableitung der Funktion F(x) korrekt erfassen. 
        y = (3*x.^2)/5;
    end
    
    % Intervallgrenzen
    startInt= 0;
    endInt = 1;
    
    % Alpha berechnen (Alpha ist der maximale Wert von F'(x) auf dem 
    % Intervall [a,b]
    alpha = max(func_abl(startInt : 0.01 : endInt));
    
end