% Ableitung durch Extrapulation mit dem h^2-Algorithmus
% 
% PARAMETER
% f = Funktion zum Ableiten
% x0 = Die Stelle wo abgeleitet werden soll
% h0 = Startwert für die Schrittweite
% n = Genauigkeit
%
% RETURN
% D = Näherung Ableitung mit Extrapulation
%
% SAMPLE
% Gruppe10_IT17tb_S2_Aufg2(@(x) log(x.^2), 2, 0.1, 4)
function D = Gruppe10_IT17tb_S2_Aufg2(f, x0, h0, n)
    D = zeros(4);
    % Diskretiesierungsfehler mit h^2 Algorithmus
    D2f = @(x0,h) (f(x0+h) - f(x0-h)) / (2*h); 
    
    % erste Spalte füllen -> D00 bis D30
    for i = 1:n
        D(i,1) = D2f(x0, h0/2^(i-1));
    end
    
    % weitere Spalten füllen auf Basis der ersten
    for k = 2:n
        kReal = k-1;
        for i = 1:(n - kReal)
            D(i,k) = (4^kReal * D(i+1, k-1) - D(i, k-1)) / (4^kReal - 1);
        end
    end
end