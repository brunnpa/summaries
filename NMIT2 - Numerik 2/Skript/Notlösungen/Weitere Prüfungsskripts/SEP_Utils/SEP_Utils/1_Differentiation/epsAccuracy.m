function [eps]  =   epsAccuracy(basis, exp)
% Berechnet die Maschinengenauigkeit
% aus gegebener Basis und Exponenten
%
% basis:    Basis des Zahlensystemes
% exp:      Exponent

eps = basis ^(-exp);
