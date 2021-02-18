% Ueberprueft ob fixpunktiteration gueltig ist nach banachscher fixpunktsatz.
% verlang fixpunktgleichung, deren ableitung und ein interval [a b] sowie 
% incrementor fuer die steps des intervals

% f: Fixpunktgleichung F(x)
% fStrich: Ableitung der Fixpunktgleichung F'(x)
% a, b: Intervall [a, b]
% schrittGroesse: Incrementor f?r Steps zwischen Intervall [a, b]

% gueltig: 1 (true), wenn alpha < 1 und bildet_auf_sich = 1 (true)
% selbstabbild: 1 (true), wenn F: [a,b] --> [a,b] (F bildet [a,b] auf sich selber ab)
% alpha: (Lipschitz-)Konstante

% Example from S5A1:
% [gueltig, selbstabbild, alpha] = III_Nullstellen_BanachFixpunktCheck_brunnpa7(@(x) (230*x.^4 + 18*x.^3 + 9*x.^2 - 9) / 221, @(x) (920*x.^3 + 54*x.^2 + 18*x) / 221, -0.5, 0.5, 0.5)
function [gueltig, selbstabbild, alpha] = III_Nullstellen_BanachFixpunktCheck_brunnpa7(f, fStrich, a, b, schrittGroesse)
  x_values = a:schrittGroesse:b;
  selbstabbild = 0;
  gueltig = 0;

  y = arrayfun(f, x_values);
  dfy = arrayfun(fStrich, x_values);
  alpha = max(dfy);
  
  if(max(y) <= max(x_values))
    selbstabbild = 1;
  end
  if(alpha < 1 && selbstabbild == 1)
    gueltig = 1;
   end
 end