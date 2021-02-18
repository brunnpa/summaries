%GAUSS-ALGORITHMUS MIT SPALTENPIVOTISIERUNG
%Parameter:
%Mit zwischenritte = 1; ohne = 0;
mit_zwschr = 0;
%Format rat = brüche; long = dezimal usw.
format rat;
A = [1 2 -1; 4 -2 6; 3 1 0];
b = [1;40;75];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = size(A);
n = n(1);
for(i=1:1:n-1)
    clear max k;
    [max, k] = max(A(:,i));
    if(k>i)
            if(A(k,i)~=0)
                A([k,i],:) = A([i,k],:);
                b([k,i],:) = b([i,k],:);
                fprintf('z%d <=> z%d\n',i,k);
                if(mit_zwschr)
                    A
                    b
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
        b(j,:)=b(j,:)-r*b(i,:);
        if(mit_zwschr)
            A
            b
        end
    end
end
disp(' ');
disp('A als obere Dreiecksmatrix A_ =');
disp(A);
disp('b nach umformung =');
disp(b);
x = A\b;
disp('durch rückwärts-einsetzen x =');
disp(x);