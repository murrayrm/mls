function theta = cp3(b,q,delta,w,r,swi)
% (canonical) subproblem 3: rotate b to a distance delta from q
%    point r on twist axis, unit direction vector w,
%    twist is pure rotation
%    b,q,r are 4x1 points.  w is 4x1 unit direction vector.
%    delta is a scalar distance from point q.
%    switch is an optional integer argument (0 or 1) to pick which
%       solution is returned
% theta = cp3(b,q,delta,w,r,switch)
% "theta3 = cp3(Pw, Pb, d, w3, o3, select(1))"
%
%
% DC Deno 9-26-91

% set "solution" to choose which to return
if nargin > 5
    solution = swi;
else
    solution = 0;
end

y = b-r;
u = q-r;

uperp = (eye(3) - w*w')*u(1:3);
yperp = (eye(3) - w*w')*y(1:3);

deltap2 = delta^2 - (w'*(u(1:3)-y(1:3)))^2;

% check for no solution, bomb out if so
if deltap2 < -100*eps
    error('cp3 failure: no solutions: deltap^2 < 0');
end

theta0 = atan2(w'*cross(yperp,uperp), yperp'*uperp);
cosphi = (uperp'*uperp + yperp'*yperp - deltap2) / (2*norm(uperp)*norm(yperp));

% check for no solution, bomb out if so
if abs(cosphi) > 1+100*eps
    error('cp3 failure: no solutions: cos(phi) out of [-1,1]');
end

phi = acos(cosphi);
if solution ~= 0	% get flip solution
    phi = -phi;
end

theta = theta0 + phi;