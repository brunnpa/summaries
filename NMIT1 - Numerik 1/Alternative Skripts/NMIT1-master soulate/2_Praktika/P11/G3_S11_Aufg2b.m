%Lukic_Yanick_IT13a_S11_Aufg2b
%Gelöst mit Herrn Aebersold
c=1;
x=0:1:1000;
t=0:1:1000;

figure(1);
w = @(x, t) sin(x + c*t);
[X, Y] = meshgrid(x, t);
Z = w(X, Y);

mesh(Z);
xlabel('Ortskoordinate x');
ylabel('t: Zeit [s]');
zlabel('Auslenkung');


figure(2);
v = @(v, t) sin(x + c*t) + cos(2*x + 2*c*t);
[X, Y] = meshgrid(x, t);
Z = w(X, Y);

mesh(Z);
label('Ortskoordinate x');
ylabel('Zeit [s]');
zlabel('Auslenkung');