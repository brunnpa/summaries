clc;
format long;

%{
Skript fuer die Aufgabe 1 der Serie 11

Ausgleichsfunktion mittels kleinster Fehlerquadrate appoximieren,
Koeffizienten a,b und c berechnen sowohl p(T) graphisch darstellen.

Konditionszahl berechnen und Koeffizienten mit MATLAB Funktion polyfit()
vergleichen.
%}
% Werte aus der Aufgabenstellung
T = [0 10 20 30 40 50 60 70 80 90 100 110]';
dichte = [76 92 106 123 137 151 179 203 227 250 281 309]';

% Ausgleichsfunktion und Koeffizienten berechen
% TODO, bei mehr/weniger Koeffizienten anpassen
A = [T.^3, T.^2, T, ones(length(T), 1)];
B = [T.^2, T, ones(length(T), 1)];


fprintf('A:\n');
disp(A);

koeffizienten = (A' * A) \ (A' * dichte);
koeffizienten2 = (B' * B) \ (B' * dichte);

% Funktion aus Angabe. Der Koffeziennten Teil bleibt, nur 'T' muss
% ausgetauscht werden
% Funktion aus Angabe: 'p(T) = aT^2 + bT + c
% a,b,c = Koffeziennten(index);
p_t = @(T) koeffizienten(1).*T.^3 + koeffizienten(2).*T.^2 + koeffizienten(3).*T + koeffizienten(4);
p_t2 = @(T) koeffizienten2(1).*T.^2 + koeffizienten2(2).*T + koeffizienten2(3);

% Plotten von den Daten und von der Funktion
plot(T, dichte, 'r', T, p_t(T), 'b', T, p_t2(T), 'g');
legend('Daten', 'p(T)', 'p(T2)');


xlabel('year');
ylabel('Mio');
grid on;
title('Plot der Daten und der Ausgleichsfunktion p(T)');

% TODO, bei mehr/weniger Koeffizienten anpassen
poly = polyfit(T, dichte, 3);
poly2 = polyfit(T, dichte, 2);

poly_tab = poly';
poly_tab2 = poly2';

koeff_tab = koeffizienten;
koeff_tab2 = koeffizienten2;

% TODO Index 
for i=1:4
    diff_tab(i) = abs(koeffizienten(i) - poly(i));
end
diff_tab = diff_tab';

table(poly_tab, koeff_tab, diff_tab)


% TODO Index 
for i=1:3
    diff_tab2(i) = abs(koeffizienten2(i) - poly2(i));
end
diff_tab2 = diff_tab2';

table(poly_tab2, koeff_tab2, diff_tab2)

%{
Bemerkungen:
Konditionszahl sehr hoch -> kleine Fehler w�rden stark auswirken
Koeffizienten stimmen alle bis auf zwischen 16 und 12 Nachkommastellen
%}



