function [x_tilde] = Newton_1(x0, tol, func1, func2, func3)
    syms x1 x2 x3;
    f = [func1;func2;func3];
    fx = [func1;func2;func3];
    jacobian_matrix = jacobian(f, [x1;x2;x3]);
    x_tilde = x0;
    f = matlabFunction(f);
    Df = matlabFunction(jacobian_matrix);
    while norm(f(x_tilde(1,1),x_tilde(2,1),x_tilde(3,1))) > tol
        delta = (Df(x_tilde(1,1),x_tilde(2,1),x_tilde(3,1))\f(x_tilde(1,1),x_tilde(2,1),x_tilde(3,1)));
        x_tilde = (Df(x_tilde(1,1),x_tilde(2,1),x_tilde(3,1))\-f(x_tilde(1,1),x_tilde(2,1),x_tilde(3,1)))+x_tilde;
    end
end

% x_tilde = x^n-Näherungswert (Iteration)
% jacobian_matrix = Df-Jacobi-Matrix
% delta = delta-Vektor
