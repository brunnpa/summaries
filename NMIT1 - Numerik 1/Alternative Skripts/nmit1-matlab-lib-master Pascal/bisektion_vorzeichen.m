%   Gibt alle intervalle in welchen ein Vorzeichenwechsel stattgefunden hat
%   zurück - vorstufe für das Bisektionsverfahren

%   [iter] = bisektion_vorzeichen(@(x) cos(x).*sin(x),1,5)
%
%   func = Funktion für die, die Vorzeichenwechsel berechnet werden soll
%   a    = intervall start
%   b    = intervall ende

function [iter] = bisektion_vorzeichen(func, a, b)

% Intervall
intervall = a:0.5:b;
values = zeros(2,2);
iter = zeros(1,0);

for i=1 : length(intervall)
    values(1,i) = intervall(i);
    values(2,i) = func(intervall(i));
end

%alle werte anzeigen, wenn gewollt:
%disp(values)

for i=2 : length(values)
    signI = isNegative(values(2,i));
    
    if (signI ~= isNegative(values(2,i-1)))
        iter = [iter, "["+ num2str(values(1,i-1)) + ":" + num2str(values(1,i)) + "]"];
    end
end

end



% Pascal Fivian
