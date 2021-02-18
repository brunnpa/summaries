% Konstanten gemäss Aufgabe
c = 0.16;
m = 1;
l = 1.2;
g = 9.81;

% Formel gemäss Aufgabe
f = @(x, z) [z(2); -(c/m) * z(2) - g/l * sin(z(1))];

% Werte für das System gemäss Aufgabe
a = 0;
b = 60;
h = 0.1;
z0 = [pi/2;0];
n = (b-a)/h;

% Vektoren erstellen und Startwerte hinzufügen
x = a:h:b;
phi = zeros(2, n+1);
phi(:,1) = z0;

% Runge-Kutta Verfahren mit Vektoren
for i = 1:n
    k1 = f(x(i), phi(:,i));
    k2 = f(x(i) + h/2, phi(:,i) + h/2 * k1);
    k3 = f(x(i) + h/2, phi(:,i) + h/2 * k2);
    k4 = f(x(i) + h, phi(:,i) + h * k3);
    phi(:, i+1) = phi(:,i)  + h .* (1/6) .* (k1 + 2.*k2 + 2.*k3 + k4);
end

% Plotten des Auslenkwinkels in Abhängigkeit zur Zeit
plot(x, phi(1,:));
xlabel('Zeit [s]');
ylabel('Auslenkwinkel phi');
grid