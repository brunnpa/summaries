% close all;
% alles kopieren und anpassen

numOfIterations = 1;
x0 = [1; 2; 3];

syms a b c;

f = [
    (a + b * exp(c*1) - 40);
    (a + b * exp(c*1.6) - 250);
    (a + b * exp(c*2) - 800)
];

Df = jacobian(f);
disp('Df(a, b, c) :')
disp(Df)

f = matlabFunction(f, 'Vars', {[a; b; c]});
Df = matlabFunction(Df, 'Vars', {[a; b; c]});

disp('f(1, 2, 3) :')
disp(f(x0))
disp('Df(1, 2, 3) :')
disp(Df(x0))

disp('x0:')
disp(x0)
delta0 =  Df(x0) \ f(x0);
disp('delta0:')
disp(delta0)

xn = x0;
df_0 = Df(x0);

for i= 1:numOfIterations
delta = Df(xn) \ f(xn);
% Vereinfacht, obere Zeile mit
% delta = df_0 \ f(xn);
% ersetzen.
xn = xn - delta;
end

fprintf('after %d iterations:\n\n', numOfIterations)
disp('x:')
disp(xn)

