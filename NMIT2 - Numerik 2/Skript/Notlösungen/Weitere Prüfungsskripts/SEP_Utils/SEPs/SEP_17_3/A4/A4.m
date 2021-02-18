clc
clear
clf

x = [-2 0 1];
y = [-1 2 1];
xj = 0.5;

%% 4.a)
[ y_func, p_func ] = Aitken_Neville( x, y, xj );
disp('p(x) = ')
disp(p_func(3,3));

%% 4.b)
x_plot = -3:0.01:2;
p = @(x) -5/6.*x.^2-1/6.*x+2;

plot(x,y,'o');
hold on;
plot(x_plot, p(x_plot));