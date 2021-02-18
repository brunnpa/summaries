function [diff4]    =   diff4(f)
% Berechnet die 1. Ableitung einer differenzierbaren Funktion
%
% f:    Funktion die abgeleitet werden soll
% var:  Variable, nach der abgeleitet werden soll

syms x;

diff4 = matlabFunction(diff(f, x, 4));