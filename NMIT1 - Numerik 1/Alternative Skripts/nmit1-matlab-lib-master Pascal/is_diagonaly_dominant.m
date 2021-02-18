% Prüft of Matrix diagonaldominant ist
%
% A = [4, -1, 1 ; -2, 5, 1 ; 1, -2, 5]
%
% [dominant, dominantByRow, dominantByCol] = is_diagonaly_dominant(A)
%
% A             = Matrix die zu prüfen ist
% dominant      = ist diagonaldominant
% dominantByRow = ist diagonaldominant nach Reihen
% dominantByCol = ist diagonaldominant nach Spalten
%
function [dominant, dominantByRow, dominantByCol] = is_diagonaly_dominant(A)
% take the absolute of the matrix
absA = abs(A);

% To be diagonally dominant, the row and column sums have to be less
% than twice the diagonal
rowSum = sum(absA,1)';%#' (formatting comment)
colSum = sum(absA,2);
dia    = diag(absA);

%test
dominantByRow = all(rowSum <= 2 * dia); 
dominantByCol = all(colSum <= 2 * dia);
dominant = dominantByRow || dominantByCol;
end


% Dominique Reiser