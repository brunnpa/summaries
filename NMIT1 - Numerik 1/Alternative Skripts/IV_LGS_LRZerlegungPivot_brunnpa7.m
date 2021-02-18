% LR ZERLEGUNG MIT ZEILENVERTAUSCHUNG PIVOT
% INPUT: 
%
% 
% OUTPUT:
% A = A Matrix
% P = Permutationsmatrix -> Ist immer regulär und es gilt P^-1 = P
%
% Beispielaufruf: 
% [L, R, y, x] = IV_LGS_LRZerlegungPivot_brunnpa7([3 9 12 12; -2 -5 7 2; 6 12 18 6; 3 7 38 14], [51;2;54;79])

function [L, R, y, x] = IV_LGS_LRZerlegungPivot_brunnpa7(A, b)
% Formatierung definieren
% Format rat = Brüche; Remind: (long = dezimal usw)
format rat;

% --- OPTIONAL FALLS DIREKT IN FUNCTION DEFINIEREN --- 
% A-Matrix definieren
% A = [3 9 12 12; -2 -5 7 2; 6 12 18 6; 3 7 38 14];
% b definieren
% b = [51;2;54;79];

mit_zwschr = 1;

% Dimension der nxn Matrix festlegen
n = size(A);
% Spaltendimension festlegen
n = n(1);
% L-Matrix mit 0 füllen
L = zeros(n);
Lz = zeros(n);
% R-Matrix mit 0 füllen
R = zeros(n);
% Permutationsmatrix als Einheitsmatrix aufstellen
P = eye(n);

for i=1 : 1 : n-1
    As = A(i:end,i:end);
    % Spaltenmaximum zurücksetzen
    clear pivot;
    clear k;
    % Spaltenmaximum festlegen 
    [pivot, k] = max(As(:,1));
    k = k + (i-1);
    if(k>i)
        if(A(k,i)~=0)
            Pn = eye(n);
            A([k,i],:) = A([i,k],:);
            Lz([k,i],:) = Lz([i,k],:);
            Pn(k,k) = 0;
            Pn(i,i) = 0;
            Pn(i,k) = 1;
            Pn(k,i) = 1;
            P = Pn * P;

            fprintf('z%d <=> z%d\n',i,k);
            if(mit_zwschr)
                A
                Pn
                L = Lz+eye(n)
            end
        else
            disp('A ist nicht regulär');
            break;
        end
    end
    for j = i+1 : 1 : n
        r = A(j,i)/A(i,i);
        fprintf('z%d := z%d - (%d/%d)*z%d\n',j,j,A(j,i),A(i,i),i);
        A(j,:)=A(j,:)-r*A(i,:); 
        Lz(j,i) = r;
    end
end
R = A;
disp(' ');
disp('obere Dreiecksmatrix R =');
disp(R);
disp('normierte untere Dreiecksmatrix L =');
disp(L);
disp('Permutationsmatrix P =');
disp(P);
disp('Ly=Pb und Rx=y;   Pb = ');
Pb = P*b;
disp(Pb);
y = L\(Pb);
disp('durch vorwärts-einsetzen Ly=Pb => y=');
disp(y);
x = R\y;
disp('durch rückwärts-einsetzen Rx=y => x=');
disp(x);
end