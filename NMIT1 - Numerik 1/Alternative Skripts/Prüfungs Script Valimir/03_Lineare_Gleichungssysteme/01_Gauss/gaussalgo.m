% Implementation der Gauss-Elimination zur Lösung von linearen
% Gleichungssystemen
% Parameter: Matrix A, Vektor b
% Rückgabewerte:
% untere normierte Dreiecksmatrix,obere Dreiecksmatrix A_triangle,
% Permutationmatrix, Determinante von A, Lösungsvektor x
% Beispiel eines Funktionsaufrufes:
% [L,R,P,detA,x] = gaussalgo(A,b)

function[L,A_triangle,P,detA,x] = gaussalgo(A,b)

format compact;
clc;

% m Zeilen, n Spalten
[m,n] = size(A);
% Datenvektor
[p,q] = size(b);

assert(m == p, 'Dimensions don''t match.');

% erweiterte Koeffizientenmatrix
M = [A b];
epsilon = 1e-16;

% Permutationsmatrix
P = eye(m);

% untere normierte Dreiecksmatrix
L = eye(m);

% über alle Zeilen der erweiterten Koeffizientenmatrix M
rowSwaps = 0;
for i=1:p
    % finde Pivot-Zeile
    pivotzeile = i;
    for a=i+1:p
        if abs(M(a,i)) > abs(M(pivotzeile,i))
           pivotzeile = a;
        end 
    end
    % swap M-Matrix
    tempRow = M(i,:);
    M(i,:) = M(pivotzeile,:);
    M(pivotzeile,:) = tempRow;
    % swap Permutationsmatrix
    tempPermRow = P(i,:);
    P(i,:) = P(pivotzeile,:);
    P(pivotzeile,:) = tempPermRow;
    rowSwaps = rowSwaps + 1;
    
    % singuläre oder fast singuläre Matrix?
    assert(abs(M(i,i)) >= epsilon, 'Matrix is singulär. Das Gleichungssystem ist nicht eindeutig lösbar');
    
    % für alle Spalten > i
    for j=i+1:p
        lambda = M(j,i) / M(i,i)
        L(j,i) = lambda;
        % einzelne Zeilenelemente eliminieren
        for k=i:p+1
            M(j,k) = M(j,k) - (lambda * M(i,k));
        end
        % Zum Testen: Ausgabe der Dreiecksmatrix nach jeder Zeilenoperation
        M
        P
    end
end
A_triangle = M(1:m,1:n);

% Determinante von A_triangle berechnen
detR = 1;
for i=1:length(A_triangle)
    detR = detR * A_triangle(i,i);
end
detA = (-1)^rowSwaps * detR;

% Rückwärts einsetzen
x = zeros(p,q);
for i=p:-1:1
    summe = 0;
    for j=i:p
        summe = summe + (M(i,j)* x(j));
    end
    x(i) = (M(i,n+1)-summe) / M(i,i);
end
end