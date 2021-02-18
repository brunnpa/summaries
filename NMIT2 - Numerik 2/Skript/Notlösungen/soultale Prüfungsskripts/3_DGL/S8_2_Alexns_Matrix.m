c = 0.16;
m = 1;
l = 1.2;
g = 9.81;

a = 0;
b = 60;
h = 0.1;
n = abs(b-a)/h;

% phi'' = -c/m * phi' -g/l * sin(phi)

% Anfagen mit z1:
% z1 = phi
% z2 = phi'

% Alle ableiten:
% z1' = phi' = z2
% z2' = phi'' = -c/m * phi' -g/l * sin(phi) = z3

% z' = [z1'; z2'] = [z2; -c/m * phi' -g/l * sin(phi)] = [z2; -c/m * z2 -g/l * sin(z1)]
phi_ableitung = @(t, z)[z(2); -c/m*z(2)-g/l*sin(z(1))];  % ein Array mit ableitungen(aber index der normalen fkt nehmen) und zu unterst die funktion
phi_start = [pi/2; 0];

[x, y] = rk4(phi_ableitung, a, b, n, phi_start);

plot(x,y);