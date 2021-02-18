% Berechnet die Erdmasse
% 
% PARAMETER
% x = Vektor
% y = Vektor
%
% RETURN
% m = die berechnete Erdmasse
% absoluter_fehler = absoluter Fehler gegenüber der korrekten Erdmasse
% relativer_fehler = relativer Fehler gegenüber der korrekten Erdmasse
%
% SAMPLE
% [m, absoluter_fehler, relativer_fehler] = Gruppe10_IT17tb_S3_Aufg4b()
function [m, absoluter_fehler, relativer_fehler] = Gruppe10_IT17tb_S3_Aufg4b()
    % radius und dichte gemäss Aufgabenstellung als Wertepaare
    radius = [0 800000 1200000 1400000 2000000 3000000 3400000 3600000 4000000 5000000 5500000 6370000];
    dichte = [13000 12900 12700 12000 11650 10600 9900 5500 5300 4750 4500 3300];
    
    % Erdmasse gemäss Internet https://de.wikipedia.org/wiki/Erde
    erdmasse_internet = 5.972e+24;

    % Formel gemäss Aufgabenstellung
    f = @(radius, dichte) dichte * 4 * pi * (radius.^2);

    y = zeros(1, size(radius,2));
    for i=1:size(radius,2)
        y(i) = f(radius(i),dichte(i));
    end
    
    % Berechnung der Erdmasse sowie der Fehler
    m = Gruppe10_IT17tb_S3_Aufg4a(radius,y);
    absoluter_fehler = abs(m - erdmasse_internet);
    relativer_fehler = absoluter_fehler/erdmasse_internet;
end