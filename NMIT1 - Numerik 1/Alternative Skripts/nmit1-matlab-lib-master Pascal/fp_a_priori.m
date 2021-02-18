% a-priori Abschätzung bei Fixpunktiteration

% deviation: Abweichung
% x0: Startwert x0
% x1: Startwert x1
% alpha: (Lipschitz-)Konstante des Banachschen Fixpunktsatzes

% n: Anzahl Iterationen

% Example from S5A1 c):
% [n] = fp_a_priori(10^-9, 0, -(9/221), 0.6222)
function [n] = fp_a_priori(deviation, x0, x1, alpha)
  format long;
  n = log(deviation * (1 - alpha) / abs(x1 - x0)) /log(alpha);
end
