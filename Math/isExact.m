% syms m(x, y) n(x, y)
% m(x, y) = cos(x+y)
% n(x, y) = 3*y^2 + 2*y + cos(x+y)
% M = diff(m(x, y), y)
% N = diff(n(x, y), x)

function res = isExact(M, N, x, y)
    % diff M wrt y
    M = diff(M, y);
    disp("diff M over y: ")
    disp(M);
    % diff N wrt x
    N = diff(N, x);
    disp("diff N over x: ")
    disp(N);
    % check equality btw the diffs
    if isequal(M, N)
        disp("equ is exact");
        res = 1;
    else
        res = 0;
    end
end