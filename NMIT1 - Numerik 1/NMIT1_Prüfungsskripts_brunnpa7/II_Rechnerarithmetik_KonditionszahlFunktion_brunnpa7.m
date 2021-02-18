% KONDITIONSZAHL BERECHNUNG FÜR FUNKTIONEN
%
% INPUT
% Funktion anpassen
%
% OUTPUT
% n = Konditionszahl der Funktion
%
% BEISPIELAUFRUF
% [n, functionCondition] = II_Rechnerarithmetik_KonditionszahlFunktion_brunnpa7

function [n, functionCondition] = II_Rechnerarithmetik_KonditionszahlFunktion_brunnpa7
clear;
format long;

syms x

% Funktion definieren
f = x^2+2*x;

% Ableitung der Funktion definieren
fDiff = diff(f);

% x-Wert festlegen 
xValue = 3;

% Konditionszahl der Funktion berechnen und als Funktion abspeichern in
% functionCondition
functionCondition = abs(fDiff) * abs(x) / abs(f);

% Falls funktion sehr hässlich ausschaut, dann mit
% "simplify(functionCondition)" verschönert ausgeben lassen.

% Berechnung des Werts der Konditionszahl durch Substitution
n = subs(functionCondition, xValue);

end

%{ 
    subs(functionCondition,xValue) returns a copy of functionCondition, 
    replacing all occurrences of the 
    default variable x in functionCondition with xValue, and then evaluates
    functionCondition.
%}