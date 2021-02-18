function Berg_Michael_Gruppe2_S4_Aufg1()

    % AUFGABE A)
    
    % earth radius [m]
    R_0 = 6378137;
    
    % earth mass [kg]
    M = 5.976*10^24;
    
    % gravitational const [Nm^2kg^-2]
    G = 6.673*10^-11;
    
    % tabular values for height, mass in relation to time
    %
    h = [2 286 1268 3009 5375 8220 11505 15407 20127 25593 31672 38257 44931];
    
    m = [2051113 1935155 1799290 1681120 1567611 1475282 1376301 1277921 1177704 1075683 991872 913254 880377];
    
    t = [0 10 20 30 40 50 60 70 80 90 100 110 120];
    
    % change in height in relation to change in time
    v_t = Berg_Michael_It17tb_ZH_S1_Auf3a(t,h);
    
    % change in velocity in relation to change in time
    a_t = Berg_Michael_It17tb_ZH_S1_Auf3a(t,v_t);
    
    % change in mass in relation to change in time
    m_t = Berg_Michael_It17tb_ZH_S1_Auf3a(t,m);
    
    % change in mass in relation to change in height
    m_h = Berg_Michael_It17tb_ZH_S1_Auf3a(h,m);
    
    %Plots
    figure('Name','Aufgabe 1a','NumberTitle','off');
    subplot(4,2,1);
    plot(t,h);
    title('h(t)');
    subplot(4,2,2);
    plot(t,v_t);
    title('v(t)');
    subplot(4,2,3);
    plot(t,a_t);
    title('a(t)');
    subplot(4,2,4);
    plot(t,m);
    title('m(t)');
    subplot(4,2,5);
    plot(t,m_t);
    title('dm/dt(t)');
    subplot(4,2,6);
    plot(t,m_h);
    title('dm/dh(h)');
    subplot(4,2,7);
    plot(t,m_t);
    title('dm/dt(t) =');
    subplot(4,2,8);
    plot(t,m_h.*v_t);
    title('= dm/dh(h) * v(t)');
    
    
    % AUFGABE B)
    h_R0 = h;
    m_div_hsqr = [];
    
    for i = 1 : length(h)
        h_R0(i) = h_R0(i) + R_0;
        m_div_hsqr(i) = m(i)/h(i)^2; 
    end
    

    
    for i = 1 : length(h_R0)
           E_kin(i) = Berg_Michael_Gruppe2_S3_Aufg4a(h_R0, m_t.*v_t,i) + Berg_Michael_Gruppe2_S3_Aufg4a(h_R0, m.*a_t,i);
           E_pot(i) = G*M*Berg_Michael_Gruppe2_S3_Aufg4a(h_R0, m_div_hsqr,i);
           E(i) = E_kin(i) + E_pot(i);
    end
    
    disp(E_kin)
    disp(E_pot)
    disp(E)
    
    figure('Name','Aufgabe 1b','NumberTitle','off');
    subplot(4,2,1);
    plot(t,E_kin);
    title('E_kin');
    subplot(4,2,2);
    plot(t,E_pot);
    title('E_pot');
    subplot(4,2,3);
    plot(t,E);
    title('E');
    
    % AUFGABE C)
    
    CH_Haushalt = E(13) / 10^10;
    disp(CH_Haushalt)
end

