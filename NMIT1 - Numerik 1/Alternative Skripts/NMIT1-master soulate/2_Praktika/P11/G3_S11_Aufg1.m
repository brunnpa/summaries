%Lukic_Yanick_IT13a_S11_Aufg1
%Gelöst mit Herrn Aebersold

% Aufgabe a)
% variables
g = 9.81;
v0 = 0:1:100;
a = 0:1:90;

%function
W = @(v0, a) (v0.^2 .* sind(2*a)) / g;
[X, Y] = meshgrid(v0, a);
Z = W(X, Y);

%a1
figure(1)
meshc(Z);

xlabel('Geschwindigeit v0 [m/s]');
ylabel('Startwinkel [rd]');
zlabel('Wurfweite [m]');
title('Wurfweite W')


%a2
figure(2);
contour(Z);

xlabel('Geschwindigeit v0 [m/s]');
ylabel('Startwinkel [rd]');
zlabel('Wurfweite [m]');
title('Wurfweite W')


%a3
figure(3);
surface(Z);
h = colorbar;

xlabel('Geschwindigeit v0 [m/s]');
ylabel('Startwinkel [rd]');
zlabel('Wurfweite [m]');
title('Wurfweite W')

ylabel(h, 'Wurfweite W');

% Antwort: Jeweils bei 45 Grad.


% Aufgabe 1b)
R = 8.31;

%1b) 1
V = 0:0.02:0.2;
T = 0:100:1e4;
p = @(V, T) (R*T) ./ V;

[X, Y] = meshgrid(V, T);
Z = p(X, Y);

figure(4);
meshc(Z);
xlabel('Volumen [m^3]')
ylabel('Temperatur [K]')
zlabel('Druck [N/m^2]')
title('p(V,T) = RT/V')


figure(5);
contour(Z);
xlabel('Volumen [m^3]')
ylabel('Temperatur [K]')
zlabel('Druck [N/m^2]')
title('p(V,T) = RT/V')


figure(6);
surface(Z);
colorbar;
xlabel('Volumen [m^3]')
ylabel('Temperatur [K]')
zlabel('Druck [N/m^2]')
title('p(V,T) = RT/V')


%1b) 2
p = 1e4:1000:1e5;
T = 0:100:1e4;
V = @(p, T) (R*T) ./ p;

[X, Y] = meshgrid(p, T);
Z = V(X, Y);

figure(7);
meshc(Z);
xlabel('Druck [N/m^2]')
ylabel('Temperatur [K]')
zlabel('Volumen [m^3]')
title('V(p,T) = RT/p')


figure(8);
contour(Z);
xlabel('Druck [N/m^2]')
ylabel('Temperatur [K]')
zlabel('Volumen [m^3]')
title('V(p,T) = RT/p')


figure(9);
surface(Z);
colorbar;
xlabel('Druck [N/m^2]')
ylabel('Temperatur [K]')
zlabel('Volumen [m^3]')
title('V(p,T) = RT/p')


%1b) 3
p = 1e4:100000:1e6;
V = 0:0.02:10;
T = @(p, V) (p.*V) ./ R;

[X, Y] = meshgrid(p, V);
Z = T(X, Y);

figure(10);
meshc(Z);
xlabel('Druck [N/m^2]')
ylabel('Volumen [m^3]')
zlabel('Temperatur [K]')
title('V(p,V) = pV/R')


figure(11);
contour(Z);
xlabel('Druck [N/m^2]')
ylabel('Volumen [m^3]')
zlabel('Temperatur [K]')
title('V(p,V) = pV/R')


figure(12);
surface(Z);
colorbar;
xlabel('Druck [N/m^2]')
ylabel('Volumen [m^3]')
zlabel('Temperatur [K]')
title('V(p,V) = pV/R')

