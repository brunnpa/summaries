% Rechnet eine beliebige Zahl Basis <=10 in eine Dezimalzahl um
% 
% PARAMETER:
% var = Zahl als character String
% base = Basis als int
%
% RETURN:
% die Dezimalzahl
%
% SAMPLE:
% var_to_dec('1011101.01011',2)
% var_to_dec('52015.05123',6)
% var_to_dec('72514',8)
function [decimalNumber] = var_to_dec(var, base)

charStr = char(var);
if(charStr(1) == '-')
    error('negative numbers not allowed');
end

splittedInput = split(var, ".");
sizeOfArray = size(splittedInput);
if (sizeOfArray(1) > 1)
    preComma = splittedInput(1);
    preComma = char(preComma);
    postComma = splittedInput(2);
    postComma = char(postComma)
else
    preComma = var;
    preComma = char(var);
end

dec = 0;

if (base ~= 10)   
    for i = 1 : length(preComma)
        dec = dec + str2num(preComma(i)) * base^(length(preComma) - i);
    end
    comma = 0;
    for i = 1: length(postComma)
        comma = comma + str2num(postComma(i)) * base^(i*(-1));
    end
    decimalNumber = dec+comma;
else
    decimalNumber = var;
end
    
end

