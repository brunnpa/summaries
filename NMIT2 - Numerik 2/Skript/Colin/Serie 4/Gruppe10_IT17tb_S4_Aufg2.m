% a) Berechnet die Energie E, welche von einem Defibrillator abgegeben wird.
% b) Löst das Nullstellenproblem mit dem Newton Verfahren wobei die
% Ableitung mit dem h^2 Algorithmus berechnet wird
%
% Lösung Aufgabe 2a)
% Die Anzahl der Iterationen wurde zu klein gewählt. Bei einem grösseren n
% bleibt die Energie irgendwann stabil
%
% RETURN
%
% SAMPLE
% [] = Gruppe10_IT17tb_S4_Aufg2()
function [] = Gruppe10_IT17tb_S4_Aufg2()
%% Aufgabe 2a)
% Konstanten aus Aufgabenstellung:
n = 3; % Anzahl Iterationen Rhomberg
R = 50;
V = @(t) 3500*sin(140*pi*t).*exp(-63*pi*t);
E = @(t) V(t).^2/R;
t = 0:10^(-4):50*10^(-3); % 0.05 da Sekunden
Et = zeros(1,length(t));

i = 1;
for time = t
    Et(i) = HELPER_S3_AUFG3(E, 0, time, n);
    i = i + 1;
end

% yyaxis um eine Grafik mit 2 Achsen zu erstellen
yyaxis left
plot(t, V(t));
ylabel('Spannungspuls V(t) [V]');
xlabel('Zeit [s]');

yyaxis right
plot(t, Et);
ylabel('Energie E(t) [J]');

%% Aufgabe 2b)
% Konstanten gemäss Aufgabenstellung
format long;
E = @(t) V(t).^2/R;
f = @(t) E(t)-250;
h = 0.01;
tol = 10^-5;
start = 5e-3;

while ((f(start - tol) * f(start + tol)) > 0) 
    % Ableitung
    fdiff = HELPER_S2_AUFG2(f, start, h, n);
    % Newton Verfahren
    xn1 = start - (f(start)./fdiff);
    start = xn1; 
end

fprintf('nach %d sekunden sind 250J frei geworden\n', start);

tx = 0.004:0.0005:0.016;
figure
hold on
plot(tx, E(tx));
plot(start, E(start), 'o');


end