%GAUSS-ALGORITHMUS
%Parameter:
%Mit zwischenritte = 1; ohne = 0;
mit_zwschr = 0;
%Format rat = brüche; long = dezimal usw.
format rat;
A = [1 2 -1; 4 -2 6; 3 1 0];
b = [1;40;75];



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
n = size(A);
n = n(1);
for(i=1:1:n-1)
    if(A(i,i)==0)
        for(j=i+1:1:n)
            if(A(j,i)~=0)
                A([i,j],:) = A([j,i],:);
                b([i,j],:) = b([j,i],:);
                fprintf('z%d <=> z%d\n',j,i);
                if(mit_zwschr)
                    A
                    b
                end
                break;
            end
            if(j==n && A(j,i)==0)
                disp('A ist nicht regulär');
                break;
            end
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