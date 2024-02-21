% Function
% Params: a 6x1 vector 
% Return: 4x4 rigid transformer matrix SE(3)
% spatial fixed coincide with baselink in RVIZ

% ur5FwdKin([0; 0; pi/2; 0; 0; 0])
% 
% -0.0000    1.0000   -0.0000    0.3303
% -0.0000    0.0000    1.0000    0.1918
%  1.0000    0.0000    0.0000   -0.3028
%       0         0         0    1.0000

function gst = ur5FwdKin(theta)
% – Purpose: Compute the forward kinematic map of the UR5. All necessary parameters (e.g.
% the base twists, gst0, etc) should be defined inside the function.
% – Inputs: q: 6 × 1 joint space variable vector = [θ1, θ2, θ3, θ4, θ5, θ6]T where θn is the angle of
% joint n for n = 1, · · · , 6. Be careful of sign convention!
% – Output: gst: end effector pose, gst (4 × 4 matrix)

% Abort if input is not enough
if length(theta) ~= 6
        error("theta list not equal to 6. ")
end

% Define parameters
w1 = [0;0;1];
w2 = [0;1;0];
w3 = [0;1;0];
w4 = [0;1;0];
w5 = [0;0;-1];
w6 = [0;1;0];

L0 = 89.2/1000;
L1 = 425/1000;
L2 = 392/1000;
L3 = 109.3/1000;
L4 = 94.75/1000;
L5 = 82.5/1000;

% Compute twists xi
xi1 = [-cross(w1, [0;0;0]);w1]; % ur5
xi2 = [-cross(w2, [0;0;L0]);w2];
xi3 = [-cross(w3, [L1;0;L0]);w3];
xi4 = [-cross(w4, [L1+L2;0;L0]);w4];
xi5 = [-cross(w5, [L1+L2;L3;0]);w5];
xi6 = [-cross(w6, [L1+L2;0;L0-L4]);w6];

% Compute zero-configuration
gst0 = [ROTX(deg2rad(90))*ROTY(deg2rad(-180)), [L1+L2;L3+L5;L0-L4];[0 0 0 1]];% rotate -90 by x-axis

% Compute end effector pose
gst = TwistExp(xi1, theta(1))*...
    TwistExp(xi2, theta(2))*...
    TwistExp(xi3, theta(3))*...
    TwistExp(xi4, theta(4))*...
    TwistExp(xi5, theta(5))*...
    TwistExp(xi6, theta(6))*gst0;

end