function [diff1]    =   diff1(f)
% Berechnet die 1. Ableitung einer differenzierbaren Funktion
%
% f:    Funktion die abgeleitet werden soll
% var:  Variable, nach der abgeleitet werden soll

syms x;

diff1 = matlabFunction(diff(f(x)));