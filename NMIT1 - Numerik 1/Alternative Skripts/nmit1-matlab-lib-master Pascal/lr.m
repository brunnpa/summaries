% Löst das Gleichungssystem Ax = b mit der LR-Zerlegung 
% mit Zeilenvertauschung aus
%
% A = [3, 9, 12, 12 ; -2, -5, 7, 2 ; 6, 12, 18, 6 ; 3, 7, 38, 14]
% b = [51 ; 2 ; 54 ; 79]
% [L, R, P, y, x] = lr(A, b)
%
% A = Matrix für die die LR-Zerlegung gemacht werden soll
% b = Ziel-Vektor des Gleichungssystems
% L = Normierte untere Dreiecksmatrix
% R = Obere Dreiecksmatrix
% P = Matrix mit Zeilen Vertauschung
% y = Zwischenresultat : Ly = Pb
% x = Lösung des Gleichungssystems : Rx = y
%
function [L, R, P, y, x] = lr(A, b)
format rat
[L, R, P] = lu(A);

y = linsolve(L, P*b); % Ly = Pb
x = linsolve(R, y);   % Rx = y

if(compare_matrices(L*R, P*A))
disp('LR == PA')
else
disp('LR != PA')  
end
end


% Dominique Reiser

