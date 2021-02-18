function G3_S4_Aufg1b()
    x = logspace(0,2);
    f = 5./(2.*x).^(1/3);
    g = 10.^5 .* (2*exp(1)).^(-x./100);
    h = (10.^(2.*x)./2.^(5.*x)).^2;
    
    subplot(2,2,1);
    loglog(f, x);
    title('f');
    subplot(2,2,2);
    semilogx(g, x);
    title('g');
    subplot(2,2,3);
    semilogx(h, x);
    title('h');
end