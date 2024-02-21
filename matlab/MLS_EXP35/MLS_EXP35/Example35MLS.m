clear;clc;

% syms xi1 xi2 xi3 pw pb;
% syms theta1 theta2 theta3 theta4 theta5 theta6;

xi1 = [0;0;0;0;0;1];
xi2 = [0;-1;0;-1;0;0];
xi3 = [0;-1;1;-1;0;0];
xi4 = [2;0;0;0;0;1];
xi5 = [0;-1;2;-1;0;0];
xi6 = [-1;0;0;0;1;0];
% pb = [0;0;1];
% pw = [0;2;1];

gd = [ROTZ(0.2)*ROTX(0.4), [0.5; 1.2; 1.1]; [0 0 0 1]];
gst0 = [eye(3), [0;2;1];[0 0 0 1]];
% g = TwistExp(xi1, theta1)*TwistExp(xi2, theta2)*TwistExp(xi3, theta3)*TwistExp(xi4, theta4)*TwistExp(xi5, theta5)*TwistExp(xi6, theta6);
g1 = gd*inv(gst0);
