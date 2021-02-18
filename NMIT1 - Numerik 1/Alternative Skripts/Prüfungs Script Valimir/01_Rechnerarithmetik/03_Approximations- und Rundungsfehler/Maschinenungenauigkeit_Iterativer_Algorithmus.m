% eps 2^(-52) 2.2204e-16
% realmin 2^(-1022) 2.2251e-308
% realmax (2-eps)*2^1023 1.7977e+308
% eps ist die kleinste positive Zahl, fur die auf dem Rechner 1 + eps != 1 gilt. Man bezeichnet eps auch als Maschinengenauigkeit. 

e=1
while (e+1>1)
   e=e/2
end

e=e*2
e == eps

% das Limit ist bei 2.220446049250313e-16
% Rechner rechnet im Dualsystem, da sein Limit bei 2^(-52) ist


% Test dezimal
e1 = 1;
while (e1+1 ~= 1);
    e1 = e1/10;
end

e1 = 10*e1 
e1 == eps

% Computer rechnet im binären System, weil wir durch 2 rechnen und auf
% exakt eps kommen. Wenn durch 10 gerechnet wird, ist das Resultat ungleich
% eps.