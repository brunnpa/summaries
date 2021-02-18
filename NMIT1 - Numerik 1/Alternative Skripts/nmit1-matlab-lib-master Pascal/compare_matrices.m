function [eqEps, eqReal] = compare_matrices(A1,A2)
C = A1-A2;
eqEps = isequal(C<=eps,ones(size(A1)));
eqReal = A1 == A2;
end
