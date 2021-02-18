clc;
clear;
% Dichte aus tabelle errechnen.
% Die Dichte ro der Erde variiert mit dem Radius r gemäss der folgenden Tabelle, 
% in der die Abstände in r nicht äquidistant sind (aus [9])



% Gegeben:
% x:     x werte
% y:    f(x) werte
% a:    intervall
% b:    oberes intervall
r = [0, 800, 1200, 1400, 2000, 3000, 3400, 3600, 4000, 5000, 5500, 6370];
rho = [13000, 12900, 12700, 12000, 11650, 10600, 9900, 5500, 5300, 4750, 4500, 3300];

a   = 0;
b   = 6370;

% a) Itf

% 1) Tabelle aufstellen
r = [0, 800, 1200, 1400, 2000, 3000, 3400, 3600, 4000, 5000, 5500, 6370];
rho = [13000, 12900, 12700, 12000, 11650, 10600, 9900, 5500, 5300, 4750, 4500, 3300];
% 2) Umrechnen r_km in r_meter
r_meter = r .* 1000;
% 3) Formel für Masse aufsetzen (diesmal nicht symbolisch da konkrete Werte
% vorliegen).
% ! x = radius in meter
% ! y = mdr, da die masse von r abhängt
% ! gesamtmasse ist das Integral der tabelarischen läsung
mdr = rho * 4 * pi .* r_meter.^2;
MErde   = TfNeq(r_meter, mdr);

% Masse Erwartungswert
m_exp       = 5.972 * 10^24;
abs_error   = abs(MErde - m_exp);
rel_error   = abs_error / m_exp;

fprintf('Berechnete Erdmasse: %0.6d\n', MErde);
fprintf('Absoluter Fehler: %0.6d\n', abs(MErde - m_exp));
fprintf('Relativer Fehler: %0.6d\n', abs(MErde-m_exp) / abs(m_exp));


