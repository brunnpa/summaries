% Abgabe Gruppe 4 - IT17tb_ZH
% David Luescher, Anasstatios Martakos, Pascal Brunner
% Funktionsaufruf:
% [root, xit, n] = Pascal_Brunner_Gruppe4_S4_Aufg2(@(x) sin(x).*cos(x), -1, 1, 0.1)

function [root, xint, n] = Pascal_Brunner_Gruppe4_S4_Aufg2 (func, a, b, tol)
    %initilaze variables
    format long;
    n = 1; %MatLab array beginns with 1
    
    %condition for terminate
    nMax = 10000;
    
    %prerequisite
    %f(a) * f(b) < 0 
    if(func(a) * func(b) >= 0)
       error('Thats not a valid input -> it has to be: f(a) * f(b) < 0');
    end
    
    %condition
    if tol <= 0
       error('tolerence has to be bigger than 0');
    end
    
    %do "Bisektionsverfahren"
    while(1)
        %checks if n is bigger than nMax, 
        % if so -> terminate
        if n >= nMax
          error('too many steps needed - terminated!'); 
        end
       
        %checks whether the tolerance is more accurate than necessary,
        % if so -> terminate
        if(abs(b-a) <= tol) 
            root = a_b;
            return
        end
       
        %calculate new values
        a_b = (a + b) / 2;
        
        %save new result
        xint(n) = func(a_b);
        
        %check next step
        if(func(a)*func(a_b) <= 0)
            b = a_b; %[(a+b)/2, b]
        else
            a = a_b; %[a, (a+b)/2]
        end
        n = n + 1;
    end
end