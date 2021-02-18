% Erledigt das L/R Verfahren mit Spaltenpivotisierung
% 
% PARAMETER
% A = Matrix zum auflösen
% b = Resultatvektor
%
% RETURN
% L = Linke Matrix
% U = Rechte Matrix (entspricht der Gauss Matrix)
% P = Permutationsmatrix (Zeilenvertauschungen)
% x = Resultat der Gleichung
%
% SAMPLE
% [L,U,P,x]=l_r_zerlegung([1 2 -1; 4 -2 6; 3 1 0],[9;-4;9])
function [L,U,P,x]=l_r_zerlegung_colin(A,b)
 
[n,n]=size(A);
L=eye(n); P=L; U=A;
for k=1:n
    [pivot m]=max(abs(U(k:n,k)));
    m=m+k-1;
    if m~=k
        % interchange rows m and k in U
        temp=U(k,:);
        U(k,:)=U(m,:);
        U(m,:)=temp;
        % interchange rows m and k in P
        temp=P(k,:);
        P(k,:)=P(m,:);
        P(m,:)=temp;
        if k >= 2
            temp=L(k,1:k-1);
            L(k,1:k-1)=L(m,1:k-1);
            L(m,1:k-1)=temp;
        end
    end
    for j=k+1:n
        L(j,k)=U(j,k)/U(k,k);
        U(j,:)=U(j,:)-L(j,k)*U(k,:);
    end
    b = P * b;
    y = L \ b;
    x = U \ y;
end
