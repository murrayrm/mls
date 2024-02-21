% Function
% Params: a 3x1 vector 
% Return: 3x3 skew symmetric matrix

function skew_m33 = SKEW3(vec31)
    skew_m33 = [0 -vec31(3) vec31(2); vec31(3) 0 -vec31(1); -vec31(2) vec31(1) 0];
end