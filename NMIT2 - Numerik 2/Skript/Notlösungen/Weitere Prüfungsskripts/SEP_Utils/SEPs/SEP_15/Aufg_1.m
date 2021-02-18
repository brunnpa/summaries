x0 = 1.5;
y0 = 0.02;

f11 = @(x,y) 2*cos(x+y);
f12 = @(x,y) (-2)*sin(x+y);
f21 = @(x,y) 2*cos(x+y);
f22 = @(x,y) (-2)*sin(x+y);

Dg = [f11(x0,y0) f21(x0,y0); f12(x0,y0) f22(x0,y0)];
display(Dg);