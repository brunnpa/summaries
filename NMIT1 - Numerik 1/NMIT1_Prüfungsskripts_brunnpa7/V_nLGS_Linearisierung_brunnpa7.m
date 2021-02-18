% LINEARISIERUNG
% 
% Wikipedia-Reminder: Bei der Linearisierung werden nichtlineare Funktionen 
% oder nichtlineare Differentialgleichungen durch lineare Funktionen oder 
% durch lineare Differentialgleichungen angenähert. Die Linearisierung wird 
% angewandt, da lineare Funktionen oder lineare Differentialgleichungen 
% einfach berechnet werden können und die Theorie umfangreicher als für 
% nichtlineare Systeme ausgebaut ist.
%
% INPUT
% startVektor = der Startvektor
%
% OUTPUT
% resultat = die Linearisierungsfunktion
%
% BEISPIELAUFRUF
% [resultat] = V_nLGS_Linearisierung_brunnpa7([1,1])
function [resultat] = V_nLGS_Linearisierung_brunnpa7(startVektor)
  
    syms f1(x,y)
    syms f2(x,y)
    % Definiere Hauptfunktion
    syms f(x,y)
        
    % Funktion
    f1 = x^2 + y - 11;
    f2 = x + y^2 - 7;
    
    % Füge Funktionen zusammen
    f(x,y) = [f1;f2];
    
    % Berechne die Jacobi-Matrix
    Df = jacobian(f, [x,y]);
    
    val = f(startVektor(1), startVektor(2));
    Df = Df(startVektor(1), startVektor(2));
    
    u1 = x-startVektor(1);
    u2 = y-startVektor(2);
    xVektor = [u1;u2];
    
    resultat = val + (Df * xVektor);
end

