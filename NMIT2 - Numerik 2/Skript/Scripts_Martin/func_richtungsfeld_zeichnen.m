%{
Plotten des Richtungsfeld einer DGL

Funktionierender Aufruf: func_richtungsfeld_zeichnen(@(x,y)x.^2.*y.^2,0,3,0,3,0.1,0.1)

wobei f die Funktion ist,
xmin, xmax unf ymin, ymax die Intervallgrenzen sind
und hx und hy die Schrittweiten in die jeweilige Richtung sind.
%}

function [] = func_richtungsfeld_zeichnen(f, xmin, xmax, ymin, ymax, hx, hy)
    % (i) Koordinaten des Punkterasters
    [x,y] = meshgrid(xmin:hx:xmax, ymin:hy:ymax);
    
    % (ii) Steigung f�r jeden Punkt berechnen
    y_diff = f(x,y);    
    % Matrix lauter Einsen erstellen - diese wird quiver �bergeben
    [m,n] = size(y_diff);
    einsen_matrix = ones(m,n);
    
    % (iii) Mittels quiver() Steigungsvektoren f�r jeden Punkt zeichnen
    q = quiver(x, y, einsen_matrix ,y_diff);
    xlim([xmin-hx xmax+hx]);
    ylim([ymin-hy ymax+hy]); 
end

