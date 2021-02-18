clear, clf;

t = [0.1 0.3 0.7 1.2 1.6 2.2 2.7 3.1 3.5 3.9];
y = [0.558 0.569 0.176 -0.207 -0.133 0.132 0.055 -0.090 -0.069 0.0271];

lambda0 = [1 2 2 1]';

syms x1 x2 x3 x4;
g = y - (x1.*exp(-x2.*t).*sin(x3*t + x4));
Dg = jacobian(g,[x1, x2, x3, x4]);

g = matlabFunction(g);
g_vec = @(l) g(l(1,:),l(2,:),l(3,:),l(4,:))';

Dg = matlabFunction(Dg)
Dg_vec = @(l) Dg(l(1,:),l(2,:),l(3,:),l(4,:));

k = 1;
ln = lambda0;
tol = 1e-5;
err = tol + 1;

while err > tol
    ATA = Dg_vec(ln)'*Dg_vec(ln);
    ATy = (-Dg_vec(ln))'*g_vec(ln);
    delta(:,k) = ATA \ ATy;
    err = abs(sum(g_vec(ln+delta(:,k)).^2) - sum(g_vec(ln).^2));
    ln = ln + delta(:,k); 
    k = k+1;
end

lambda_final = ln;
%original funktion mit optimalen lambdas
f_vec = @(l) l(1).*exp(-l(2).*t).*sin(l(3)*t + l(4));
y_estimated = f_vec(ln);
clf;
plot(t,y,'r',t, y_estimated, 'b');

