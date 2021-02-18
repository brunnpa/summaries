A = [10^-5, 10^-5; 2, 3];
AGest =[10^-5, 10^-5; 2, 3];
b = [0; 1];
bGest = [10^-5;1];


[x, xGest, dxMax, dxObs, dxAbs] = fehlerrechnung_gs(A, b, AGest, bGest, 1);

disp("3.a " + cond(A,1));
disp("3.b ");
disp(xGest);
disp("3.c relativer Fehler von X: " +   dxObs);

bRelFehl = (norm(b,1) - norm(bGest, 1)) / norm(b, 1);
%disp("relativer Fehler b: " + bRelFehl);
disp("cond(A) * bRelFehl = " + cond(A,1) * bRelFehl);
disp("relFehl x <= cond(A) * bRelFehl : True");


    