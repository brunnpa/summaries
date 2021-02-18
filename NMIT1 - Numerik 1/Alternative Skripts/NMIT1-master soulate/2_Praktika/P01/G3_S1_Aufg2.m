function [y,ydiff,yint] = G3_S1_Aufg2(a,xmin,xmax)
a = a;
x = xmin:0.2:xmax;

%Vektor y
y = size(x);
y = zeros(y);
exponentf = 0;

for koeffizient = 1:numel(a)
    y = y + koeffizient*x.^exponentf;
    exponentf = exponentf + 1;
end

%Vektor ydiff
ydiff = size(x);
ydiff = zeros(ydiff);
exponentdiff = 1;

for koeffizient = 2:numel(a)
    ydiff = ydiff + koeffizient*exponentdiff*x.^(exponentdiff-1);
    exponentdiff = exponentdiff + 1;
end

%Vektor yint
yint = size(x);
yint = zeros(yint);
exponentyint = 1;

for koeffizient = 1:numel(a)
    yint = yint + (koeffizient/exponentyint)*x.^exponentyint;
    exponentyint = exponentyint + 1;
end

plot(x,y)
hold on
plot(x,ydiff)
plot(x,yint)
grid
legend('y','ydiff','yint')