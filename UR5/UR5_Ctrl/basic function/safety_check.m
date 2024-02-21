function sft = safety_check(theta)
% – Purpose: Perform a safety check on joint limits and collision
% – Inputs: q: 6 × 1 joint space variable vector = [θ1, θ2, θ3, θ4, θ5, θ6]T where θn is the angle of
% joint n for n = 1, · · · , 6. Be careful of sign convention!
% – Output: gst: end effector pose, gst (4 × 4 matrix)

% Abort if input is not enough
if length(theta) ~= 6
    error("theta list not equal to 6. ")
end

z_thres = 0.03;
sft = 0;

if abs(theta(1)) >= pi || abs(theta(2)) >= pi || abs(theta(3)) >= pi || abs(theta(4)) >= pi || abs(theta(5)) >= pi || abs(theta(6)) >= pi
    sft = 1;
    return
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

g3 = TwistExp(xi1, theta(1))*...
    TwistExp(xi2, theta(2))*...
    TwistExp(xi3, theta(3))*gst0;

g4 = TwistExp(xi1, theta(1))*...
    TwistExp(xi2, theta(2))*...
    TwistExp(xi3, theta(3))*...
    TwistExp(xi4, theta(4))*gst0;

g5 = TwistExp(xi1, theta(1))*...
    TwistExp(xi2, theta(2))*...
    TwistExp(xi3, theta(3))*...
    TwistExp(xi4, theta(4))*...
    TwistExp(xi5, theta(5))*gst0;

% Compute end effector pose
g6 = TwistExp(xi1, theta(1))*...
    TwistExp(xi2, theta(2))*...
    TwistExp(xi3, theta(3))*...
    TwistExp(xi4, theta(4))*...
    TwistExp(xi5, theta(5))*...
    TwistExp(xi6, theta(6))*gst0;

z3 = g3(3, 4);
z4 = g4(3, 4);
z5 = g5(3, 4);
z6 = g6(3, 4);

if z3 < z_thres || z4 < z_thres || z5 < z_thres || z6 < z_thres
    sft = 1;
    return
end

end