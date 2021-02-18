x = [0 1 2 3 4];
y = [3 1 0.5 0.2 0.05];
f = @(a,b,x) a.*exp(b.*x);
Ef = @(x, y,a, b) sum((y-f(a,b,x)).^2);
a = 2; 
b = 0.5
fehler1 = Ef(x,y,a,b);
a = 2.98165;
b = -1.00328;
fehler2 = Ef(x,y,a,b);

%partielle Ableitung nach a
syms a b;
f1 = -2.*sum((y - a.*exp(b.*x)).*exp(b.*x));
%partielle Ableitung nachb
f2 = -2.*sum((y - a.*exp(b.*x)).*a.*exp(b.*x).*x);

Df = jacobian([f1,f2], [a,b]);
Df = matlabFunction(Df);
f1 = matlabFunction(f1);
f2 = matlabFunction(f2);

fvec = @(x) [f1(x(1),x(2)); f2(x(1),x(2))]
Dfvec = @(x) Df(x(1),x(2));
%Newton Nst problem
tol = 1e-5;
x0 = [3; -1];
xn = x0;
err = tol + 1;
n = 0;
while err > tol
    Dx = -Dfvec(xn)\fvec(xn);
    xn = xn + Dx;
    err = norm(fvec(xn),2);
    err_2 = Ef(x,y,xn(1),xn(2));
    n = n+1;
end
disp(n);
disp(xn);