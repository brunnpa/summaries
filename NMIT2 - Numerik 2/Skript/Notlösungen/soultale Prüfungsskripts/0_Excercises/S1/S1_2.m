clc,clear;
%D1f und D2f für f(x) = ln(x.^2) x0 = 2 mit verschiedenen hs
f = @(x)log(x.^2);
%analytische Ableitungen für Bestimmung optimales h und Fehler
fdf = @(x)2.*(x.^-1);
fdf2 = @(x) -2.*(x.^-2);
fdf3 = @(x) 4.*(x.^3);

x0 = 2;
%h: 10^-1 ... 10^-17
h = ones(1,17).*10.^([1:17].*-1);
disp(h)


d1f = D1f(x0,h,f);
d2f = D2f(x0,h,f);

d1f_err = diskret_error(d1f,fdf,x0,h);
d2f_err = diskret_error(d2f,fdf,x0,h);



formatSpec1 = '%s    %15s       %8s  %12s    %10s\n';
fprintf(formatSpec1, 'h','d1f_err','d2f_err','d1f', 'd2f');

formatSpec2 = '%#1.2E     %1.9f    %1.12f    %1.8f    %1.12f\n';
fprintf(formatSpec2, [h', d1f_err,d2f_err,d1f, d2f].');

%D1ferr bei h = 10^-8 am kleinsten
%D2ferr bei h = 10^-5 am kleinsten

%D1f mit h_opt
h_opt_d1f = h_optimum_D1f(x0,f,fdf2,eps);
d1f_opt= D1f(x0,h_opt_d1f,f);
fprintf('d1f: Optimale Schrittweite h= %#2.15E\n', h_opt_d1f);
fprintf('d1f: Optimale Ableitung = %1.15d\n', d1f_opt);
fprintf('d1f: Minimaler Fehler = %1.15d\n', diskret_error(d1f_opt,fdf,x0,h_opt_d1f));
fprintf('\n');
%D2f mit h_opt
h_opt_d2f = h_optimum_D2f(x0,f,fdf3,eps);
d2f_opt= D2f(x0,h_opt_d2f,f);
fprintf('d2f: Optimale Schrittweite h= %#2.7E\n', h_opt_d2f);
fprintf('d2f: Optimale Ableitung = %1.15d\n', d2f_opt);
fprintf('d2f: Minimaler Fehler = %1.15d\n', diskret_error(d2f_opt,fdf,x0,h_opt_d2f));
fprintf('\n');