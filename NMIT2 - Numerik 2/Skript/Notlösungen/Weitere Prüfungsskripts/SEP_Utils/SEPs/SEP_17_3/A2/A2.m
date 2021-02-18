clf
clear
clc

a = 0;
b = 6;
h = 0.2;
n = abs(b-a)/h;
f = @(x,y) 0.1*y + sin(2*x);
y0 = 0;

%% 2.a)
[ x_euler, y_euler ] = euler(f,a,b,n,y0);
[x_rk4, y_rk4] = rk4(f,a,b,n,y0);

plot(x_euler, y_euler);
hold on;
plot(x_rk4, y_rk4);
grid on;

%% 2.b)
y_diff = abs(y_euler - y_rk4);

figure
semilogy(x_euler,y_diff);
grid on;
xlabel('|y(x-euler)-y(x-rk4)|');