function G3_S1_Aufg1
hold off;
clc;

x = -10:0.1:10;
y = x.^5 - 5*x.^4 - 30*x.^3 + 110*x.^2 + 29*x - 105;
yAbleitung = 5*x.^4 -20*x.^3 -90*x.^2 +220*x +29;
yStamm = (1/6) * x.^6 - x.^5 - (30/4) *x.^4 + (110/3)*x.^3 + (29/2)*x.^2 - 105*x;

plot(x,y);
hold on
plot(x,yAbleitung);
plot(x,yStamm);
grid

xlim([-8 10])
ylim([-2000 2000])
end
