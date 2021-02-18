% Matrix definieren
A = [10^-5,10^-5; 2, 3];

%A =
%
%       1/100000       1/100000
%       2              3       


% quadrat-wurzel
sqrt(3);

% wurzel , (die 5. wurzel von 3)
nthroot(3,5);

% ausgabenformat ändern - in Bruch
format rat 

% e^2
exp(2)

% logarithmus in matlab
% log(x) = ln(x) same same!!!
% Y = log(X) returns the natural logarithm ln(x) of each element in array X.

% rechnen mit variablen in matlab
syms a %definiert eine symbolische variabel a 
A = [ 30, 10 ,5 ; 10, a, 20; 5 ,20 ,50] 
D = diag(diag(A));
Inverse = inv(D);

% R = Obere Dreiecksmatrix von A 
triu(A)

% L = Untere Dreiecksmatrix von A
tril(A)
