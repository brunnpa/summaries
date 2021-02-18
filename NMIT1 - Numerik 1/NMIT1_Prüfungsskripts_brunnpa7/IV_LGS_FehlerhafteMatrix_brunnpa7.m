%Fehlerbehaftete Matrix
% A = A Matrix
% A_schlange = A Matrix inkl Fehler => bei Abweichung von z.B. 100 als
% Parameter A + 100 verwenden
% Falls A kein Fehler hat, einfach nochmals A übergeben
% b = b Vektor
% b_schlange = b Vektor inkl Fehler => bei Abweichung von z.B. 100 als
% Parameter b + 100 verwenden
% Falls b kein Fehler hat, einfach nochmals b übergeben
% norm_type = Norm Typ (1,2 oder inf)
% 
% fehler = max relativer Fehler
%
% BEISPIELAUFRUF:
% A = [20, 30, 10; 10, 17, 6; 2, 3, 2];
% b = [5720; 3300; 836]
% [fehler] = FehlerhafteMatrix(A, A + 100, b, b + 10, inf)
% 

function [fehler] = IV_LGS_FehlerhafteMatrix_brunnpa7(A, A_schlange, b, b_schlange, norm_type)
    if((cond(A, norm_type) * (norm(A-A_schlange, norm_type) / norm(A, norm_type))) >= 1)
       error("Nicht zulässig")
    end
    first_part = cond(A, norm_type) / (1 - cond(A, inf) * ( norm(A - A_schlange, norm_type) / norm(A, norm_type)));
    second_part = (norm(A - A_schlange, norm_type) / norm(A, norm_type)) + (norm(b - b_schlange, norm_type) / norm(b, norm_type));
    
    fehler = first_part * second_part;
end