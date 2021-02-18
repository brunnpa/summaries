function [D,E,D_table,E_table] = h_extrapolation(x0, h, f, Dxf, fdiff_analyt)
% [D,E,D_table,E_table] = h_extrapolation(1,[0.1, 0.05, 0.025,0.0125],@(x)sin(x), @(x,h,f)D1f(x,h,f), @(x)cos(x))
% rekursive Method um aus Formeln niederiger Ordnung Formeln höherer Ordnung
% zu gewinnen (also z.B. um zentrale Differenz mit n>3 zu berechnen)
% Wir erhalten bei k = m (k=Anzahl Zeilen=Spalten in D) die Fehlerordnung O(h^k+1)
% Höhe der Fehlerordnung hängt von Differenzierbarkeit von f ab
% bei h-Extrapolation sind D1f,D3f,D4f,D6f zugelassen
% x0: Stelle an der Ableitung berechnet werden soll
% h: Schrittweiten (abnehmend mit Faktor 0.5)
% f: Funktion
% Df: D1f - D6f

if(~isequal(size(x0),[1,1]))
    error("bei h_extrapolation nur Skalare für x0 zugelassen");
end

m = size(h,2);
D = zeros(m,m);

init_h = h(1);
h_exp = zeros(size(h));
for i=1:m
    h_exp(i) = init_h * 0.5^(i-1);
end

if ~isequal(h_exp,h)
    error("h überprüfen, sollte mit Faktor 0.5 abnehmen");
end

init_h = h(1);
h_exp = zeros(size(h));
for i=1:m
    h_exp(i) = init_h * 0.5^(i-1);
end

if ~isequal(h_exp,h)
    error("h überprüfen, sollte mit Faktor 0.5 abnehmen");
end

%erste Spalte ausrechnen
D(:,1) = Dxf(x0, h, f);

%extrapolieren
for k=2:m
    for i=1:m-(k-1)
        faktor = 2.^(k-1);
        z1 = faktor.*D(i+1,k-1);
        z2 = D(i,k-1);
        n = 2.^(k-1)-1;
        D(i,k) = (z1 - z2) ./ n;
    end
end



s = functions(Dxf);

%disp("h-Extrapolation mit Differenzformel " + s.function + "; h/Dik");
%disp("Fehlerordnung O(h^k) mit h =" + h(1) + " k = " + m);
row_header = ["h"; string(h)'];

col_header_e = strings([1,m]);
col_header_d = strings([1,m]);
for i=1:m
    col_header_e(i) = "Ei" + string(i);
    col_header_d(i) = "Di" + string(i);
end


D_table = [col_header_d;D];
D_table = [row_header, D_table];
%disp(D_table);

%Diskretisierungs-Fehler Matrix E
if exist('fdiff_analyt','var')
    E = abs(D - fdiff_analyt(x0));
    E = flip(tril(flip(E)));
    E_table = [col_header_e;E];
    E_table = [row_header, E_table];
    E_table(1,1) = "" + E_table(1,1);
    %disp(E_table);
end


end

