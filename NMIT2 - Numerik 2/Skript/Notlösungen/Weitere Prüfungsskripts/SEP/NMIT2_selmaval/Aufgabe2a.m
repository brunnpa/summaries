% NMIT2 SEP - Aufgabe 2a
% Valmir Selmani

f = @(t, yt) t - yt;
xmin = 0;
xmax = 3;
ymin = 0;
ymax = 3;
hx = 1;
hy = 1;
richtungsfeld(f, xmin, xmax, ymin, ymax, hx,hy)

function [ ] = richtungsfeld(f, xmin, xmax, ymin, ymax, hx, hy)
    % Koordinaten für die Punkte erzeugen
    [X,Y] = meshgrid(xmin:hx:xmax, ymin:hy:ymax);

    % Steigung an jedem Punkt berechnen
    Ydiff = f(X,Y)

    % Richtungsfeld einzeichnen. 
    dim = size(Ydiff);
    quiver(X,Y,ones(dim(1), dim(2)), Ydiff);
end