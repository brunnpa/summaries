%ABLEITUNGSRECHNER; ALLE BENOETIGTEN VARIABLEN IN SYMS
% Zur erinnerung log(e) = 1 falls in resultat ;)
% e auch als variable, nicht als exp(1)
% y = abzuleitende funktion

syms y a b c
y = x^2/1-x^2;
diff(y,x)
