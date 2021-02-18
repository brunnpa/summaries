%ABLEITUNGSRECHNER; ALLE BENOETIGTEN VARIABLEN IN SYMS
% Zur erinnerung log(e) = 1 falls in resultat ;)
% e auch als variable, nicht als exp(1)
% y = abzuleitende funktion

syms x
y = 0.5*2^x;
diff(y,x)