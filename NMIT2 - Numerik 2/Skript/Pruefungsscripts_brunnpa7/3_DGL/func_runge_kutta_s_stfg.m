% S-Stufiges Runge Kutta Verfahren am Beispiel des 4-Stufigen
% Vektor a hier eintragen
% aConst = [[0 0 0 0];
%     [0.5 0 0 0];
%     [0 0.5 0 0];
%     [0 0 1 0]];
%Vektor b hier eintragen (von oben nach unten)
% bConst = [1/6 1/3 1/3 1/6];

%Vektor c hier eintragen (von oben nach unten)
% cConst = [0 0.5 0.5 1];

% Werte von aussen
% f = @(t, yt) t.^2 + 0.1 * yt;
% a = -1.5;
% b = 1.5;
% n = 5;
% y0 = 0;



% --------------------------------------------
% Vierstufiges Runge Kutta Verfahren
% f = Differenzialgleichung
% a = Startwert
% b = Endwert
% n = Anzahl Schritte
% y0 = Startwert
% R�ckgabewerte:
% (xi, yi) = n - berechnete Punkte der Funktion
% Aufruf:
% 
% % Vektor a hier eintragen
% aConst = [[0 0 0 0];
%     [0.5 0 0 0];
%     [0 0.5 0 0];
%     [0 0 1 0]];
% 
% % Vektor b hier eintragen (von oben nach unten)
% bConst = [1/6 1/3 1/3 1/6];
%
% Vektor c hier eintragen (von oben nach unten)
% cConst = [0 0.5 0.5 1];
% 
% [x,y] = func_runge_kutta_s_stfg(@(t, yt) t.^2 + 0.1 * yt, -1.5, 1.5, 5, 0, aConst, bConst,cConst)
% --------------------------------------------
function [x, y] = func_runge_kutta_s_stfg(f, a, b, n, y0, aConst, bConst, cConst)

    % s und h berechnen
    s = length(cConst);
    h = (b-a)/n;

    % Vektoren initialisieren
    x = zeros(n+1, 1);
    y = zeros(n+1, 1);

    % Startwerte setzen
    y(1) = y0;
    x(1) = a;
    
    % Iteration f�r die restlichen Werte
    for i= 1:n
        k = zeros(s, 1);
        for n = 1:s
            ak = 0;
            for m=1:n-1
                ak = ak + aConst(n,m)*k(m);
            end
            k(n) = f(x(i) + cConst(n)*h, y(i) + h * ak);
        end
        x(i+1) = x(i) + h;
        bk = 0;
        for n=1:s
           bk = bk + bConst(n) * k(n); 
        end
        y(i+1) = y(i) + h*bk;
    end
end

%    plot(x,y);