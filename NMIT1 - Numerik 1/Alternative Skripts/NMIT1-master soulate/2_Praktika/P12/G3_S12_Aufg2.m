
%a)
figure(1)
syms x y;
equ1 = (x^2 / 186^2) - (y^2 / (300^2 - 186^2)) - 1 == 0;
equ2 = ((y-500)^2 / 279^2) - ((x-300)^2 / (500^2 - 279^2)) - 1 == 0;
ezplot(equ1, [-2000, 2000]);
hold on
ezplot(equ2, [-2000, 2000]);
grid on
% Schnittpunkte optisch: (-1273/1594), (-193/66), (254/219), (740/906)

%b)
Lukic_Yanick_IT13a_S12_Aufg2_Newton([-1273; 1594])

Lukic_Yanick_IT13a_S12_Aufg2_Newton([-193; 66])

Lukic_Yanick_IT13a_S12_Aufg2_Newton([254; 219])

Lukic_Yanick_IT13a_S12_Aufg2_Newton([740; 906])

