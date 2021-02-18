% Erstellt ein Richtungsfeld für eine Funktion
%
% PARAMETER
% f = the function
% xmin = startwert intervall
% ymin = endwert intervall
% ymin = mindestwert y intervall
% ymax = max wert y intervall
% hx = schrittweite x
% hy = schrittweite y
%
% RETURN
%
% SAMPLE
% [] = Gruppe10_IT17tb_S5_Aufg1(@(x,y) x.^2.*y.^2,0,3,0,3,0.1,0.1)
function [] = Gruppe10_IT17tb_S5_Aufg1(f,xmin,xmax,ymin,ymax,hx,hy)
    % (i)    
    [X,Y] = meshgrid(xmin:hx:xmax,ymin:hy:ymax);
    % (ii)
    Ydiff = f(X,Y);
    % (iii)
    [a,b] = size(Ydiff);
    dummyMatrix = ones(a,b);
    % Richtungsfeld plotten
    quiver(X,Y,dummyMatrix,Ydiff);
    xlim([xmin-hx xmax+hx]);
    ylim([ymin-hy ymax+hy]); 
end