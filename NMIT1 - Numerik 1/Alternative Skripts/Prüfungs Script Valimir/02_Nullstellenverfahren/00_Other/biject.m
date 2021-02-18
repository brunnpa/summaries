% Funktion biject(f,a,b,tol)
% Implementierung des Bijektionsverfahrens mit einem iterativen Algorithmus.
% Das Verfahren berechnet auf numerische Weise die Nullstelle einer
% stetigen Funktion in einem gegebenen Intervall, vorausgesetzt 
% der Nullstellensatz von Bolzano sagt eine Nullstelle innerhalb des
% Intervalls voraus.
%
% Paramter:
% f - Handle einer anonymen Matlab-Funktion
% a - linke Intervallgrenze
% b - rechte Intervallgrenze
% tol - Toleranz
%
% Die Funktion hat 3 Rückgabewerte : root,xit,n
% root ist die approximierte Nullstele.
% xit enthält die Näherungswerte für die gesuchte Nullstelle.
% n speichert die Anzahl Iterationen.
% Beispiel eines Funktionsaufrufes:
% [root,xit,n] = biject(@(x) cos(x).*sin(x),1,pi,1e-6)

function[root,xit,n] = biject(f,a,b,tol)

clc;
xit =[];
n = 0;
MAX_ITERATIONS = 100;

if (nargin == 4)
    if (f(a)*f(b) >= 0)
        disp('The function has positive value at the end points of interval.');
        disp('The root can''t be found using bisection method, use some other method.');
        root = 'Root can''t be found using bisection method';
        return;
    else
        fprintf('Iteration\t\t\ta\t\t\tb\t\t\tp\t\t\tf(a)\t\t\tf(b)\t\t\tf(p)\n');
        fprintf('=========\t\t ======\t\t ======\t\t ======\t\t   ======\t\t   ======\t\t   ======\n');
        p = (a + b)/2;
        if (abs(f(p)) <= tol)
            root = p;
            return;
        else
            while (abs(f(p)) >= tol && n < MAX_ITERATIONS)
                n = n + 1; 
                p = (a + b)/2;
                if (f(a)*f(p) > 0)
                    a = p;
                else
                    b = p;
                end
                fprintf('%3d',n);
                fprintf('%20.4f',a);
                fprintf('%12.4f',b);
                fprintf('%12.4f',p);
                fprintf('%14.4f',f(a));
                fprintf('%16.4f',f(b));
                fprintf('%16.4f',f(p));
                fprintf('\n');
                xit = [xit p];
            end
            root = p;
        end
    end
else
     error('Wrong number of input arguments.');
end

end