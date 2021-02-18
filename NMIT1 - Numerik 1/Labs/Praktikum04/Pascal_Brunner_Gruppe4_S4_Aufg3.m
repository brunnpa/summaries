function Pascal_Brunner_Gruppe4_S4_Aufg3
    format long;
    
    %Plot with tolerence 10^-15;
    [root, xit, n] = Pascal_Brunner_Gruppe4_S4_Aufg2(@(x) (x.^2)-2, 0, 2, 10e-15);
    i = 1:n; 
    subplot(3, 1, 1);
    semilogy(i, xit(i));
    
    %Plot with tolerence 10^-16
    [root2, xit2, n2] = Pascal_Brunner_Gruppe4_S4_Aufg2(@(x) (x.^2)-2, 0, 2, 10e-16);
    j = 1 : n2;
    subplot(3, 1, 2);
    semilogy(j, xit(j));
    
    %Erkenntnisse:
    % tbd
    %
    %
    ary = zeros
    for n3=1:20
        tol = 10.^(-n3);
        fprintf('%15.15f0\n',tol);
        [root3, xit3, someN] = Pascal_Brunner_Gruppe4_S4_Aufg2(@(x) (x.^2)-2, 0, 2, tol);
        ary(n3) = someN;
    end
     
    someX=1:20;
    subplot(3, 1, 3);
    loglog(10.^(-someX),ary(someX));

    
    
    
    




end
