function selector = sdecide(soln)
% decision tree array for inverse kinematics (array of 0's and 1's)
% selector = sdecide(soln)
%    returns row vector of 0's and 1's
%    soln is integer 0,1,.. representing which of the 2^n solns
%
% DC Deno 9-26-91

n = 3;
selector = zeros(1,n);	% initialize for n binary decision points
for i = (length(selector)-1):-1:0
    x = floor(soln/2^i) * 2^i;
    if x > 0
        selector(i+1) = 1;
        soln = soln - x;
    end
end