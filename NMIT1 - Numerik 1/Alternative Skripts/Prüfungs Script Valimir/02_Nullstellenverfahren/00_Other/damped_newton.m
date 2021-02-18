function[x,info] = damped_newton(fct,x,par)

%funktion[x, info]=newton(fct,x,par)
%Lösung des nichtlinearen Gleichung f(x)=0
%mit gedämpften Newton-Verfahren
%
%fct: Name von der Funktion [f,df]=fct(x)
% Auswerten von f und Jacobi Matrix df
%x: Startvektor und Lösung
% par.tol: Toleranz
%par.nit:Maximaleanzahl von Iterationen
%par.step:minimale Dämpfungsfaktor
%info.msg: Fehlermeldung
%info.it:Anzahl der Iterationen
% info.err: Norm von f(x)

%Vorgaben
if ~exist('par');
par=struct('tol',[],'nit',[],'step',[]);
end;
if isempty(par.tol);
par.tol=10^(-10)
end;
if isempty(par.nit);
par.nit=50;
end;
if isempty(par.step);
par.step=1/512;
end;
%Initialiseirung
t=1;
x_doku=[];
for k=1:par.nit;
[f,df]=feval(fct,x);

%Konvegenztest
info.err=norm(f,inf);
if info.err<=k;
return;
end;

%Berechunug von Schritweite
[Q,R]=qr(df);
if min(abs(diag(R)))<par.tol*norm(R,inf);
info.msg='Singülere Jacobi Matrix';
return;
end;
dx=rsolve(R,Q'*f);

%Überprüfung von Schrittweite und Dämpfung
flag_t=0;
while t > par.step;
y =x-t*dx;
g=feval(fct,y);
dy=rsolve(R,Q'*g);
if norm(dy,inf)<= (1-t/2)*norm(dx,inf);
x=y;
if flag_t==0;
t=min(1,2*t);
end;
break;
else
t=t/2;
flag_t=1;
end;
end;
if t<=par.step;
info.msg='Dämpfungsffaktor zu klein';
return;
end;
end;
info.msg='maximale Anzahl der Iterationen überschriten';

function d = rsolve(R,f)
%Lösen von der Obere Dreiecksmatrix
n=length(f);
d=[zeros(n-1,1);f(n)/R(n,n)];
for k=n-1:-1:1;
d(k)=(f(k)-R(k,k+1:n))/R(k,k);
end;