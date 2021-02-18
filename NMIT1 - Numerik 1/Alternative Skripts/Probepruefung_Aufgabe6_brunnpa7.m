function Probepruefung_Aufgabe6_brunnpa7

% Startvektor definieren
x0 = [1;2;3]
x = x0;

% Anzahl Iterationen festlegen
n = 1;

% Variablen definieren
syms a b c

% Funktion definieren
f = [
    (a + b * exp(1*c) - 40);
    (a + b * exp(1.6*c) -250);
    (a + b * exp(2*c) -800)
    ];

% Jacobi Matrix berechnen. Der 2. Parameter muss ein Vektor von Variablen sein!
D = jacobian(f, [a b c]);
disp("Die Jacobi Matrix ist:")
D

% Delta definieren
delta = - ( inv(D) * f);
disp("Das Delta ist: ");
delta



% Newton-Verfahren durchführen
for i= 1 : 1 : n
    % a, b, c initialisieren für Newton-Verfahren
    a = x(1);
    b = x(2);
    c = x(3);
    
    % x(n+1) berechnen (hier jeweils nur x
    disp(['Das ist die ', num2str(i) , '. Iteration:']);
    x = eval(x + delta)
end

disp("Das Endresultat für x ist:");
x
end