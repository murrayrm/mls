function theta = invk(g,soln)
% invk.m - inverse kinematics of Intelledex
% syntax: theta = invk(g,soln)
%     theta is a 6x1 vector of joint angles
%     g is a 4x4 frame
%     soln is an optional integer argument in 0,..,7 to pick solution
%
% DC Deno 9-26-91

% Could speed up considerably by:
%    1) compiling code with an optimizing compiler
%    2) compute directly inverse of 4x4 homogeneous matrix
%         with R^T and -R^Tp
%    3) compute directly exponentials of twists with Rodriques'
%         formula and other simple expressions
%    4) leave static definitions out of functions

% set decision tree array as 1x3 row vector of 1's and 0's
if nargin > 1
    select = sdecide(soln);
else
    select = sdecide(0);
end

% [l1,l2] = linklen;	% l1,l2 (link lengths)

% points on each twist axis [EXP3.5 MLS]
o0 = [0; 0; 1; 1];
o1 = o0;
o2 = [0; 1; 1; 1];
o3 = [0; 2; 1; 1];
o4 = o3;
o5 = o3;

% unit direction vectors of each twist axis
w0 = [0; 0; 1];
w1 = [-1; 0; 0];
w2 = [-1; 0; 0];
w3 = [0; 0; 1];
w4 = [-1; 0; 0];
w5 = [0; 1; 0];

% compute 4x4 unit twists wrt initial frame location
xi0hat = twisthat(cross(o0(1:3),w0(1:3)), w0(1:3));
xi1hat = twisthat(cross(o1(1:3),w1(1:3)), w1(1:3));
xi2hat = twisthat(cross(o2(1:3),w2(1:3)), w2(1:3));
xi3hat = twisthat(cross(o3(1:3),w3(1:3)), w3(1:3));
xi4hat = twisthat(cross(o4(1:3),w4(1:3)), w4(1:3));
xi5hat = twisthat(cross(o5(1:3),w5(1:3)), w5(1:3));

% decompose into 2 parts:
%     cartesian location of end effector (theta 3,4,5)
%     orientation of "wrist" (actually at shoulder)

Pb = o0;
Pw = o3;
d = norm(g*Pw - Pb);
% fprintf("-----delta d is: %.3f \n", d);
theta2 = cp3(Pw, Pb, d, w2, o2, select(1)); % cp3(b,q,delta,w,r,swi)
% fprintf("-----theta2 is: %.3f \n", theta2);

p = expm(xi2hat*theta2)*Pw;
q = g*Pw;
r = Pb;
[theta0,theta1] = cp2(p, q, w0, w1, r, select(2));
% fprintf("-----theta1 is: %.3f \n", theta1);
% fprintf("-----theta0 is: %.3f \n", theta0);


p = [0;0;1;1]; % point not on xi3 and xi4
q = expm(-xi2hat*theta2)*expm(-xi1hat*theta1)*expm(-xi0hat*theta0)*g*Pb;
[theta3,theta4] = cp2(p, q, w3, w4, o3, select(3));
% fprintf("-----theta3 is: %.3f \n", theta3);
% fprintf("-----theta4 is: %.3f \n", theta4);

p = [0;0;0;1]; % not on xi5
r = o5;
q = expm(-xi4hat*theta4)*expm(-xi3hat*theta3)*expm(-xi2hat*theta2)*expm(-xi1hat*theta1)*expm(-xi0hat*theta0)*g*p;
theta5 = cp1(p, q, w5, r);
% fprintf("-----theta5 is: %.3f \n", theta5);

% b = inv(g)*Pb;
% q = expm(-xi3hat*theta3)*Pb;
% [theta4,theta5] = cp2(b, q, w4, w5, o4, select(2)); % cp2(b,q,w1,w2,r,swi)
% 
% g012 = g*expm(-xi5hat*theta5)*expm(-xi4hat*theta4)*expm(-xi3hat*theta3);
% [theta0,theta1] = cp2(w2, g012*w2, w0, w1, [0;0;0;0], select(3));
% 
% g2 = expm(-xi1hat*theta1)*expm(-xi0hat*theta0)*g012;
% theta2 = cp1(w1, g2*w1, w2, [0;0;0;0]);
% 
theta = real([theta0 theta1 theta2, theta3, theta4, theta5]);