% Aufruf: [y] = sekantenverfahren(@(x) exp(x^2) + x^(-3) -10, -1.0, -1.2,10^(-5))
% f    = funktion für welche die nullstelle gefunden werden soll
% x0   = X wert 1
% x1   = X wert 2 wenn moeglich sollte die nullstelle zwischen den beiden
%          werten x1 und x0 liegen da dann die funktion schneller konvergiert.
% tol  = Toleranz
% return y = nullstelle an position y
function [y] = sekantenverfahren(f,x0,x1,tol)
xn1 = x1;
xn = x0;
while f(xn+tol)*f(xn-tol)>= 0
    temp = xn;
    xn = xn - ((xn - xn1)/(f(xn) - f(xn1))) * f(xn);
    disp(num2str(xn, '%.9f'));
    xn1 = temp;
end

y = xn;

end

% Wir würden auf Probleme stossen, wenn die Ableitung 0 ergeben würde. Dann
% würden wir durch 0 dividieren, was nicht funktioniert.
