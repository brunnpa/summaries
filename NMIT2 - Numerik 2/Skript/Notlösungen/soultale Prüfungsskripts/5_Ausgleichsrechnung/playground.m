%f = a.*exp(x) + b;
% f1 = exp(x) f2=1
x = [0:4];
y = [6, 12, 30, 80, 140];

A = [exp(x)' ones([5,1])];

ATA = A' * A;
ATY = A' * y';
l = ATA^-1 * ATY;
f_opt = @(x) l(1).*exp(x) + l(2);
x_opt = [0:0.01:4];
y_opt = f_opt(x_opt);
clf,clc;
plot(x,y, 'bo');
hold on;
plot(x_opt,y_opt,'g');