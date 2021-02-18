function    [l]     =   lagrangePolynome(x)
% Test:     [l]     =   lagrangePolynome(3)
%
% Explanation:
%           Konstruiert Lagrande Polynome
%
% Params:
%           n: Anzahl Stützstellen

size_x = size(x,2);

syms x_est;
for i = 1:size_x
    l_i = 1;
    for j = 1:size_x
        if ~(j==i)
            l_i = l_i .* ((x_est-x(j))./(x(i)-x(j)));
         end
    end
    l(i) = l_i;
end
end
