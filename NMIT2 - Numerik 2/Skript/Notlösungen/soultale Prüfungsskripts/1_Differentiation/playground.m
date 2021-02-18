x0 = 1;
h = [10^-2, 10^-4, 10^-6, 10^-8, 10^-10, 10^-15, 10^-16];
f = @(x)sin(x);
[d1f, d1f_table] = D1f(x0, h, f);
[d2f, d2f_table] = D2f(x0, h, f);
[d3f, d3f_table] = D3f(x0, h, f);

fdiff_analyt = @(x)cos(x);
d1f_error = diskret_error(d1f, fdiff_analyt,x0, h);
d2f_error = diskret_error(d2f, fdiff_analyt,x0, h);
d3f_error = diskret_error(d3f, fdiff_analyt,x0, h);

fdiff2 = @(x) -sin(x);

h_opt_D1f = h_optimum_D1f(x0, f, fdiff2, eps);
d1f_opt = D1f(x0, h_opt_D1f , f);
d1f_opt_error = diskret_error(d1f_opt, fdiff_analyt,x0, h_opt_D1f);

h_opt_D2f = h_optimum_D2f(x0, f, fdiff2, eps);
d2f_opt = D2f(x0, h_opt_D2f , f);
d2f_opt_error = diskret_error(d2f_opt, fdiff_analyt,x0, h_opt_D2f);

x0 = [1,2, 100];
f = @(x) x.^4;
fdiff2_analyt = @(x)12.*x.^2
%1=>12 2=>48 100=>120000%
d5f =D5f(x0,h,f);
d5f_error = diskret_error(d5f,fdiff2_analyt,x0, h);

f = @(x) sin(x);
h = [0.1,0.05,0.025,0.0125];
x0 = 1;
dxf1 = @(x,h,f)D1f(x,h,f);
fdiff_analyt = @(x) cos(x);
[D,E,D_table,E_table] = h_extrapolation(x0,h,f,dxf1,fdiff_analyt);
dxf2 = @(x,h,f)D2f(x,h,f);
[D,E,D_table,E_table] = h2_extrapolation(x0,h,f,dxf2,fdiff_analyt);