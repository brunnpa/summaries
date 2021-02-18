% Beispielaufruf: BaseToDecimal([1 1], [1], 2)
function [vorkommastelle, nachkommastelle] = BaseToDecimal(vks, nks, basis)

    %VON BASIS != 10 ZU DEZIMAL
    %Fuer einzelne Schritte, disp(...) auskommentieren
    format long;
    
    %Vorkommastellen berechung
    vorkommastelle = vks(1);
    for i = 2: 1: length(vks)
        %disp(vorkommastelle);
        vorkommastelle = basis * vorkommastelle;
        %disp(vorkommastelle);
        vorkommastelle = vorkommastelle + vks(i);
    end
    vorkommastelle


    %Nachkommastellen berechnung
    z = [0 nks];
    nachkommastelle = z(length(z));
    for i = length(z)-1: -1: 1
        %disp(nachkommast);
        nachkommastelle = (1/basis) * nachkommastelle;
        %disp(nachkommast);
        nachkommastelle = nachkommastelle + z(i);
    end
    nachkommastelle
end
