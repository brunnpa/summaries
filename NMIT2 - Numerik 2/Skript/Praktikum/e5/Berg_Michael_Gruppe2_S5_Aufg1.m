function [] = Berg_Michael_Gruppe2_S5_Aufg1(f, xmin, xmax, ymin, ymax, hx,hy)

    % check
    % f = @(x,y) x.^2 .* y.^2
    % Berg_Michael_Gruppe2_S5_Aufg1(f, 0, 3, 0, 3, 0.1,0.1)

    [X,Y]= meshgrid(xmin:hx:xmax,ymin:hy:ymax);
    
    y_diff = f(X,Y);
    
    [m,n] = size(y_diff);
    I = ones(m,n);
    
    quiver(X,Y,I,y_diff);
    
    xlim([xmin-hx xmax+hx]);
    ylim([ymin-hy ymax+hy]);
    
end

