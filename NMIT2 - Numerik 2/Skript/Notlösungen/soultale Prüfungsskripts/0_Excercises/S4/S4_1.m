%1a
% Zeit in Sekunden
t = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120];
% Hoehe in Metern
h = [2, 286, 1268, 3009, 5357, 8220, 11505, 15407, 20127, 25593, 31672, 38527, 44931];
% Masse in Kg
m = [2051113, 1935155, 1799290, 1681120, 1567611, 1475282, 1376301, 1277921, 1177704, 1075683, 991872, 913254, 880377];

%Geschwindigkeit v: dvdt
v = S1_3a_df_diskret(t,h);
%Beschleunigung a: dvda
a = S1_3a_df_diskret(t,v);
%Massenänderung pro zeit: dmdt
dmdt = S1_3a_df_diskret(t,m);
%Massenänderung pro Höhe: dmdh
dmdh = S1_3a_df_diskret(h,m);

figure('Name', 'Aufgabe 1');

subplot(4,2,1);
plot(t, h);
grid minor;
xlabel('t [s]');
ylabel('h [m]');
xlim ([0,120]);

subplot(4,2,3);
plot(t,v); 
grid minor; 
xlabel('t [s]');
xlim ([0,120]);
ylabel('v [m/s]');

subplot(4,2,5);
plot(t,a);
grid minor;
xlabel('t [s]');
xlim ([0,120]);
ylabel('a [m/s^2]');

subplot(4,2,2);
plot(t, m);
grid minor;
xlabel('t [s]');
ylabel('m [kg]');
xlim ([0,120]);

subplot(4,2,4);
plot(t, dmdt);
grid minor;
xlabel('t [s]');
ylabel('change of mass [kg/s]');
xlim ([0,120]);

subplot(4,2,6);
plot(t, dmdh);
grid minor;
xlabel('h [m]');
ylabel('change of height [kg/m]');
xlim ([0,120]);

subplot(4,2,7);
dmdt2 = dmdh .* v;
plot(t,dmdt2, 'r');
hold on;
plot(t,dmdt, '--g')
xlabel('t [s]');
ylabel('change of mass [kg/s]');
grid minor;
xlim ([0,120]);

%1b
G = 6.673e-11;
M = 5.976e24;
R0 = 6378137;

% kin einergie: integral dmdt * v von R0 bis R0 + h
% zum zeitpunkt t auf höhe h: 
h_tot = R0 + h;
Ekin_1 = dmdt.*v;
Ekin_2 = m.*a; 
Epot_1 = m./(h_tot.^2);
Ekin = @(t) Tf_neq(h_tot(1:t),Ekin_1(1:t)) + Tf_neq(h_tot(1:t),Ekin_2(1:t))
Epot = @(t) G*M*Tf_neq(h_tot(1:t),Epot_1(1:t));

E = @(t) Ekin(t) + Epot(t);

n = size(t,2);
for i=1:n
    Ekin_arr(i)=Ekin(i);
    Epot_arr(i)=Epot(i);
    Etotal_arr(i) = Ekin(i) + Epot(i);
end


figure();
plot(t, Ekin_arr, 'red')
hold on
plot(t, Epot_arr, 'blue')
plot(t, Etotal_arr, 'green')
legend('Ekin','Epot','Etotal');
xlabel('time [s]');
ylabel('energy [J]');

% 1c
haushalte = (Etotal_arr(n)/(10^10))
gerundet = floor(haushalte)
disp('max(Etot) / 10^10 J=> 6.3165e11 / 1e10 = 63.1650 = 63 Haushalte');
disp('=> 63 Haushalte k?nnen mit der nach t = 120s verbrauchten Energie, ein Jahr versorgt werden.');