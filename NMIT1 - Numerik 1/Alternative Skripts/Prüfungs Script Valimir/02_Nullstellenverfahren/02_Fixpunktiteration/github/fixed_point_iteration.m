% fixed_point_iteration(@(x)(x^3+0.3), -1, 10^-5)
function xc = fixed_point_iteration(g, x0, tol)
    % Compute the fixed point of g(x).
    % Input:
    %   g - function to solve for the fixed point.
    %   x0 - initial guess
    %   tol - solution tolerance
    % Output:
    %   xc - computed root to the function g(x) = x.
    if nargin < 3
        tol = 1e-9;
    end

    prev_x = x0;
    x = g(x0);
    n = 1;
    while (abs(prev_x - x) > 0.5 * tol)
        prev_x = x;
        x = g(x);
        n = n + 1;
    end
    fprintf('\tn = %d\n', n);
    xc = x;
end
