% Umwandlung einer Zahl im Dezimalsystem in ein anderes System.
%
% [y,y_unrounded,value,abs_err,rel_err] = dezimal_zu_x(-1006.687, 2, 13)
%
% Achtung! Wenn die eingegebene Zahl bereits bei Eingabe in Matlab falsche
% stellen aufzeigt (z.B. 99.999 wird zu 99.998), bitte das andere Skript
% verwenden.
% 
% @param - Zahl im Dezimalzehl
% @param - Zielsystem
% @param - Anzahl Stellen
% 
% @return {string} y  - Normierte Zahl in neuem System, inkl. Runden
% @return {string} y_unrounded  - Zahl in neuem System, nicht gerundet
% @return {number} value - Wert der berechneten Zahl (inkl. Rundungsfehler) 
% @return {number} abs_err - absoluter Fehler zur Eingabezahl
% @return {number} rel_err - relativer Fehler zur Eingabezahl

function [y, y_unrounded, value, abs_err, rel_err] = dezimal_zu_x(x, B, nmax)

    % vorzeichen holen
    if(sign(x) == 1); vorzeichen = "+"; else; vorzeichen = "-"; end
    vorzeichenInt = sign(x);
    
    x = abs(x);
    ganzzahl = fix(x);
    gebrochen = x - ganzzahl;
        
    % Arrays vorbereiten
    stellenGanzzahl = fix(log(ganzzahl) / log(B)) + 1;
    arrGanzzahl = zeros(1, stellenGanzzahl);
    arrGebrochen = zeros(1, nmax + 1 - stellenGanzzahl);
    
    % Ganzzahliger Teil
    for i = 1 : stellenGanzzahl
        rest = mod(ganzzahl,B);
        ganzzahl = fix(ganzzahl/B);
        arrGanzzahl(stellenGanzzahl - i + 1) = rest;
    end
    
    % Gebrochener Teil
    for i = 1 : length(arrGebrochen)
        gebrochen = gebrochen * B;
        stelle = fix(gebrochen);
        arrGebrochen(i) = stelle;
        
        gebrochen = gebrochen - stelle;
    end
    
    % Normieren und Runden
    arrMerged = [arrGanzzahl arrGebrochen];    
    
    last = length(arrMerged);
    if (arrMerged(last) >= B / 2)
    	arrMerged(last) = [];
        i = last - 1;
        while (i > 0 && arrMerged(i) + 1 >= B)
            arrMerged(i) = 0;
            i = i - 1;
        end
        if (i > 0)
            arrMerged(i) = arrMerged(i) + 1;
        else
            arrMerged = [1 arrMerged];
            stellenGanzzahl = stellenGanzzahl + 1;
        end
    end
    
    % Rückwandlung in Dezimalsystem
    wert = 0;
    laenge = stellenGanzzahl;
    for i = 1 : laenge
        wert = arrMerged(i) * B ^ (laenge - i) + wert;
    end
    
    wertGebrochen = 0;
    for i = 1 : (length(arrMerged) - stellenGanzzahl)
        wertGebrochen = arrMerged(i + stellenGanzzahl) * B ^ (-i) + wertGebrochen;
    end
    
    wert = wert + wertGebrochen;
    
    y = strcat(vorzeichen, "0.", arrayfun(@num2str, arrMerged), " * ", num2str(B), "^", num2str(stellenGanzzahl));
    y_unrounded = strcat(vorzeichen, arrayfun(@num2str, arrGanzzahl), ".", arrayfun(@num2str, arrGebrochen));
    value = wert * vorzeichenInt;
    abs_err = abs(x - wert);
    rel_err = abs(abs_err / x);
end
