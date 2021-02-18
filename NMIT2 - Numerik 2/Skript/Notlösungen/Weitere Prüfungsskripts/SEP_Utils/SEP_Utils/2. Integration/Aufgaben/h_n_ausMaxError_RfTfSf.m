% Wie gross ist die Schrittweite h bzw. die Anzahl benötigter 
% Subintervalle n, um das Integral auf einen Fehler von
% maximal 10^-5 genau berechnen zu können
% für die summierten Rechteck / Trapez /Simpsonregeln?

% 1) 4x Ableiten
% 2) Intervall aufteilen in 0.01 x werte (+ Hilfsvariablen)
%                                           a       =   1;
%                                           b       =   2;
%                                           max_err =   10.^-5;
%         Eigentliche Aufteilung  =>        x       = [a:0.01:b];
% 3) y Werte für Ableitungen berechnen
%         R  2. Ableitung(x)                y_fDiff2 = abs(fDiff2(x));
%         T: 2. Ableitung(x)                y_fDiff2 = abs(fDiff2(x));
%         S: 4. Ableitung(x)                y_fDiff4 = abs(fDiff4(x));
% 4) Maximum der y_diff werte berechnen    
%         R:                                max_y_fDiff2 = max(y_fDiff2);
%         T:                                max_y_fDiff2 = max(y_fDiff2);;
%         S:                                max_y_fDiff4 = max(y_fDiff4);
% 5) Schrittweite h_xf berechnen
%         R                                 h_rf = sqrt((24.*max_err)./((b-a)*max_y_fDiff2));
%         T:                                h_tf = sqrt((12.*max_err)./((b-a)*max_y_fDiff2));
%         S:                                h_sf = ((2880.*max_err)./((b-a)*max_y_fDiff4))^(1/4);
% 6) Subintervall Anzal n_xf berechnen
%         R                                 n_rf = ceil((b-a)/h_rf);
%         T:                                n_tf = ceil((b-a)/h_tf);
%         S:                                n_sf = ceil((b-a)/h_sf);
% 7) Fehler der Verfahren berechnen
%         R                                 err_rf_calc = RfErr(a, b, h_rf, f, 0.01);
%         T:                                err_tf_calc = TfErr(a, b, h_tf, f, 0.01);
%         S:                                err_sf_calc = SfErr(a, b, h_sf, f, 0.01);
% 8) Sicherstellen dass kalkulierter
%    Fehler unter Verfahrensfehler liegt
%         R                                 assert(err_rf_calc < max_err);
%         T:                                assert(err_tf_calc < max_err);
%         S:                                assert(err_sf_calc < max_err);


% ---------------------
%       Serie 3
%       Aufg. 1 auch manuell vorhanden
% ---------------------
% Gegeben:
% f(x)      =   log(x.^2)
% a         =   1
% b         =   2
% max_err   =   10^(-5)
clc;
clear;
% 1) Funktion angeben und ableiten
f       =   @(x) log(x.^2);
fDiff1  =   diff1(f);
fDiff2  =   diff2(f);
fDiff3  =   diff3(f);
fDiff4  =   diff4(f);

% 2) Intervall aufteile (+ Hilfsvariablen)
a       =   1;
b       =   2;
max_err =   10.^-5;
x       =   [a:0.01:b];

% 3) y Werte für Ableitungen berechnen
y_fDiff2 = abs(fDiff2(x));
y_fDiff4 = abs(fDiff4(x));

% 4) Maximum der y_diff werte berechnen
max_y_fDiff2 = max(y_fDiff2);
max_y_fDiff4 = max(y_fDiff4);

% 5) Schrittweite h_xf berechnen
h_rf    = sqrt((24.*max_err)./((b-a)*max_y_fDiff2));
h_tf    = sqrt((12.*max_err)./((b-a)*max_y_fDiff2));
h_sf    = ((2880.*max_err)./((b-a)*max_y_fDiff4))^(1/4);

% 6) Subintervall Anzal n_xf berechnen
n_rf    = ceil((b-a)/h_rf);
n_tf    = ceil((b-a)/h_tf);
n_sf    = ceil((b-a)/h_sf);

% 7) Fehler der Verfahren berechnen
err_rf_calc = RfErr(a, b, h_rf, f, 0.01);
err_tf_calc = TfErr(a, b, h_tf, f, 0.01);
err_sf_calc = SfErr(a, b, h_sf, f, 0.01);

%err_rf_calc = Rf_error(a, b, h_rf, fDiff2, 0.01);
%err_tf_calc = Tf_error(a, b, h_tf, fDiff2, 0.01);
%err_sf_calc = Sf_error(a, b, h_sf, fDiff4, 0.01);

% 8) Sicherstellen dass kalkulierter
%    Fehler unter Verfahrensfehler liegt
assert(err_rf_calc < max_err);
assert(err_tf_calc < max_err);
assert(err_sf_calc < max_err);













