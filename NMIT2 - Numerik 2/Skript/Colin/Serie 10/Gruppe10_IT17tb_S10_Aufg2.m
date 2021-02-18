% Berechnet die natürliche kubische Spline Funktion und stellt diese
% grafisch dar
%
% PARAMETER
% x = der Vektor mit den Stützstellen
% y = der analoge Vektor mit den bekannten Stützstellen
% xx = Vektor der Stützwerten an diesen die Spline Funktion ausgewertet
% werden soll
%
% RETURN
% yy = Werte für die Spline Funktion
%
% SAMPLE
% [yy] = Gruppe10_IT17tb_S10_Aufg2([0 1 2 3],[2 1 2 2],[0.4 0.7 1.4 2.3])
function [yy] = Gruppe10_IT17tb_S10_Aufg2(x,y,xx)
    % Konstanten gemäss Aufgabenstellung
    n=length(x)-1; % da x = n+1
    yy=zeros(length(xx),1); % Ausgabevektor vorbereiten
    
    % Punkt 1 und 2 aus der Definition
    ai=zeros(n,1);
    h=zeros(n,1);

    for i = 1: n
        ai(i) = y(i);
        h(i) = x(i+1) - x(i);
    end
    
    % Punkt 4 aus der Definition (Ac = z)
    A = zeros(n-2);
    z = zeros(n-2,1);
    for actual = 1:(n-1)
        previous = actual - 1;
        next = actual+1; % first loop -> next = 2 --> y1,h1, actual = 1 --> y0,h0
        nextnext = next+1; % first loop -> nextnext = 3 --> y2
        z(actual,1) = 3 * (y(nextnext) - y(next))/h(next) - 3 * (y(next)-y(next-1))/h(next-1);
        
        % der actual/actual (diagonal) beinhaltet (2 * hactual + hnext)
        % darunter befindet sich hnext
        % rechts befindet sich hnext
        if (actual == 1)
            A(next, actual) = h(next);
        elseif(n >= 4 && actual < n-2)
            A(previous, actual) = h(actual);
            A(next, actual) = h(next);
        else
            A(previous, actual) = h(actual);
        end
        A(actual, actual) = 2 * (h(actual) + h(next));
    end
    ci = A\z;
    
    % Punkt 3 aus der Definition
    ci(1)=0;
    ci(n+1)=0;
    
    % Punkt 5 aus der Definition    
    bi=zeros(1,n);
    
    for i=1:n
        bi(i) = (y(i+1) - y(i)) / h(i) - (h(i)/3)*(ci(i+1) + 2* ci(i));
    end
    
    
    % Punkt 6 der Definition
    di=zeros(1,n);
    
    for i=1:n
        di(i) = 1/(3*h(i)) * (ci(i+1) - ci(i));
    end
    
    % Berechnung yy
    yy = zeros(length(xx),1);
    for i= 1:n
        element_in_range = find(x(i) <= xx & xx <= x(i+1));
        s = @(xx) polyval([di(i), ci(i), bi(i), ai(i)], xx-x(i));
        yy(element_in_range) = s(xx(element_in_range));
    end   
    plot(xx,yy);
end