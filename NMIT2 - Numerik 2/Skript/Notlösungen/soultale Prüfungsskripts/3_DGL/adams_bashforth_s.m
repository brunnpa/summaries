function [x, y] = adams_bashforth_s(f,a,b,n,y0,s)
% [x, y] = adams_bashforth_s(@(x,y)x.^2+0.1*y,-1.5,1.5,30,1,4)     (4. Ordnunug)
% s = Ordnung! (nicht das gleiche s wie bei der b-Formel)
h = (b-a)/n;
% disp("h = " + h);
y = zeros(1,n+1);
x = a:h:b;
y(1) = y0;

%Runge Kutta für Berechnung von Termen
[x_2, y_2] = rk4(f,a,(a+(s.*h)),s*s,y0);
%bei Ordnung 4 müssen die ersten 4 Terme ausgerechnet werden, etc.
for i=1:s:((s+1)*s)
    y(fix(i/s)+1) = y_2(i);
    %disp("x values:" + x(fix(i/s)+1)  + " " + x_2(i));
end

%restliche Terme berechnen
for i=s:n
    b = get_adams_b(s);
    sum = 0; 
    for j=0:(s-1)
        sum = sum + b(j+1)*f(x(i-j), y(i-j));
    end
    y(i+1) = y(i) + h.*sum;
end
end