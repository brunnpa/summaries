%Abgabe David Lüscher Pascal Brunner Anastassios Martakos - Aufgabe 4

function Luescher_David_Gruppe4_S2_Aufg4

x = 1;

% Definition der Maschinengenauigkeit: Sobald 1+x nicht mehr von 1
% unterschieden werden kann, ist x = eps. (eps = Epsilon der Maschine,
% sprich die Minimum-Distanz, welche Matlab (floating point program)
% zwischen zwei beliebigen Zahlen x und y erkennen kann. 

while 1 + x ~= 1
    x = x/2;
end

% Letzte Operation wieder rückgängig machen, da die Schleife nicht
% flussgesteuert ist und somit die Zahl einmal zu viel verkleinert. 
x = x*2;

fprintf('Das ist meine Genauigkeit: %0.20f\n', x);
fprintf('Das ist               eps: %0.20f\n', eps);

% Der Rechner rechnet im Dualsystem. Denn nur so, wird die gleiche Zahl wie
% das Epsilon (eps) der Maschine erreicht. Er kann bis auf 16 Stellen genau
% rechnen
end