%ANZIEHENDER ABSTOSSENDER FIXPUNKT
%AUCH PRUEFEN OB BEDINGUNG x = B*x +b erfüllt ist!!!
%Norm => 1,2,Inf,-Inf
Norm = Inf;
A = [4 -1 1; -2 5 1; 1 -2 4];
b = [5;11;12];
x = [1;2;3];



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
diagA = diag(A);
D = diag(diagA);
L = tril(A)-D;
R = triu(A)-D;

BJ = -inv(D)*(L+R)
BGS = -inv(D+L)*R
BJn = norm(BJ, Norm)
BGSn = norm(BGS, Norm)

disp(' ');
disp('Zuerst prüfen ob Bed.: x = B*x +b erfüllt ist!!!');
disp(' ');
disp('Fuer Jaccobi:');
disp(' ');
% x1 = BJ*x +b;
% x1 = x1-x;
% if(norm(x1,Inf) == 0)
%     disp('Bedingung x_ = Bx_ + b ist erfüllt');
% else
%     disp('Bedingung x_ = Bx_ + b ist nicht erfüllt!!!');
% end
if(BJn < 1)
    fprintf('Ist anziehender Fixpunkt ||B|| = %d\n',BJn);
elseif(BJn > 1)
    fprintf('Ist abstossender Fixpunkt ||B|| = %d\n',BJn);
else
    fprintf('||B|| = %d ka was das heisst...\n',BJn);
end
disp(' ');
disp(' ');
disp(' ');

disp('Fuer Gauss-Sedel:');
disp(' ');
% x1 = BGS*x +b;
% x1 = x1-x;
% if(norm(x1,Inf) == 0)
%     disp('Bedingung x_ = Bx_ + b ist erfüllt');
% else
%     disp('Bedingung x_ = Bx_ + b ist nicht erfüllt!!!');
% end
if(BGSn < 1)
    fprintf('Ist anziehender Fixpunkt ||B|| = %d\n',BGSn);
elseif(BGSn > 1)
    fprintf('Ist abstossender Fixpunkt ||B|| = %d\n',BGSn);
else
    fprintf('||B|| = %d ka was das heisst...\n',BGSn);
end

