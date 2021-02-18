function [xn,n] = linSolveJacobi(A,b,x0,tol,nmax)

m = size(A,1);
xn = 2*tol*ones(size(x0));
n = 1;

while norm(xn-x0,inf)> tol && n < nmax
    x0 = xn;
    
    for i=1:n
        
        sigma=0;
        
        for j=1:i-1
                sigma=sigma+A(i,j)*xn(j);
        end
        
        for j=i+1:n
                sigma=sigma+A(i,j)*x0(j);
        end
        
        xn(i)=(1/A(i,i))*(b(i)-sigma);
    end
    n = n+1;
end

end