% ACHTUNG: Absoluter Fehler wird momentan nicht beachtet!!
clearvars
syms a;

f = pi / (2*cos(a)) + a - pi - tan(a);
df = diff(f);

nf = matlabFunction(f);
dfn = matlabFunction(df);

Newton = @(a) a - nf(a) / dfn(a);

xn = 1;
for i=1:100
    xn = Newton(xn);
end
xn


%[y1] = solve(equ2, a);
%degtorad(solve(equ2, a))
%ezplot(matlabFunction(pi / (2*cos(a)) + a - pi - tan(a)), [-10*pi, 10*pi]);