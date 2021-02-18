x = [0 1 2 3 4];
y = [3 1 0.5 0.2 0.05];
syms a b;

g = y - a.*exp(b.*x);
g = matlabFunction(g);
g_vec = @(l)g(l(1,:),l(2,:))';
Dg = jacobian(g, [a,b]);
Dg = matlabFunction(Dg);
Dg_vec = @(l)Dg(l(1,1),l(2,1));

tol = 1e-10;
l0 = [2; 2];
ln = l0;
n = 0;
p_range = 0:1:10;
run = 1;
while run
    ATA = Dg_vec(ln)'*Dg_vec(ln);
    ATy = -Dg_vec(ln)'*g_vec(ln);
    delta = ATA\ATy;
    ln_cand = ln + delta./(2.^p_range); 
    for i=1:size(ln_cand,2)
        err(i) = norm(g_vec(ln_cand(:,i)),2);
    end
    [min_err, index] = min(err);
    if(min_err <  norm(g_vec(ln),2))
       p = p_range(index);
    else
       p = 0;
    end
    error_prev = g_vec(ln).^2;
    ln = ln + delta./(2.^p);
    error_new = g_vec(ln).^2;
    if abs(error_prev - error_new) < tol
        run = 0;
    end
    n = n+1;
end
%anzahl iteration für erreichen der genauigkeit
disp(n-1);
%ursprünglicher vekotr
clf;
f_vec = @(l) l(1).*exp(l(2).*x); 
y_estimated = f_vec(ln);
plot(x,y,'r',x,y_estimated,'b');
