%functions
f = @(x) x.^5 - 5*x.^4 - 30*x.^3 + 110*x.^2 + 29*x -105;
fab = @(x) 5*x.^4 -20*x.^3-90*x.^2 + 220*x + 29;
fst = @(x) 1/6*x.^6 - 5/5*x.^5 - 30/4*x.^4 + 110/3*x.^3 + 29/2*x.^2-105*x;

%intervall
x = -100:0.1:100;

plot(x, f(x), x, fab(x), x, fst(x));grid on
xlabel('x');
ylabel('y');

ylim([-1250,1250]);
xlim([-9,10]);

legend('f(x)','f`(x)','F(x)');
