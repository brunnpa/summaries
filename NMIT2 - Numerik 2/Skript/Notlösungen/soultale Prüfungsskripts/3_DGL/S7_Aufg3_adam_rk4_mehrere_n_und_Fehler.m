%% 7.3a)
f = @(x,y) y;
a = 0;
b = 1;
y0 = 1;
n_array = [1e1,1e2,1e3,1e4];
s = 4;

for i = 1:4
   n = n_array(i);
   [x_rk4,y_rk4] = rk4(f,a,b,n,y0);
   [x_ab4,y_ab4] = adams_bashforth_s(f,a,b,n,y0,s);
   
   plot(x_rk4,y_rk4);
   hold on;
   plot(x_ab4,y_ab4);
   xlim([0,1]);
   xlabel('y(x)');
   ylabel('y(1)(x)');
   title('Runge Kutta 4. Ordnung vs Adam Bashforth 4. Ordnung');
end
legend('10^1 rk4','10^1 ab4','10^2 rk4','10^2 ab4','10^3 rk4','10^3 ab4','10^4 rk4','10^4 ab4');

figure;

%% 7.3b)
for i = 1:4
   n = n_array(i);
   [x_rk4,y_rk4] = rk4(f,a,b,n,y0);
   y_rk4_err(i) = abs(y_rk4 - exp(1));
   [x_ab4,y_ab4] = adams_bashforth_s(f,a,b,n,y0,s);
   y_ab4_err = abs(y_ab4 - exp(1));
   
   semilogy(x_rk4,y_rk4_err);
   hold on;
   semilogy(x_ab4,y_ab4_err);
   xlim([1 10^4]);
   title('Runge Kutta 4. Ordnung vs Adam Bashforth 4. Ordnung');
   xlabel('n');
   ylabel('Globale Fehler');
end
legend('Runga Kutta Ordnung 4','Adam Bashforth Ordnung 4');