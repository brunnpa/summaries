% x1=1;
% x2=2;
% 
% syms x1 x2
% jacobian([5*x1*x2; x1^2 * x2^2 + x1 + 2*x2], [x1,x2]);

syms x1 x2 x3
aufg2 = jacobian([log(x1^2 + x2^2)+x3^2; exp(x2^2+x3^2)+x1^2; 1/(x3^2 + x1^2) + x2^2], [x1,x2, x3]);
aufg2

syms x1 x2 x3 x4
aufg3 = jacobian([cos(x1)*sin(x2*x3);cos(x2)*sin(x3*x4); cos(x3)*sin(x4*x1);cos(x4)*sin(x1*x2)], [x1,x2,x3,x4]);
aufg3