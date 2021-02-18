function [x, y_euler, y_mittelpunkt, y_modeuler] = Berg_Michael_Gruppe2_S5_Aufg3(f,a,b,n,y0)
    
    [~  ,y_euler] = euler(f,a,b,n,y0);
    [~,y_mittelpunkt] = mittelpunktverfahren(f,a,b,n,y0);
    [x,y_modeuler] = modeuler(f,a,b,n,y0);
    
    
    % Grafiken
    hold on
    
    Berg_Michael_Gruppe2_S5_Aufg1(f, a, b, y0, 3.26, 0.05, 0.05);
    
    y = @(x,y) sqrt(2*x.^3 / 3 + 4);
    
    plot(x, y_euler);
    plot(x, y_mittelpunkt);
    plot(x, y_modeuler);
    plot(x, y(x));
    
    legend('Euler', 'Richtungsfeld', 'Mittelpunkt', 'ModEuler', 'Exakt');
end
