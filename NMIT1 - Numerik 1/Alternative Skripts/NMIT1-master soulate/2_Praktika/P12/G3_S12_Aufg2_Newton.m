function [result] = Lukic_Yanick_IT13a_S12_Aufg2_Newton(xn) 
syms x y;
f1 = (x^2 / 186^2) - (y^2 / (300^2 - 186^2)) - 1;
f2 = ((y-500)^2 / 279^2) - ((x-300)^2 / (500^2 - 279^2)) - 1;

Df = matlabFunction(jacobian([f1; f2], [x, y]));
f = matlabFunction([f1; f2]);

newton = @(xn) xn - Df(xn(1), xn(2))^-1 * f(xn(1), xn(2));
tol = 10^-5;

while norm(f(xn(1), xn(2))) > tol 
   xn = newton(xn);
end

result = xn;