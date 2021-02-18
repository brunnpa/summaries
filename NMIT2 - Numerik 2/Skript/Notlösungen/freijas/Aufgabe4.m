% Inputwerte
x = [0,5,12,15];
y = [7,2,8,3];
% Mehrere gesuchte X-Werte
xx = 0:0.1:15;

[yy] = spline(x, y, xx);

plot(x,y,'o',xx,yy);


% Natürliche kubische Splinefunktion S(x)
% Input
% x = Vektor mit (n+1) gegebenen Stützstellen
% y = Vektor mit (n+1) gegebenen Stützwerten
% xx = Werte yy = S(xx)
% Output:
% yy = die y Werte auf der interpolierten Kurve
% Aufruf:
% [yy] = spline([0,1,2,3],[2,1,2,2],0:0.05:3)
function [yy] = spline(x, y, xx)
    n = length(x)- 1;

    % (1)(2) a und h berechnen
    a = zeros(n,1);
    h = zeros(n,1);
    for i = 1: n
        a(i) = y(i);
        h(i) = x(i+1) - x(i);
    end
    disp('a');
    disp(a);
    disp('h');
    disp(h);
    
    %(4) A und z aufstellen um c zu berechnen
    A = zeros(n-2);
    z = zeros(n-2,1);
    for idx = 1:(n-1)
        i = idx+1;
        z(idx,1) = 3 * (y(i+1) - y(i))/h(i) - 3 * (y(i)-y(i-1))/h(i-1);

        if (idx == 1) %(a)
            A(idx + 1, idx) = h(i);
        elseif(n >= 4 && idx < n-2) %(b)
            A(idx-1, idx) = h(i-1);
            A(idx+1, idx) = h(i);
        else % (c)
            A(idx-1, idx) = h(i-1);
        end

        A(idx, idx) = 2 * (h(i-1) + h(i));
    end
    disp('A');
    disp(A)
    disp('z');
    disp(z)
    % c  effektiv berechnen
    c = A\z;
    
    % (3) Fixe Werte dazusetzen
    c = [0;c;0]';

    disp('c');
    disp(c);
    
    % (5)(6) b und d berechnen
    b = zeros(1,n);
    d = zeros(1,n);
    for i=1:n
        b(i) = (y(i+1) - y(i)) / h(i) - (h(i)/3)*(c(i+1) + 2* c(i));
        d(i) = 1/(3*h(i)) * (c(i+1) - c(i));
    end
    disp('b');
    disp(b);
    disp('d');
    disp(d);
    
    % Nun die gesuchten Werte berechnen
    yy = zeros(length(xx),1);
    for i= 1:n
        r = find(x(i) <= xx & xx <= x(i+1));
        s = @(xx) polyval([d(i), c(i), b(i), a(i)], xx-x(i));
        yy(r) = s(xx(r));
        fprintf('S%d: %.2f + %.2f(x-%.2f) + %.2f(x-%.2f)^2+%.2f(x-%.2f)^3\n', i-1, a(i),b(i),x(i),c(i),x(i),d(i),x(i));
    end
    
  
end
