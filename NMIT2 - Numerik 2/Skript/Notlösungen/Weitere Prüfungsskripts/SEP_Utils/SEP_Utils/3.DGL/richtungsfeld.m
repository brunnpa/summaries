function     []     =   richtungsfeld(f, xmin, xmax, ymin, ymax, hx, hy)
% Test:      []     =   richtungsfeld(@(t, yt) t.^2 + 0.1 * yt, -1.5, 1.5, 0, 3, 0.2, 0.2)
%
% Params:
%       * Zeichnet das Richtungsfeld 
%       * Intervall:    [x_min, x_max]
%       * Intervall:    [y_min, y_max]
%       * Schrittweite: h_x / h_y (in x und y richtung)
%
% Algo:
%       1) meshgrid erzeugt die Koordinaten
%           x_min zu x_max in hx Schritten
%           y_min zu y_max in hy Schritten
%
%       2) f(x,y) berechnet für jeden der Punkte
%           * die Steigung: Ydiff = f(X,Y)
%
%           !!!! Funktion muss mit Vektoren rechnen können: .* ./ .^
%
%       3) quiver() zeihnet die Steigungsvektoren
%           * braucht dazu neben den Koordinaten X und Y
%           .. auch die Steigungsdreiecke
%       also:
%           x-Komponente: Matrix mit 1-en übergeben
%           y-Komponente: Steigungsdreieck Ydiff übergeben



% Zeigt ein Richtungsfeld einer Funktion an

% Koordinaten für die Punkte erzeugen
[X,Y] = meshgrid(xmin:hx:xmax, ymin:hy:ymax);

% Steigung an jedem Punkt berechnen
Ydiff = f(X,Y);

% Richtungsfeld einzeichnen. 
dim = size(Ydiff);
quiver(X,Y,ones(dim(1), dim(2)), Ydiff);

end
