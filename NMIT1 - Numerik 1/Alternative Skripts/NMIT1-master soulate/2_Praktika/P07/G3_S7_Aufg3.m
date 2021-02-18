function G3_S7_Aufg3()
%A1
A1 = [4 -1 -5; -12 4 17; 32 -10 -41];
b1a=[-5; 19; -39];
b1b=[6; -12; 48];
[A1a_triangle, detA1a, x1a] = G3_S7_Aufg2(A1, b1a);
[A1b_triangle, detA1b, x1b] = G3_S7_Aufg2(A1, b1b);

disp('Aufgabe 1--------');
x1a
mldivide_Ans = A1\b1a
linsolve_Ans = linsolve(A1, b1a)

x1b
mldivide_Ans = A1\b1b
linsolve_Ans = linsolve(A1, b1b)

%A2
A2 = [2 7 3; -4 -10 0; 12 34 9];
b2a=[25; -24; 107];
b2b=[5; -22; 42];
[A2a_triangle, detA2a, x2a] = G3_S7_Aufg2(A2, b2a);
[A2b_triangle, detA2b, x2b] = G3_S7_Aufg2(A2, b2b);


disp('Aufgabe 2 --------');
x2a
mldivide_Ans = A2\b2a
linsolve_Ans = linsolve(A2, b2a)
x2b
mldivide_Ans = A2\b2b
linsolve_Ans = linsolve(A2, b2b)

%A3
A3 = [-2 5 4; -14 38 22; 6 -9 -27];
b3a=[1; 40; 75];
b3b=[16; 82; -120];
[A3a_triangle, detA3a, x3a] = G3_S7_Aufg2(A3, b3a);
[A3b_triangle, detA3b, x3b] = G3_S7_Aufg2(A3, b3b);

disp('Aufgabe 3 --------');
x3a
mldivide_Ans = A3\b3a
linsolve_Ans = linsolve(A3, b3a)
x3b
mldivide_Ans = A3\b3b
linsolve_Ans = linsolve(A3, b3b)


%A4
A4 = [-1 2 3 2 5 4 3 -1; 3 4 2 1 0 2 3 8; 2 7 5 -1 2 1 3 5; 3 1 2 6 -3 7 2 -2; 5 2 0 8 7 6 1 3; -1 3 2 3 5 3 1 4; 8 7 3 6 4 9 7 9; -3 14 -2 1 0 -2 10 5];
b4=[11; 103; 53; -20; 95; 78; 131; -26];
[A4a_triangle, detA4, x4] = G3_S7_Aufg2(A4, b4);

disp('Aufgabe 4 --------');
x4
mldivide_Ans = A4\b4
linsolve_Ans = linsolve(A4, b4)

% Unterschiede
% mldivide und linsolve liefen die gleichen werte. Die Werte haben liechte
% Rundungsfehler.