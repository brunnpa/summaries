%Schwingung Federpendel
n = 1:1000;
ti = n.*0.1;
%Auslenkung
xi = (10.*exp(1).^(-0.05.*ti)).*cos(0.2.*pi.*ti);
%Geschwindigkeit xi dt
dxi = S1_3a_df_diskret(ti, xi);
dxi2 = S1_3a_df_diskret(ti, dxi);


plot(ti, xi, 'r');
grid minor;
xlabel('Zeit [s]');
ylabel('x [m]');
hold on;
plot(ti, dxi, 'g');
plot(ti, dxi2, 'b');
