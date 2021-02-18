%G3_S8_Aufg3a&b
x=[1997 1999 2006 2010]-1997;
y=[150 104 172 152];

plot(x+1997, y, 'r');hold on;

A=[x(1)^3 x(1)^2 x(1) 1; x(2)^3 x(2)^2 x(2) 1; x(3)^3 x(3)^2 x(3) 1; x(4)^3 x(4)^2 x(4) 1];
[A_triangle, detA, p] = G3_S7_Aufg2(A, y');
p=p';
func = @(x) p(1)*x^3 + p(2)*x^2 + p(3)*x^1 + p(4);

xf=1:1:15;
yf = zeros(15);
for i=1:1:15
    yf(i) = func(i);
end

plot(xf+1997, yf, 'b');
grid

ylabel('Tage');
xlabel('Jahr');

disp(['Schätzwert 2003: ', num2str(func(2003-1997))]);
disp(['Schätzwert 2004: ', num2str(func(2004-1997))]);