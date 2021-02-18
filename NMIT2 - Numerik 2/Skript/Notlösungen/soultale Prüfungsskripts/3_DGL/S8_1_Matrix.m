%y(4) + 1.1y’’’ − 0.1y’’− 0.3y = sin(x) + 5  
%mit y’(0) = 2 und y(0)=y’’(0)=y’’’(0)=0

%z1(x) = y(x)	=> z1’(x) = y’(x)
%z2(x) = y’(x)     => z2’(x) = y’’(x)
%z3(x) = y’’(x)     => z3’(x) = y’’’(x)
%z4(x) = y’’’(x)    => z4’(x) = y(4)x = sin(x) + 5 - 1.1z4 + 0.1z3 + 0.0z2 + 0.3z1

%        z1’                        z2
%z’ =  	 z2’    =                              z3			       = f(x,z) 
%        z3’                                                z4
%        z4’		sin(x) + 5 + 0.3z1 + 0.0z2  +    0.1z3  - 1.1z4

%         0
%z0  =    2     = b
%         0
%         0
clear;

A = [0,1,0,0; 0,0,1,0; 0,0,0,1; 0.3,0,0.1,-1.1];
f = @(x,z) A*z + [0;0;0;sin(x)+5];
y0 = [0;2;0;0];
x0 = 0;
a = x0;
b = 2;
%h = 0.1 => n=20
n = 20;
[x,y] = euler(f,a,b,n,y0);
clf;
plot(x,y(1,:));
hold on;
plot(x,y(2,:));
plot(x,y(3,:));
% Beispiel Auslenkungswinkel Fadenpendel
clc, clear;
c = 0.16;
m = 1;
l = 1.2;
g = 9.81;

phi = @(t, z)[z(2); -c/m*z(2)-g/l*sin(z(1))];
phi0 = [pi/2; 0];
a = 0;
b = 60;
h = 0.1;
n = abs(b-a)/h;
[t, y] = rk4(phi, a, b, n, phi0);

plot(t,y(1,:), 'r');
title('Fadenpendel integriert mit Runge-Kutta');
legend('Auslenkwinkel des Fadenpendels');
ylim([-2 2]);
