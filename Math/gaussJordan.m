function M_inv = gaussJordan(M)
% A = [[-1 1 2; 3 -1 1; -1 3 4], eye(3)]
% M_inv = guassJordan(A)
% ans =
% 
% 1.0000         0         0   -0.7000    0.2000    0.3000
%      0    1.0000         0   -1.3000   -0.2000    0.7000
%      0         0    1.0000    0.8000    0.2000   -0.2000

    M_inv = rref(M); %  reduced row echelon form

end