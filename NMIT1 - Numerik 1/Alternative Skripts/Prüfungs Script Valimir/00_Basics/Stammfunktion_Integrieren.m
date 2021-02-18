%INTEGRALSRECHNER; ALLE BENOETIGTEN VARIABLEN IN SYMS
% Zur erinnerung log(e) = 1 falls in resultat ;)
% e auch als variable, nicht als exp(1).
% y = zu integrierende funktion

syms x y e a
y = -a^2+x^3;
int(y,x)