clc, clear;
f = @(t) 2.*exp(-(t./10 -2).^4);
n = [1,2,4,8];

%n=1
h = 40; 
tf_h40 = ((f(0) + f(40))./2).*h;

%n=2;
h = 20;
tf_h20 = ((f(0) + f(40))./2 + f(20)).*h;

%n=4
h = 10;
xi = 10:h:30;
tf_h10  = ((f(0) + f(40))./2 + sum(f(xi))).*h;

%n=8
h = 5;
xi = 5:h:35;
tf_h5  = ((f(0) + f(40))./2 + sum(f(xi))).*h;

[D, D_table] = romberg_extrapolation(0,40,f,4);
disp(D_table);