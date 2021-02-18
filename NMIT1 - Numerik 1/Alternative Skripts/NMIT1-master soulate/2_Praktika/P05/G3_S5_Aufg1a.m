function G3_S5_Aufg1a()
format long
clear

x = 1     %initial guess
Es = 10^-15    %tolerance
Ea = 1000;  %randomly large relative approximate error
xold = x;   
n = 0;      %iteration counter

while Ea > Es
    n = n + 1
    x = (230*x^4 + 18*x^3 + 9*x^2 - 9)/221
    Ea = abs((x-xold)/x)*100;
    xold = x;
end