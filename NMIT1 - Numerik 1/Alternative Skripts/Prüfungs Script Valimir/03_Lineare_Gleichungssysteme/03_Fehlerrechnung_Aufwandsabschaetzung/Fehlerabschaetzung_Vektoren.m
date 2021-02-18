%ABSCHÄTZUNG FÜR FEHLERBEHAFTETE VEKTOREN
%Norm => 1,2,Inf,-Inf
Norm = Inf;
A = [2 4;4 8.1];
b = [1;1.5];
b_ = [];
b_abweichung = 0.1;
format short


disp(' ');
disp('Absoluter Fehler:');
if(b_abweichung == 0)
    b_abweichung = norm(b-b_, Norm);
end

A_1 = norm(A^(-1), Norm);
a = A_1 * b_abweichung;

fprintf('||x-~x|| <= %d * %d = %d \n', A_1,b_abweichung,a);

disp(' ');
disp('Relativer Fehler:');
bn = norm(b, Norm);
br = b_abweichung/bn;
A_ = norm(A, Norm)*norm(A^(-1), Norm);
r = A_*br;

fprintf('||x-~x||/||x|| <= %d * %d/%d = %d \n', A_,b_abweichung,bn,r);
