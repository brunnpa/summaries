% Umwandlung einer Zahl im Dezimalsystem in ein anderes System.
%
% [y,y_unrounded,value,abs_err,rel_err] = dezimal_zu_x(-1006.687, 2, 13);
%
% @param - Ganzzahliger Teil der Zahl im Dezimalsystem (inkl. Vorzeichen)
% @param - Gebrochener Teil der Zahl im Dezimalsystem
% @param - Zielsystem
% @param - Anzahl Stellen
% 
% @return {string} y  - Normierte Zahl in neuem System, inkl. Runden
% @return {string} y_unrounded  - Zahl in neuem System, nicht gerundet
% @return {number} value - Wert der berechneten Zahl (inkl. Rundungsfehler) 
% @return {number} abs_err - absoluter Fehler zur Eingabezahl
% @return {number} rel_err - relativer Fehler zur Eingabezahl

function [y, y_unrounded, value, abs_err, rel_err] = dezimal_zu_x_2(ganzzahl, gebrochen, B, nmax)

    x = str2num(strcat(num2str(ganzzahl), ".", num2str(gebrochen)));

    % vorzeichen holen
    if(sign(ganzzahl) == 1); vorzeichen = "+"; else; vorzeichen = "-"; end
    vorzeichenInt = sign(ganzzahl);

    % Arrays vorbereiten
    stellenGanzzahl = fix(log(ganzzahl) / log(B)) + 1;
    arrGanzzahl = zeros(1, stellenGanzzahl);
    stellenGebrochen = nmax + 1 - stellenGanzzahl;
    arrGebrochen = zeros(1, stellenGebrochen);

    % Ganzzahliger Teil
    for i = 1 : stellenGanzzahl
        rest = mod(ganzzahl,B);
        ganzzahl = fix(ganzzahl/B);
        arrGanzzahl(stellenGanzzahl - i + 1) = rest;
    end
    
    % Gebrochener Teil
    fullLength = length(char(num2str(gebrochen)));
    for i = 1 : stellenGebrochen
        gebrochen = gebrochen * B;
        
        chars = char(num2str(gebrochen));
        charsLength = length(chars);
        if (charsLength > fullLength)
            difference = charsLength - fullLength;
            cut = chars(1:difference);
            arrGebrochen(i) = str2double(string(cut));
            gebrochen = str2double(chars(difference + 1:charsLength));
        end
    end

    % Normieren und Runden
    arrMerged = [arrGanzzahl arrGebrochen];    
    
    last = length(arrMerged);
    if (arrMerged(last) >= B / 2)
    	arrMerged(last) = 0;
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
    
    y = strcat(vorzeichen, "0.", arrayfun(@num2base16str, arrMerged), " * ", num2str(B), "^", num2str(stellenGanzzahl));
    y_unrounded = strcat(vorzeichen, arrayfun(@num2base16str, arrGanzzahl), ".", arrayfun(@num2base16str, arrGebrochen));
    value = wert * vorzeichenInt;
    abs_err = abs(x - wert);
    rel_err = abs(abs_err / x);
end

function [str] = num2base16str(str)
    str = num2str(str, "%x");
end