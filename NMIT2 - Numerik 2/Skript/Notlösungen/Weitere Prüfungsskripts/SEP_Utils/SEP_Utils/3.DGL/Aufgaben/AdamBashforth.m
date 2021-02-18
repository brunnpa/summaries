%% Anfangswert Problem mit Adam Bashford Lösen

% Definieren der Variablen
y0 = 1;
f = @(x,y) y;
a = 0;
b = 1;
yexact = @(x) exp(x);
%% Aufgabe a,b

for i = 1:8
    n(i) = 10^i;
    
    % Adams-Bashforth
    tic;
    [x_adams,yab4_adams] = IT15ta_ZH08_S7_Aufg2(f,a,b,n(i),y0);
    t_adams(i) = toc;
    glob_err_Adams(i) = abs(yexact(x_adams(length(x_adams))) - yab4_adams(length(yab4_adams)));

    % Runge-Kutta 
    tic
    [x_runge,y_runge] = IT15ta_ZH08_S6_Aufg1(f,a,b,n(i),y0);
    t_RK(i) = toc;
    glob_err_RK(i) = abs(yexact(x_runge(length(x_runge))) - y_runge(length(y_runge)));
end 

subplot(2,1,1);
loglog(n,glob_err_Adams,n,glob_err_RK);
title('Globaler Fehler');
xlabel('n');
ylabel('Fehler');
legend('globaler Fehler Adams-Bashforth','globaler Fehler Runge Kutta');

subplot(2,1,2);
semilogx(n,t_adams,n,t_RK);
title('Laufzeit');  
xlabel('n');
ylabel('Laufzeit');
legend('Laufzeit Adams-Bashforth','Laufzeit Runge Kutta');

%% Aufgabe c
fprintf('Das Adams-Bashforth Verfahren ist hinsichtlich der Laufzeit und des globalen Fehlers besser als das Runge-Kutta Verfahren');
