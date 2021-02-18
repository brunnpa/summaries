clear, clf;
%Frequenz
v0 = 200;
dt = 1./(44.1*10^3);
t = 0:dt:0.005;
%Signmal
f = @(t) sin(2.*pi.*v0.*t)+0.5.*sin(2.*pi.*4.*v0.*t)+...
    0.8.*cos(2.*pi.*2.*v0.*t)+0.4.*cos(2.*pi.*12.*v0.*t);

plot(t,f(t));
legend('Signal f');
xlabel('t[s]');