%ABSTOSSENDER ODER ANZIEHENDER FIXPUNKT
syms x
F(x) = (x-0.3)^(1/3);
x_ = 0.7864;


F_(x) = diff(F,x)
if(abs(F_(x_)) < 1)
    disp([x_]);
    disp(['Ist anziehender Fixpunkt']);
elseif(abs(F_(x_)) > 1)
    disp([x_]);
    disp(['Ist abstossender Fixpunkt']);
else
    disp([x_]);
    disp(['F_(x_) == 1, ka was das bedeuted']);
end