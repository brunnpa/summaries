% Gibt eine Tabelle mit den Diskretisierungsfehler aus
% 
% PARAMETER
% func = die Funktion
% x0 = funktionswert zur Auswertung
%
% RETURN
% -
% SAMPLE
% Gruppe10_IT17tb_S1_Aufg2(@(x) log(x.^2), 2)
function Gruppe10_IT17tb_S1_Aufg2(func, x0)
    format long;
    syms x;
    % Ableitungen berechnen
    func_abl = diff(func, x);
    func_abl2 = diff(func_abl, x);
    func_abl3 = diff(func_abl2, x);
    % Ableitungen wieder in eine Matlab Funktion umwandeln
    func_abl = matlabFunction(func_abl);
    func_abl2 = matlabFunction(func_abl2);
    func_abl3 = matlabFunction(func_abl3);
    
    d1f = @(x0,h) (func(x0+h) -func(x0))/h;
    d2f = @(x0,h) (func(x0+h) -func(x0-h))/(2*h);
    
    % Aufgabe a) Tabelle mit Diskretisierungsfehler
    % erste Ableitung an der Stelle x0 -> für subtraktion verwenden
    dx = func_abl(x0);
    % von 10 hoch -1 bis 10 hoch -17
    for i=-1:-1:-17
        h=10^i;
        d1x=d1f(x0,h);
        % Diskretisierungsfehler Fehlerordnung O(h)
        dx1error=abs(d1x-dx);
        d2x=d2f(x0,h);
        % Diskretisierungsfehler Fehlerordnung O(h^2)
        dx2error=abs(d2x-dx);
        fprintf('exp=%d, D1=%.8d, D1Fehler=%d, D2=%.12d, D2Fehler=%d \n',i,d1x,dx1error,d2x,dx2error);
    end
    fprintf('\n\n');
    % Aufgabe b) Schrittweite D1f
    epsD1f = 0.5*2^(-52);
    hOpt = (4*epsD1f*(abs(func(x0)/abs(func_abl2(x0)))))^0.5;
    fprintf ('\nhopt d1f: %s\n', hOpt)
    % Aufgabe c) Schrittweite D2f
    hOptD2f = (6*eps*(abs(func(x0)/abs(func_abl3(x0)))))^(1/3);
    fprintf ('hopt d2f: %s\n', hOptD2f)
end
    
    