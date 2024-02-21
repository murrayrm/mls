function theta = cp1(b,q,w,r)
% (canonical) subproblem 1: rotate b into q about w by theta
%    point r on twist axis, unit direction vector w, pure rotation
%    b,q,r are 4x1 points.    w is a 4x1 unit direction vector
% theta = cp1(b,q,w,r)
%
% DC Deno 9-26-91

u = b-r;
y = q-r;
u = u(1:3);
y = y(1:3);

% check for no solution, bomb out if so
if abs(u'*u - y'*y) > 100*eps
    error('cp1 failure: no solutions: |u| != |y|');
end
if abs(w'*u - w'*y) > 100*eps
    error('cp1 failure: no solutions: <w,u> != <w,y>');
end

uperp = (eye(3) - w*w')*u(1:3);
yperp = (eye(3) - w*w')*y(1:3);
theta = atan2(w'*cross(uperp,yperp), uperp'*yperp);