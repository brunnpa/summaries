x = 0:0.1:3;
y = 2.*x.^2;

% Summierte Rechtecksregel für nicht äquidistante Punkte
Rf = 0;
for i=2:2:length(x)-1
    Rf = Rf + ((x(i+1) - x(i-1)) * y(i));
end
disp(Rf);

% Summierte Trapeztregel für nicht äquidistante Punkte
Tf = 0;
for i=1:length(x)-1
    Tf = Tf + (y(i) + y(i+1))/2 * (x(i+1) - x(i));
end
disp(Tf);

% Simpsonregel als gewichtetes Mittel zwischen Rechtecks und Trapezregel
Sf = (1/3) * (Tf + 2*Rf);
disp(Sf);

disp(integral(@(x) 2.*x, 0, 3));