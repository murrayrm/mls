function TForm = TwistExp(xi,theta)
% TForm = TwistExp(xi,theta)
% Calculates the 4x4 homogenous transform matrix exponential of a twist xi.
% A twist is a 6x1 vector composed of a unit rotation and position vector.

%
%  Written by Dr. Kevin Otto
%  See LICENSE.txt for copyright info.
%
%
%  Robust Systems and Strategy LLC
%  otto@robuststrategy.com
%  Version 1.0
%

error(nargchk(2, 2, nargin))
if( (size(xi,1)~=1) | (size(xi,2)~=6) )
   error('Screws:RPToHomogeneous:Input','Input vector is not a 6x1 vector.\n');
end
if( (size(theta,1)~=1) | (size(theta,2)~=1) )
   error('Screws:RPToHomogeneous:Input','Input rotation is not a scalar.\n');
end

w = xi(4:6);  % Note it is a column vector
v = xi(1:3);  % Note it is a column vector
R = eye(3); 
p = [0,0,0];

if( w == [0,0,0] )
    R = eye(3);
    p = v*theta;
else
    R = SkewExp(w',theta);
    p = (eye(3) - R)*(AxisToSkew(w)*v) + w*w'*v*theta;  % AxisToSkew(w') = w_hat
end

TForm = [ R(1,1), R(1,2), R(1,3), p(1) ;
          R(2,1), R(2,2), R(2,3), p(2) ;
          R(3,1), R(3,2), R(3,3), p(3) ;
          0        0        0      1    ];

return;
