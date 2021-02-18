%ABSCHÄTZUNG FÜR FEHLERBEHAFTETE MATRIX
%Norm => 1,2,Inf,-Inf
Norm = Inf;
A = [2 4;4 8.1];
A_ = [2.003, 4.003; 4.003, 8.103];
A_abweichung = 0;
b = [1;1.5];
b_ = [];
b_abweichung = 0.1;
format long



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(b_abweichung == 0)
    b_abweichung = norm(b-b_, Norm);
end
if(A_abweichung == 0)
    A_abweichung = norm(A-A_, Norm);
end

%A_abweichung = norm(A_abweichung, Norm);
bnorm = norm(b, Norm);
br = b_abweichung/bnorm;
condA = norm(A, Norm)*norm(A^(-1), Norm);
Anorm = norm(A, Norm);
A_A_ = A_abweichung/Anorm;
r = (condA/(1-condA*A_A_))*(A_A_+br);

disp(' ');
bed = condA*A_A_;
if(bed < 1)
    fprintf('Bedingung cond(A)*||A - Ã||/||A|| < 1 ist erfüllt mit:\n');
    bed
else
    fprintf('Bedingung cond(A)*||A - Ã||/||A|| < 1 ist nicht erfüllt mit:\n');
    bed
end

disp(' ');
disp('Relativer Fehler:');
fprintf('||x-~x||/||x|| <= %d/(1-%d) * (%d/%d + %d/%d) = %d\n', condA,condA*A_A_,A_abweichung,Anorm,b_abweichung,bnorm,r);

