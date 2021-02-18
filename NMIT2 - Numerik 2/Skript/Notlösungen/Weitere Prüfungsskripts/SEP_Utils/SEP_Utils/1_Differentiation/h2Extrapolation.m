function    [D,E,DTable,ETable]     =   h2Extrapolation(x0, h, f, Dxf, fdiff1_analyt)
% Test:      h2Extrapolation(1,[0.1, 0.05, 0.025,0.0125],@(x)sin(x), "D2f")
%
% Desc:
%       Rekursive Methode um aus Diff Methoden niedrigerer Ordnung
%       eine Mthode höherer Ordnung zu schaffen
%       * k = m (K = Anzahl Zeilen, M Anzahl Spalten in D)
%       * Fehlerordnung: O)(h^(k+1)
%       * Zugelassen: D2f, D5f

% Params:
% x0:       Stelle an der die Ableitung berechnet werden soll
% h:        Schrittweite (Abnehmend mit Faktor 0.5)
% f:        Abzuleitende Funkiton
% Dxf:      Methode welche angewendet werden soll


if(~isequal(size(x0),[1,1]))
    error("bei h-Extrapolation ist für x0 nur ein Skalar zulässig");
end



m       = size(h,2);  % Zeilen
D       = zeros(m,m); % Quadratische Matrix

% Generiert eine Reihe von h mit Faktor 0.5
h_start = h(1);
h_exp   = zeros(size(h));

for i=1:m
    h_exp(i) = h_start * 0.5^(i-1);
end


if      Dxf == "D2f"
    DxF = @(h, x0, f) D2f(h, x0, f);
elseif  Dxf == "D5f"
   DxF = @(h, x0, f) D5f(h, x0, f);
end

% Di0 ausrechnen (erste Spalte)
D(:,1) = DxF(x0, h, f);

% Extrapolations-schritte
for k=2:m
    for i=1:m-(k-1)   % Zunehmend weniger Extrapolationsschritte
        faktor  = 4.^(k-1);   %k-1 weil wir leider bei i=1 und nicht i=0 loszählen
        z1      = faktor.*D(i+1, k-1);
        z2      = D(i, k-1);
        n       = 4.^(k-1)-1;
        D(i, k) = (z1 - z2) ./ n;
    end
end


row_header = ["h"; string(h)'];

col_header_e = strings([1,m]);
col_header_d = strings([1,m]);

for i=1:m
    col_header_e(i) = "Ei" + string(i-1);
    col_header_d(i) = "Di" + string(i-1);
end

DTable = [col_header_d;D];
DTable = [row_header, DTable];
disp(DTable);


%Diskretisierungs-Fehler Matrix E
if exist('fdiff1_analyt','var')
    E = abs(D - fDiff1(x0));
    E = flip(tril(flip(E)));
    ETable = [col_header_e;E];
    ETable = [row_header, ETable];
    ETable(1,1) = "" + ETable(1,1);
    disp(ETable);
end

end




