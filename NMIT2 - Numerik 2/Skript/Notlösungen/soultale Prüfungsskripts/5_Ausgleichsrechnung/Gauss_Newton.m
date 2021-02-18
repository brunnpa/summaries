clear, clf;
x = [0 1 2 3 4]; % Edit
y = [3 1 0.5 0.2 0.05]; % Edit
syms a b;
g = y - a.*exp(b.*x); % Edit y - f(a,b,...)
g = matlabFunction(g);
g_vec = @(l)g(l(1,1),l(2,1))';
Dg = jacobian(g, [a,b]);
disp('Dg(a,b)');
disp(Dg);
Dg = matlabFunction(Dg);
Dg_vec = @(l)Dg(l(1,1),l(2,1));

tol = 1e-5; % Edit
l0 = [1; -1.5];
ln = l0;
err = tol + 1;
n = 0;
while err > tol
    ATA = Dg_vec(ln)'*Dg_vec(ln);
    ATy = -Dg_vec(ln)'*g_vec(ln);
    delta = ATA^-1 * ATy;
    err = abs(sum(g_vec(ln).^2)-sum(g_vec(ln+delta).^2));
    ln = ln + delta; 
    n = n+1;
end
%anzahl iteration für erreichen der genauigkeit
disp(n-1);
%ursprünglicher vekotr
f_vec = @(l) l(1).*exp(l(2).*x); 
y_estimated = f_vec(ln);
plot(x,y,'r',x,y_estimated,'b');

