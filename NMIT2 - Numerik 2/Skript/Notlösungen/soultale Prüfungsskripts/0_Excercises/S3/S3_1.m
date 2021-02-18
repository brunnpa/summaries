%Berechne das Integral ln(x^2) von a=1 bis b=2 mit
%maximalem Fehler von 10^-5 
%=> bei Rf wähle Schrittgrösse h_St
%=> bei Tf wähle Schrittgrösse h_Tt
%=> bei Sf wähle Schrittgrösse s_St

%Rf - Rechtecksregel
max_err = 10.^-5;
a = 1;
b = 2;
fdiff = @(x) 2./x;
fdiff2 = @(x) -2.*(x.^-2);
x = [a:0.01:b];
y_fdiff2 = abs(fdiff2(x));
max_y_fdiff2 = max(y);
h_rf = sqrt((24.*max_err)./((b-a)*max_y_fdiff2));
n_rf = ceil((b-a)/h_rf);
err_rf_calc = Rf_error(a, b, h_rf, fdiff2, 0.01)
assert(err_rf_calc < max_err);
%Tf - Trapze Regel
h_tf= sqrt((12.*max_err)./((b-a)*max_y_fdiff2));
n_tf = ceil((b-a)/h_tf);
err_tf_calc = Rf_error(a, b, h_tf, fdiff2, 0.01)
assert(err_tf_calc < max_err);
%Sf _ Simpson-Regel
fdiff2 = @(x) -2.*(x.^-2);
fdiff3 = @(x) 4.*(x.^-3);
fdiff4 = @(x) -12.*(x.^-4);
x = [a:0.01:b];
y_fdiff4 = abs(fdiff4(x));
max_y_fdiff4 = max(y_fdiff4 );
h_sf= ((2880.*max_err)./((b-a)*max_y_fdiff4))^(1/4);
n_sf = ceil((b-a)/h_sf);
err_sf_calc = Sf_error(a, b, h_tf, fdiff4, 0.01)
assert(err_sf_calc < max_err);

