clear, clf;
t = 0:10:110;
p = [76 92 106 123 137 151 179 203 227 250 281 309];
p = p .* 10.^6;
%p1(t)
f1 = @(t) t.^3;
f2 = @(t) t.^2;
f3 = @(t) t;
f4 = @(t) ones(size(t));
A = [f1(t)' f2(t)' f3(t)' f4(t')];
ATA = A'* A;
ATy = A'* p';
l = ATA^-1 * ATy;
p1 = @(t) l(1).*f1(t) + l(2).*f2(t) + l(3).*f3(t) + l(4).*f4(t);
%p2(t)
f5 = @(t) t.^2;
f6 = @(t) t;
f7 = @(t) ones(size(t));
A_2 = [f5(t)' f6(t)' f7(t)'];
ATA_2 = A_2' * A_2;
ATy_2 = A_2' * p';
l_2 = ATA_2^-1 * ATy_2;
p2 = @(t) l_2(1).*f5(t) + l_2(2).*f6(t) + l_2(3).*f7(t);

clf;
plot(t,p,'ro');
hold on;
t_ausgl = [0:1:110]
p_ausgl = p1(t_ausgl);
plot(t_ausgl, p_ausgl, 'b');
p_ausgl_2 = p2(t_ausgl);
plot(t_ausgl, p_ausgl_2, 'r--');

%fehlerfunktional
e_p1 = @(x,y) sum((y - x).^2); 
e_p2 = @(x,y) sum((y - x).^2); 
p_ausgl1 = p1(t);
p_ausgl2 = p2(t);
%error_p1 = 6.6484e+13
%error_p2 = 6.6931e+13
%p1 leicht besser
error_p1 = e_p1(p_ausgl1,p);
error_p2 = e_p2(p_ausgl2,p);

