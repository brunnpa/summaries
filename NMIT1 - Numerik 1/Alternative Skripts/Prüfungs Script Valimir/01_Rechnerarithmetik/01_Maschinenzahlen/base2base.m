function [ b ] = base2base( a, base_from, base_to )

    M = base2dec(a, base_from);
    n = floor(log10(M) / log10(base_to));
    b = zeros(1, n+1);
    for i = 0:n;
        b(n + 1 - i) = mod(floor(M / (base_to^i)), base_to);
    end

end