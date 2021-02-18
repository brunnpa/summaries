function [root,xit,n] = G3_S4_Aufg2(func,a,b,tol)
format long;

root = 0;
xit = [];
n=0;

if(func(b)*func(a)<0)
    while(abs(a-b)>tol)
        n=n+1;
        if(func((a+b)/2)*func(a)>0)
        a=(a+b)/2;
        xit= [xit; a];
        else
        b=(a+b)/2;
        xit= [xit; b];
        end
    end
    root=(a+b)/2;
end