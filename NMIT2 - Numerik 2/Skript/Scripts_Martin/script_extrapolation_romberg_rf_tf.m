clc;
format long;

% ====================================================================== %
% Script: Romberg Extrapolation mit
%         - summierter Rechteckregel (DF1)
%         - summierter Trapezregel (TF1)
%
% Beschreibung:
% Berechnung mittels Romberg Extrapolation. Entweder ausfuerhbar unter
% Verwendung der summierten Rechteckregel oder der summierten Trapezregel
% durch ein/-auskommentieren der entsprechenden Zeile /siehe TODO)
% ====================================================================== %


f = @(x)cos(x^2);
a = 0;
b = pi;
m = 4;


TMatrix = zeros(m+1);

% TODO: hier die entsprechende Berechnungsmethode auswaehlen
T1f = @(n) func_summierte_trapezregel(f, a, b, n); 
%T1f = @(n) func_summierte_rechteckregel(f, a, b, n); 

% B
for i = 1:(m+1)
    n = 2^(i-1);
    TMatrix(i,1) = T1f(n);
end


for k = 2:(m+1)
    kReal = k-1;
    for i = 1:(m+1) - kReal
        TMatrix(i,k) = (4^kReal * TMatrix(i+1, k-1) - TMatrix(i, k-1)) / (4^kReal - 1);
    end
end

T = TMatrix(1,m+1);

fprintf('T:\n');
disp(TMatrix);
fprintf('\nOptimales h: %f\n', T);



[T,E] = func_romberg_extrapolation(f,a,b,n);

