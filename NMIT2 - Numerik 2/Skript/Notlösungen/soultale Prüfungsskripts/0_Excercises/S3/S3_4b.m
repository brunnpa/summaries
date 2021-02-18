clc, clf, clear;
r = [0, 800, 1200, 1400, 2000, 3000, 3400, 3600, 4000, 5000, 5500, 6370];
rho = [13000, 12900, 12700, 12000, 11650, 10600, 9900, 5500, 5300, 4750, 4500, 3300];
r_meter = r .* 1000;
mdr = 4.*pi.*rho.*(r_meter.^2);
%Masse Erde: 5.972 ? 10^24 kg
m_exp = 5.976 .* 10^24;
m =Tf_neq(r_meter,mdr);
abs_error = abs(m-m_exp);
%rel err: 0.9%
rel_error = abs_error/m_exp;