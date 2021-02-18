syms x1 x2 x3;
f1 = x1 + x2^2 - x3^2 -13;
f2 = log(x2/4) + exp(0.5*x3-1) - 1;
f3 = (x2-3)^2 - x3^3 + 7;

xn = [1.5; 3; 2.5];
disp('x0 =');
disp(xn);

f = matlabFunction([f1; f2; f3]);
Df = matlabFunction(jacobian([f1; f2; f3], [x1, x2, x3]));

for i=1:2
    % Delta berechnen
    fxn = f(xn(1), xn(2), xn(3));
    delta =  Df(xn(2), xn(3)) \ -fxn;

    % Minimales k finden
    for k=0:100
        attr = xn + delta / 2^k;
        if norm(f(attr(1), attr(2), attr(3))) < norm(fxn)
            break;
        end
    end

    xn = xn + delta / 2^k;
    disp(['x', num2str(i), '=']);
    disp(xn);
end