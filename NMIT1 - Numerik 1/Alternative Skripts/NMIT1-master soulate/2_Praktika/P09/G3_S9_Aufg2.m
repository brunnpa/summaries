%Bsp:
%A=[20000, 30000, 10000; 10000, 17000, 6000; 2000, 3000, 2000]
%b=[5720000;3300000;836000]
%As=A-100
%bS=b+10000
%[x, xS, dxMax, dxObs] = G3_S9_Aufg2(A, As, b, bS)
function [x, xS, dxMax, dxObs] = G3_S9_Aufg2(A, As, b, bS)

x = A \ b;
xS = As \ bS;

bedingung = cond(A, inf) * norm(A-As, inf)/norm(A, inf);
if(bedingung < 1)
    dxMax = cond(A, inf) / (1 - cond(A, inf) * norm(A-As, inf)/norm(A, inf)) * (norm(A-As, inf)/norm(A, inf) + norm(b-bS, inf)/norm(b, inf));
else
    dxMax = NaN;
end
dxObs = norm(x-xS, inf) / norm(x, inf);