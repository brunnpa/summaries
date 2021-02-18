% PRINT FUNKTION (BEISPIEL)

%functions
f1 = @(x) 0.01 * x;
f2 = @(x) x.^-0.3 + x.^-0.5;

%intervall
x = 0:1:200;

figure
plot(x, f1(x), x, f2(x), x);
grid on
xlabel('x');
ylabel('y');

legend('A(p)','N(p)');
