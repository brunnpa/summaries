% DEZIMAL ZU EINER BASIS < 10
%
% INPUT:
% number = dezimalzahl
% B = Basis
%
% OUTPUT:
% result = zahl in neuer Basis B
%
% BEISPIELAUFRUF: 
% [result] = II_Rechnerarithmetik_Dez2Basis_brunnpa7(25.05,2)
% [result] = II_Rechnerarithmetik_Dez2Basis_brunnpa7(25,2)
function [result] = II_Rechnerarithmetik_Dez2Basis_brunnpa7(number,B)
    % wird für die Berechnung des dezimalen Wertes benötigt
    nMax = 10;
    % Fehlerhandling, da nur eine Basis < 10 zugelassen ist
    if B < 1 || B > 9
        error('B must be between 1 and 10');
    end
    
    % Initialisierung des results
    result = '';
    
    % Nummern werden in zwei Teilen (vor & nach dem Komma) geteilt
    % Ganzzahl (vor dem Komma) -> fix() schneidet Kommastellen ab
    integer = abs(fix(number));
    % Dezimalzahl (nach dem Komma)
    decimal = abs(number) - integer;
    
    % Konvertierung in angebene Basis B
    
    % Ganzzahl wird berechnet
    tempInteger = integer;
    while tempInteger > 0
        % restlicher Wert mit Modulo berechnen
        remaining = mod(tempInteger, B);
        % Ergebnis wird als String-Konkatenation beim Result (vorne) hinzugefügt
        result = [num2str(remaining),result];
        % Berechnung des neuen Zwischenresultat
        tempInteger = fix(tempInteger/B);
        % wird solange wiederholt bis in Form 0.xyz
    end
    
    % Bestimmung des Vorzeichens 
    % sign return value:
    %   1 if x grösser als 0
    %   0 if x gleich 0
    %   -1 if x kleiner als 0
    if sign(number) == -1
        result = ['-',result];
    else
        result = ['+',result];
    end
    
    % Falls Dezimalstellen vorhanden sind, füge Trennzeichen (.) ein
    if decimal > 0
        result = [result,'.'];
        
        tempDecimal = decimal;
        % Konvertiert die Dezimalstelle mit max. nMax Iterationen
        counter = 1;
        while counter <= nMax
            tempDecimal = tempDecimal * B;
            % speichere erhaltener ganzzahligerWert
            cuttedTempDecimal = fix(tempDecimal);
            % Speichere diesen Wert in dem gesamtresultat in der
            % Dezimalstelle zu hinderst
            result = [result, num2str(cuttedTempDecimal)];
            % Berechnung des restlichen Wertes
            tempDecimal = tempDecimal - cuttedTempDecimal;
            counter = counter + 1;   
        end
    end        
end
    
    


