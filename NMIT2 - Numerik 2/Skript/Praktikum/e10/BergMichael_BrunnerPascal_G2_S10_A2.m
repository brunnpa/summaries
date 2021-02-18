% Nat?rliche kubische Splinefunktion

% Test:
% BergMichael_BrunnerPascal_G2_S10_A2([ 0 1 2 3 ],[ 2 1 2 2 ],[ 0.5 0.8 1.1 2.2])

% x = Vektor mit den (n + 1) gegebenen St?tzstellen (aufsteigend sortiert)
% y =  analoge Vektor mit den bekannten St?tzwerten
% xx = die Werte, f?r die die die y-Werte (yy) berechnet werden sollen

function [yy] = BergMichael_BrunnerPascal_G2_S10_A2(x,y,xx)
    n=length(x)-1;
    yy=zeros(length(xx),1);
    ai=zeros(n+1,1);
    bi=zeros(n,1);
    ci=zeros(n+1,1);
    di=zeros(n,1);
    hi=zeros(n,1);
    ci(1)=0;
    ci(n+1)=0;
    A=zeros(n-1,n-1);
    z=zeros(n-1,1);
    
    ai(1)= y(1);
    for i=1:n
        ai(i+1)=y(i+1);
        hi(i)=x(i+1)-x(i);
        
        if i==2
            A(i-1,1)=2*(hi(1)+hi(2));
            A(i-1,2)=hi(2);
            z(i-1)=3*(y(3)-y(2))/hi(2)-3*(y(2)-y(1))/hi(1);
        end
        
        if n>=4 && i>=3 && i<=n-1
            A(i-1,i-2)=hi(i-1);
            A(i-1,i-1)=2*(hi(i-1)+hi(i));
            A(i-1,i)=hi(i);
            z(i-1)=3*(y(i+1)-y(i))/hi(i)-3*(y(i)-y(i-1))/hi(i-1);
        end
        
        if i==n
            A(i-1,n-2)=hi(n-1);
            A(i-1,n-1)=2*(hi(n-1)+hi(n));
            z(i-1)=3*(y(n+1)-y(n))/hi(n)-3*(y(n)-y(n-1))/hi(n-1);
        end        
    end
    
    k=A\z;
    
    for i=1:n-1
        ci(i+1)=k(i);
    end
    
    
    for i=1:n
        bi(i)=(y(i+1)-y(i))/hi(i)-hi(i)/3*(ci(i+1)+2*ci(i));
        di(i)=1/3/hi(i)*(ci(i+1)-ci(i));
        r=find(x(i)<=xx&xx<=x(i+1));
        S=@(xx) polyval([di(i) ci(i) bi(i) ai(i)],xx-x(i));
        yy(r)=S(xx(r));
    end
    
    
    % Ausgabe
    %i=(0:n)';
    %T = table(i,ai,ci,yy)
    
    %i=(0:n-1)';
    %T = table(i,hi,bi, di)
    
end