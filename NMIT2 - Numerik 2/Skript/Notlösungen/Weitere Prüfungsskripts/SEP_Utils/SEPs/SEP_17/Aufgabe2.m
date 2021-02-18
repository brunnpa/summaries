c0 = 3000;
a = 0;
b = 0.6;
h = 0.005;
t = a:h:b;
n = length(t);
alphaVektor = 0:-1:-10;

% Teilaufgabe A
subplot(3,1,1);
t0 = 0;
f = @(t,c,a) -0.6*c^(3/2) + 8*c0*(1-exp(a*t));

yE = zeros(n+1,length(alphaVektor));
for i=1:length(alphaVektor)
    alpha = alphaVektor(i);
    [x,y] = eulerKlassisch(f, a, b, n, t0, alpha);
    yE(:,i) = y;
    plot(x,y);
    hold on;
end
hold off;
% Teilaufgabe b
subplot(3,1,2);

yRk = zeros(n+1,length(alphaVektor));
for i=1:length(alphaVektor)
    alpha = alphaVektor(i);
    [x,y] = runge_kutta(f, a, b, n, t0, alpha);
	yRk(:,i) = y;
    plot(x,y);
    hold on;
end

% teilaufgabe c
subplot(3,1,3);
for i=1:length(alphaVektor)
   plot(x,abs(yRk(:,i)-yE(:,i))); 
   hold on;
end

% Ich glaube da stimmt etwas nicht mit meiner Methode... Normalerweise
% müsste das Runge-Kutta Verfahren aber genauer sein, da es
% Konvergenzordnung 4 hat und das Mittelpunktverfahren 2.
hold off;
function [x, y] = eulerKlassisch(f, a, b, n, y0,alpha)
    h = (b-a)/n;

    x = zeros(n+1, 1);
    y = zeros(n+1, 1);

    y(1) = y0;
    x(1) = a;

    for i=1:n
       x(i+1) = x(i) + h;
       y(i+1) = y(i) + h *  f(x(i), y(i),alpha);
    end
end

function [x, y] = runge_kutta(f, a, b, n, y0, alpha)
    h = (b-a)/n;

    x = zeros(n+1, 1);
    y = zeros(n+1, 1);

    y(1) = y0;
    x(1) = a;

    for i=1:n
        k1 = f(x(i), y(i), alpha);
        k2 = f(x(i) + h/2, y(i) + h/2 * k1, alpha);
        k3 = f(x(i) + h/2, y(i) + h/2 * k2, alpha);
        k4 = f(x(i) + h, y(i) + h * k3, alpha);
        
       x(i+1) = x(i) + h;
       y(i+1) = y(i) + h *  (1/6) * (k1 + 2*k2 + 2*k3 + k4);
    end
end