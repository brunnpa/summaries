% Rechnet eine beliebige Dezimalzahl in eine beliebige Basis <10 um
%
% PARAMETERS:
% number = dezimalzahl
% B = Basis
%
% RETURN:
% result = zahl in neuer Basis
%
% SAMPLE: 
% dec_to_var(25.05,2)
% dec_to_var(25,2)
function [result] = dec_to_var(number,B)
    % used for the decimal part
    NMAX = 10;
    % error handling
    if B < 1 || B > 9
        error('B must be between 1 and 10');
    end
    
    % initialize return values
    result = '';
    
    % split number in two parts
    integer = abs(fix(number));
    decimal = abs(number) - integer;
    
    % convert to base B
    % convert integer part
    tempInteger = integer;
    while tempInteger > 0
        % calculate remaining part
        remaining = mod(tempInteger, B);
        % save remaining in the return string
        result = [num2str(remaining),result];
        % calculate new integer value
        tempInteger = fix(tempInteger/B);
    end
    
    % determine sign
    if sign(number) == -1
        result = ['-',result];
    else
        result = ['+',result];
    end
    
    % add delemiter in case deciaml > 0
    if decimal > 0
        result = [result,'.'];
        
        tempDecimal = decimal;
        % convert decimal part with iteration time of 10
        counter = 1;
        while counter <= NMAX
            tempDecimal = tempDecimal * B;
            % save integer value
            cuttedTempDecimal = fix(tempDecimal);
            % add integer part to y
            result = [result, num2str(cuttedTempDecimal)];
            % calculate remaining decimal
            tempDecimal = tempDecimal - cuttedTempDecimal;
            counter = counter + 1;   
        end
    end        
end
    
    


