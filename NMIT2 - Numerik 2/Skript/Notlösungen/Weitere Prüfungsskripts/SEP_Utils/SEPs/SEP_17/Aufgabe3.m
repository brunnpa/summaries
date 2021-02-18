m = 2;
c = 15;
x0 = 2;
k = 0.1;

f = @(t, x) [x(2),-k/m.*x(2)-c./m.*(x(1)-x0)];

a = 0;
b = 5;
n = 1000;
y0 = [0.2; 0.15];


% Teilaufgabe b
[x,y] = eulerKlassischV(f, a, b, n, y0);
plot(x,y(:,1), x, y(:,2))
legend('v(t)', 'x(t)');


function [x, y] = eulerKlassischV(f, a, b, n, y0)
    h = (b-a)/n;

    x = zeros(n+1, 1);
    y = zeros(n+1, 2);

    y(1,:) = y0;
    x(1) = a;

    for i=1:n
       x(i+1) = x(i) + h;
       y(i+1,:) = y(i,:) + h .*  f(x(i), y(i,:));
    end
end