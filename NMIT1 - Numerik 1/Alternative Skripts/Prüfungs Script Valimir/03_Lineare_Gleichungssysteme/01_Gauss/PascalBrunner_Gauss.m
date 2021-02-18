% GAUSSVERFAHREN



function [A_triangle, detA, x] = PascalBrunner_Gauss(A,b)

% Füge Matrix A und b zusammen
matrix = [A b];

%Anzahl Spalten (i)
numberOfCols = size(matrix, 2);

%Anzahl Reihen (j)
numberOfRows = size(matrix, 1);

%Initialisierung aktueller Spalte / Reihe
currentRow = 1;
currentCol = 1;

while((currentRow <= numberOfRows) || (currentCol <= numberOfRows))
    if((matrix(currentRow, currentCol) == 0) && currentRow < numberOfRows)
        for k = currentRow + 1 : numberOfRows
            if(matrix(k, currentCol) ~= 0)
                %Tausche Zeile k mit Zeile currentRow
                matrix([k currentRow], :) = matrix([currentRow k], :);
            end
        end
        
        if(matrix(k, currentRow) == 0)
            error('Matrix hat nur Nullen in der Spalte %d, Determinate = 0', currentRow);
        end
    end
    
    % Iteration über Zeilen
    for j=currentRow+1:numberOfRows
        currentRowFactor = matrix(j, currentCol) / matrix(currentRow, currentCol);
        
        % Vielfaches der currentRow Zeile von der Zeile j abziehen, um
        % auf eine Zeile j eine 0 zu erhalten
        matrix(j, :) = matrix(j, :) - matrix(currentRow, :) .* currentRowFactor;
    end
    
    currentRow = currentRow + 1;
    currentCol = currentCol + 1;
end

% [A b] in TriangleMatrix
A_triangle = matrix(1:numberOfRows, 1:numberOfCols-1);
bGauss = matrix(:, numberOfCols);

%Determinante berechnen
detA = 1;
for l = 1:numberOfRows
    detA = detA * A_triangle(l,l);
end

%Rückwärtseinsetzen um x zu berechnen
x = zeros(1);

for i=numberOfRows: -1 : 1
    % Berechnen der Summe
    tmpSum = 0;
    for j = i+1:numberOfRows
        tmpSum = tmpSum + A_triangle(i,j) * x(j);
    end
    
    % effektiver Eintrag von x an Stell i
    x(i, 1) = (bGauss(i) - tmpSum) / A_triangle(i, i);
end
end