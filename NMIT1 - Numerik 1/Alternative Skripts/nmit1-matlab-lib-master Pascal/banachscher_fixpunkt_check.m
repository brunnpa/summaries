% Ueberprueft ob fixpunktiteration gueltig ist nach banachscher fixpunktsatz.
% verlang fixpunktgleichung, deren ableitung und ein interval [a b] sowie 
% incrementor fuer die steps des intervals

% func_x: Fixpunktgleichung F(x)
% df_x: Ableitung der Fixpunktgleichung F'(x)
% a, b: Intervall [a, b]
% incr_steps: Incrementor fï¿½r Steps zwischen Intervall [a, b]

% is_valid: 1 (true), wenn alpha < 1 und bildet_auf_sich = 1 (true)
% bildet_auf_sich: 1 (true), wenn F: [a,b] --> [a,b] (F bildet [a,b] auf sich selber ab)
% alpha: (Lipschitz-)Konstante

% Example from S5A1:
% [is_valid, bildet_auf_sich, alpha] = banachscher_fixpunkt_check(@(x) (230*x.^4 + 18*x.^3 + 9*x.^2 - 9) / 221, @(x) (920*x.^3 + 54*x.^2 + 18*x) / 221, -0.5, 0.5, 0.5)
function [is_valid, bildet_auf_sich, alpha] = banachscher_fixpunkt_check(func_x, df_x, a, b, incr_steps)
  x_values = a:incr_steps:b;
  bildet_auf_sich = 0;
  is_valid = 0;

  % Werte der Fixpunktiteration an sich.
  y = arrayfun(func_x, x_values);
  
  % Für alpha:
  % alpha = Grösstmögliche Steigung der Fixpunktfunktion
  % => Maximalwert in Interval [a b] der Ableitung (hier: dfy)
  dfy = arrayfun(df_x, x_values);
  alpha = max(dfy);
  
  % Voraussetung 1
  if(max(y) <= max(x_values))
    bildet_auf_sich = 1;
  end
  % Voraussetung 2
  if(alpha < 1 && bildet_auf_sich == 1)
    is_valid = 1;
  end
 end
