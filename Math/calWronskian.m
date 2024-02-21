% syms y1(x) y2(x)
% y2(x) = sin(x)
% y1(x) = cos(x)
% calWronskian(y1(x), y2(x), x)

function y = calWronskian(varargin) % symbolic calculation
    y = sym('y',  [nargin-1, nargin-1]);
    y(1, :) = varargin(1:end-1);
    % construct wronskian matrix M
    for i = 1: nargin-1 % col 
        for j = 2:nargin-1 % row
            y(j, i) = diff(y(j-1, i), varargin(end));
        end
    end

    % calculate wronskian
    disp("det of Wronskian matrix is:")
    disp(det(y))
end