%Abgabe Gruppe4

function Pascal_Brunner_Gruppe4_S4_Aufg1
       x = 0:10^-3:100;
       
       %Function f(x)
       fx = 5 .* ((2.* x.^2) .^(- 1 ./ 3));
       subplot(3,1,1);
       loglog(x, fx);
       
       %Function g(x)
       gx = 10^5 .* (2*exp(1)) .^ (-x / 100);
       subplot(3, 1, 2);
       semilogy(x, gx);
       
       %Function h(x)
       hx = ((10.^(2.*x))./(2.^(5.*x))).^2;
       subplot(3, 1, 3);
       semilogy(x, hx);
end
