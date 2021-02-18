clear;clc;

a = 0;
b = 0.5;
h = [1/4, 1/8, 1/16, 1/32, 1/64];
f = @(x)exp(1).^(-x.^2);
fdiff2 = diff2(f)
step = 0.001;

x = a:step:b;
y = abs(fdiff2(x));
[y_max,index] = max(y);
max_err = (h.^2 ./ 24).*(b-a).*x(index);
labels = ["h";"max_err"];
results = [string(h); string(max_err)];
results = [labels, results];
disp(results);



