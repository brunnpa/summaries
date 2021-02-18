clc, clf, clear;
f = @(t,y) 0.1.*y + sin(2.*t);
y0 = 0; 
h = 0.2;
a = 0;
b = 6;
n = (b-a)./h;
[x_euler, y_euler] = euler(f,a,b,n,y0);
[x_rk4, y_rk4] = rk4(f,a,b,n,y0);
subplot(3,1,1);
plot(x_euler, y_euler, 'g');
hold on;
plot(x_rk4, y_rk4, 'b');
legend('Euler', 'Rk4');

subplot(3,1,2);
abs_diff = abs(y_euler - y_rk4);
semilogy(x_euler, abs_diff);
legend('Differenz zwischen Euler und Rk4, halblogarithmisch');

subplot(3,1,3);
abs_diff = abs(y_euler - y_rk4);
plot(x_euler, abs_diff);
legend('Differenz zwischen Euler und Rk4, nicht logarithmisch');
