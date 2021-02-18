%Aufg6 c

A = [0.64 0.16 0.20;0.16 0.68 0.16; 0.20 0.16 0.64];
b = [32.4; 26.4; 41.2]

%absolute
norm(A^-1, inf) * 0.5

%relative
norm(A, inf) * norm(A^-1, inf) * 0.5/norm(b, inf)