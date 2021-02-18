% Abgabe Gruppe 4 David Lüscher, Anastatios Martakos, Pascal Brunner
% Kann getestet werden mit Eingabe: Brunner_Pascal_Gruppe4_S3_Aufg3(50.04451,2,10)
function[y,value,abs_err,rel_err] = Brunner_Pascal_Gruppe4_S3_Aufg3(x,B,nmax)

    %Error Handling
    if B < 1 || B > 10 
        error('not a valid number - please enter a number between 1 and 10');
    end
    
    if nmax < 0
        error('not a valid number - please enter a number bigger than 0');
    end
    
    %initialize return values
    y = '';
    value = 0;
    
    %split number in two parts
    integer = abs(fix(x));
    decimal = abs(x) - integer;
    
    %convert to Base B
    %convert for integer values
    
    tempInteger = integer;
    exponent = 0;
    
    while tempInteger > 0
       %calculate the remaining value
       remainingValue = mod(tempInteger, B);
       
       %number to string
       y = [num2str(remainingValue), y];
       
       %calculate new value
       value = value + (remainingValue * B^(exponent));
       
       %calculate new integer value
       tempInteger = fix(tempInteger / B);
       
       %increase exponent + 1
       exponent = exponent + 1;
    end
    
    % add sign
    if sign(x) == -1
        y = ['-', y];
    else
        y = ['+', y];
    end
    
    % check if decimal, add delemiter
    if nmax > 0
        y = [y, '.'];
    end
    
    tempDecimal = decimal;
    exponent = 1; 
    
    while exponent <= nmax
        % tbd
        tempDecimal = tempDecimal * B;
        % save integer value 
        cuttedTempDecimal = fix(tempDecimal);
        % concatenate y with new cuttedTempDecimal
        y =[y, num2str(cuttedTempDecimal)];
        % calculate new value
        value = value + (cuttedTempDecimal * B^(-exponent));
        % calculate remaining decimal
        tempDecimal = tempDecimal - cuttedTempDecimal;
        % increment exponent
        exponent = exponent + 1;   
    end
    
    % calculate Error
    abs_err = abs(value - x);
    rel_err = abs(abs_err / x);
   
   % print values
    fprintf('value      = %f\n', value);
    fprintf('y          = %s        Base = %d\n', y, B);
    fprintf('abs_err    = %f\n', abs_err);
    fprintf('rel_err    = %f\n', rel_err);
end
    