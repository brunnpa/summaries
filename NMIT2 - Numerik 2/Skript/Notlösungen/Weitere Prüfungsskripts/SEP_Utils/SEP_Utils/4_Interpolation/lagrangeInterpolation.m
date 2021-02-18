function    [p]     =   lagrangeInterpolation(x, y)
% Test:     [p]     =   lagrangeInterpolation()

l = lagrangePolynome(x);
p_i = sum(l .* y);
p =  matlabFunction(p_i);
end

