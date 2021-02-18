syms x1 x2;
f1 = 20 - 18*x1 - 2*x2^2;
f2 = -4*x2 * (x1 - x2^2);

f = matlabFunction([f1; f2]);
Df = matlabFunction(jacobian([f1; f2], [x1, x2]));

x0 = [1.1; 0.9];

dx0 = Df(x0(1), x0(2));
fx0 = f(x0(1),x0(2));
delta = dx0 \ -fx0;
x1 = x0 + delta;
fx1 = f(x1(1), x1(2));
normFx1 = norm(fx);
normFx1Fx0 = norm(x1-x0);
x1
normFx1
normFx1Fx0

dx1 = Df(x1(1), x1(2));
delta = dx1 \ -fx1;
x2 = x1+delta;
fx2 = f(x2(1), x2(2));
normFx2 = norm(fx2);
normFx2Fx1 = norm(x2-x1);
x2
normFx2
normFx2Fx1





