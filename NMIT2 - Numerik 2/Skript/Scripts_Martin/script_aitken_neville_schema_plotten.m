% Inputwerte
xi = [-2,0,1]; % Aus Angabe 
yi = [-1,2,1]; % Aus Angabe
x = xi(1):0.1:xi(length(xi));

p22 = @(x) -(5/6).*x.^2 - (1/6) .* x + 2

plot(xi,yi,'ro', x, p22(x));
legend('Datenpunkte', 'Polynom');