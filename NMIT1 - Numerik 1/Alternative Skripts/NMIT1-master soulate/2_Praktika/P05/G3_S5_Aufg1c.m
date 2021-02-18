function G3_S5_Aufg1c()
format long
clear

x= 0;
x1 = (230*x^4 + 18*x^3 + 9*x^2 - 9)/221;
a = abs(((2*-0.5)/221) *(460 * 0.5^2 + 27*0.5 +9));

ans = log10(((10^-9) * (1-a))/abs(x1 - x))/log10(a)



