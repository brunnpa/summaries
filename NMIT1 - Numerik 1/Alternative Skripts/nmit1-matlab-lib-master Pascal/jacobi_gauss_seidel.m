% löst iterativ ein Gleichungssystem Ax = b entweder nach Jacobi oder nach
% Gauss-Seidel
%
% A = [4, -1, 1 ; -2, 5, 1 ; 1, -2, 5]
% b = [5 ; 11 ; 12]
%
% [xn, n, n2] = jacobi_gauss_seidel(A, b, zeros(3, 1), 1e-4, 'Jacobi')
% [xn, n, n2] = jacobi_gauss_seidel(A, b, zeros(3, 1), 1e-4, '')
%
% A   = Gleichungssystem als Matrix
% b   = Lösung des Gleichungssystems
% x0  = startVektor
% tol = Fehlertoleranz
% opt = 'Jacobi' wenn jacobi sonst '' für gauss-seidel
% xn  = Iterationsvektor nach n Iterationen
% n   = Anzahl Iterationen
% n2  = Anzahl benötigter Schritte gemäss der a-priori Abschätzung
%
function [xn, n, n2] = jacobi_gauss_seidel(A,b,x0,tol,opt)
    [dominant, dominantByRow, dominantByCol] = is_diagonaly_dominant(A);
    if(~dominant)
        warning('Es kann sein, dass das Gleichungssystem nicht konvergiert, da A nicht diagonaldominant ist')
    else
        disp('Da A diagonaldominant ist, konvergiert das System sicher')
    end

    format long
    D = diag(diag(A));
    L = tril(A)-D;
    R = triu(A)-D;
    
    clear A;
    
    xn = x0;
    xn1 = xn;
    
    if (strcmp(opt, 'Jacobi'))
        B = -1*D\(L+R);
        xn = jacobi(L, D, R, b, xn);
    else
        B = -1*(D+L)\R;
        xn = gaussSeidel(L, D, R, b, xn);
    end
    x1 = xn;
    n = 1;
    
    while ~aPosteriori(xn, xn1, B, tol)
        n = n+1;
        xn1 = xn;
        if (strcmp(opt, 'Jacobi'))
            xn = jacobi(L, D, R, b, xn);
        else
            xn = gaussSeidel(L, D, R, b, xn);
        end  
    end
    clear L D  R  b  xn1;
    n2 = aPriori(x0, x1, B, tol);
end

function xn = jacobi(L, D, R , b, xn) 
    xn = (-1)*D\(L+R)*xn+D\b;
end

function xn = gaussSeidel(L, D, R, b, xn) 
    xn = (-1*(D+L)\R*xn) + ((D+L)\b);
end

function n = aPriori(x0, x1, B, tol)
    n = log10(tol*(1-norm(B,inf))/(norm(x1-x0, inf)))/log10(norm(B, inf));
end

function t = aPosteriori(xn, xn1, B, tol)
    t = (norm(B,inf)/(1-norm(B,inf)) * norm(xn-xn1,inf)) <= tol;
end



% Dominique Reiser