x = [1, 3, 5, 7];
y = [35, 1990, 70800, 2810000];
xx = 1:0.1:7;

yy = Spline_Interpolation(x,y,xx);

figure(2);
hold on;
plot(xx,yy);
scatter(x,y);

%Nein macht keinen Sinn