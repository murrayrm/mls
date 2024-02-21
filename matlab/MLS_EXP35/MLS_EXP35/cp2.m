function [theta1,theta2] = cp2(b,q,w1,w2,r,swi)
% (canonical) subproblem 2: rotate b into q by theta2 about w2
%    followed by theta1 about w1.
%    point r is at the intersection of twist axes
%    unit direction vectors w1 and w2,
%    both twists are pure rotation
%    b,q,r are 4x1 points.    w1,w2 are 4x1 unit direction vectors
%    switch is an optional integer argument (0 or 1) to pick which
%       solution is returned
% [theta1,theta2] = cp2(b,q,w1,w2,r,switch)
%
% DC Deno 9-26-91

% set "solution" to choose which to return
if nargin > 5
    solution = swi;
else
    solution = 0;
end

u = b-r; % p in example 3.5
y = q-r; % q in example 3.5
u = u(1:3);
y = y(1:3);


% check for no solution, bomb out if so
if abs(u'*u - y'*y) > 100*eps
    error('cp2 failure: no solutions: |u| != |y|');
end

denom = ((w1'*w2)^2 - 1);
alpha = ((w1'*w2)*w2'*u - w1'*y) / denom;
beta  = (-w2'*u + (w1'*w2)*w1'*y) / denom;
denom = norm(cross(w1,w2))^2;
lambda = sqrt((norm(u)^2-alpha^2-beta^2-2*alpha*beta*w1'*w2) / denom);
if solution ~= 0	% get flip solution
    lambda = -lambda;
end

% check for no solution, bomb out if so
if abs(imag(lambda)) > 100*eps
    error('cp2 failure: no solutions: imag(lamba) != 0');
end

z = alpha*w1 + beta*w2 + lambda*cross(w1,w2);
c = [z(1); z(2); z(3); 0] + r;

theta2 = cp1(b,c,w2,r);
theta1 = cp1(c,q,w1,r);