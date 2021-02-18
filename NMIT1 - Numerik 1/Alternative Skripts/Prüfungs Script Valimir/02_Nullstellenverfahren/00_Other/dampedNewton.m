function dampedNewton(a, x0, maxit, lambda_min)
q=0.5; 
x0_orig = x0;
for(it=1:maxit)
    f=atan(a*x0); 
    df=a/(1+(a*x0)^2); 
    s= f/df; 
    x1=x0-s; 
    lambda=1; 
    f=atan(a*x1); 
    df=a/(1+(a*x1)^2); 
    st=f/df;

    while norm(st)>(1-lambda/2)*norm(s)
        lambda=q*lambda;
        if(lambda<lambda_min) 
            break; 
        end
        x1=x0-lambda*s; 
        f=atan(a*x1);
        df=a/(1+(a*x1)^2); % tentative simplified Newton corr. 
        st=f/df; 
    end
    if(abs(s)<1e-6)
        plot(x0_orig,a,"*"); 
        hold on; 
        break; 
    end
    
    x0=x1;
end
