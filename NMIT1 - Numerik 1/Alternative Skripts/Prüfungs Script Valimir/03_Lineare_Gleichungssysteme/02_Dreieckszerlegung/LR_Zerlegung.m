%LR-ZERLEGUNG
%Parameter:
%Mit zwischenritte = 1; ohne = 0;
mit_zwschr = 0;
%Format rat = Brüche; long = dezimal usw.
format rat;
A = [9 12 6; 12 25 23; 6 23 78]; % Zu zerlegende Matrix
b = [1;40;75];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = size(A);
n = n(1);
L = eye(n);
R = zeros(n);
for(i=1:1:n-1)
    if(A(i,i)==0)
        disp('LR-Zerlegung nicht mï¿½glich, weil Zeilenvertauschung notwendig.');
    end
    for(j=i+1:1:n)
        r = A(j,i)/A(i,i);
        fprintf('z%d := z%d - (%d/%d)*z%d\n',j,j,A(j,i),A(i,i),i);
        A(j,:)=A(j,:)-r*A(i,:); 
        L(j,i) = r;
        if(mit_zwschr)
            A
        end
    end
end
R = A;
disp(' ');
disp('obere Dreiecksmatrix R =');
disp(R);
disp('normierte untere Dreiecksmatrix L =');
disp(L);
y = L\b;
disp('durch vorwï¿½rts-einsetzen Ly=b => y=');
disp(y);
x = R\y;
disp('durch rï¿½ckwï¿½rts-einsetzen Rx=y => x=');
disp(x);
