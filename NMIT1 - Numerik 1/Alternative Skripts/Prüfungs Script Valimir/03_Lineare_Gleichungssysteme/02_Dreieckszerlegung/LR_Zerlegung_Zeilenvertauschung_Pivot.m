%LR-ZERLEGUNG MIT SPALTENPIVOTISIERUNG
%Parameter:
%Mit zwischenritte = 1; ohne = 0;
mit_zwschr = 0;
%Format rat = brüche; long = dezimal usw.
format rat;
A = [3 9 12 12; -2 -5 7 2; 6 12 18 6; 3 7 38 14];
b = [51;2;54;79];



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = size(A);
n = n(1);
L = zeros(n);
Lz = zeros(n);
R = zeros(n);
P = eye(n);
for(i=1:1:n-1)
    As = A(i:end,i:end);
    clear max;
    clear k;
    [pivot, k] = max(As(:,1));
    k= k + (i-1);
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
%             Le = L - eye(n);
%             [M, I] = max(Le);
%             if(M>0)
%                 disp('Hello');
%                 l = L(i,i);
%                 L(i,i) = L(k,i);
%                 L(k,i) = l;
%             end
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
    for(j=i+1:1:n)
        r = A(j,i)/A(i,i);
        fprintf('z%d := z%d - (%d/%d)*z%d\n',j,j,A(j,i),A(i,i),i);
        A(j,:)=A(j,:)-r*A(i,:); 
        Lz(j,i) = r;
        if(mit_zwschr)
            A
            L = Lz+eye(n)
        end
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
