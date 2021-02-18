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
T = [0 10 20 30 40 50 60 70 80 90 100]';
dichte = [999.9 999.7 998.2 995.7 992.2 988.1 983.2 977.8 971.8 965.3 958.4]';

% Ausgleichsfunktion und Koeffizienten berechen
% TODO, bei mehr/weniger Koeffizienten anpassen
A = [T.^2, T, ones(length(T), 1)];

fprintf('A:\n');
disp(A);

koeffizienten = (A' * A) \ (A' * dichte);

% Funktion aus Angabe. Der Koffeziennten Teil bleibt, nur 'T' muss
% ausgetauscht werden
% Funktion aus Angabe: 'p(T) = aT^2 + bT + c
% a,b,c = Koffeziennten(index);
p_t = @(T) koeffizienten(1).*T.^2 + koeffizienten(2).*T + koeffizienten(3);

% Plotten von den Daten und von der Funktion
plot(T, dichte, 'r', T, p_t(T), 'b');
legend('Daten', 'p(T)');
xlabel('Temperatur');
ylabel('Dichte');
grid on;
title('Plot der Daten und der Ausgleichsfunktion p(T)');

% Konditionszahl berechnen und Werte mit polyfit() vergleichen
disp('Konditionszahl ist: ');
disp(cond(A'*A, inf));

% TODO, bei mehr/weniger Koeffizienten anpassen
poly = polyfit(T, dichte, 2);

poly_tab = poly';
koeff_tab = koeffizienten;

% TODO Index 
for i=1:length(koeffizienten)
    diff_tab(i) = abs(koeffizienten(i) - poly(i));
end
diff_tab = diff_tab';

table(poly_tab, koeff_tab, diff_tab)

%{
Bemerkungen:
Konditionszahl sehr hoch -> kleine Fehler w�rden stark auswirken
Koeffizienten stimmen alle bis auf zwischen 16 und 12 Nachkommastellen
%}



