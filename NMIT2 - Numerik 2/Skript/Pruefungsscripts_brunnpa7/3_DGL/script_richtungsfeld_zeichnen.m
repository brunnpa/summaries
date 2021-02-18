clc;
format long;

% Aus Serie 5 Aufgabe 1


% Die Funktion f muss mit Vektoren rechnen können, 
% also bei der Funktions-Denition unbedingt die Punkte nicht vergessen
f = @(t, yt) t.^2 + 0.1 * yt;


% x-Intervall, Funktion berechnet nur Werte zwischen xmin und xmax
xmin = -1.5;
xmax = 1.5;

% y-Intervall, Funktion berechnet nur Werte zwischen ymion und ymax
ymin = 0;
ymax = 3;

% Schrittweite fuer Plot, je groesser der Werte desto groesser die Pfeile
hx = 0.2;
hy = 0.2;

% Koordinaten fuer die Punkte erzeugen
[X,Y] = meshgrid(xmin:hx:xmax, ymin:hy:ymax);

% Steigung an jedem Punkt berechnen
Ydiff = f(X,Y);
    
%disp(X);
%disp(Y);

% Richtungsfeld einzeichnen. 
dim = size(Ydiff);

% Richtungsfeld plotten lassen
quiver(X,Y,ones(dim(1), dim(2)), Ydiff);