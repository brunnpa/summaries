function [diff3]    =   diff3(f)
% Berechnet die 1. Ableitung einer differenzierbaren Funktion
%
% f:    Funktion die abgeleitet werden soll
% var:  Variable, nach der abgeleitet werden soll

syms x;

diff3 = matlabFunction(diff(f, x, 3));