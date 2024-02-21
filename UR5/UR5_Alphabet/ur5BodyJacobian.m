function BodyJacobian = ur5BodyJacobian(q)

% ur5 configuration
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

% get twists
xi1 = [-cross(w1, [0;0;0]);w1];
xi2 = [-cross(w2, [0;0;L0]);w2];
xi3 = [-cross(w3, [L1;0;L0]);w3];
xi4 = [-cross(w4, [L1+L2;0;L0]);w4];
xi5 = [-cross(w5, [L1+L2;L3;0]);w5];
xi6 = [-cross(w6, [L1+L2;0;L0-L4]);w6];

% get zero-configuration
gst0 = [ROTX(deg2rad(90))*ROTY(deg2rad(-180)), [L1+L2;L3+L5;L0-L4];[0 0 0 1]];

% get body jacobian
xi1_doubleprime = adjoint(inv(TwistExp(xi1,q(1))*TwistExp(xi2,q(2))*TwistExp(xi3,q(3))*TwistExp(xi4,q(4))*TwistExp(xi5,q(5))*TwistExp(xi6,q(6))*gst0))*xi1;
xi2_doubleprime = adjoint(inv(TwistExp(xi2,q(2))*TwistExp(xi3,q(3))*TwistExp(xi4,q(4))*TwistExp(xi5,q(5))*TwistExp(xi6,q(6))*gst0))*xi2;
xi3_doubleprime = adjoint(inv(TwistExp(xi3,q(3))*TwistExp(xi4,q(4))*TwistExp(xi5,q(5))*TwistExp(xi6,q(6))*gst0))*xi3;
xi4_doubleprime = adjoint(inv(TwistExp(xi4,q(4))*TwistExp(xi5,q(5))*TwistExp(xi6,q(6))*gst0))*xi4;
xi5_doubleprime = adjoint(inv(TwistExp(xi5,q(5))*TwistExp(xi6,q(6))*gst0))*xi5;
xi6_doubleprime = adjoint(inv(TwistExp(xi6,q(6))*gst0))*xi6;

BodyJacobian = [xi1_doubleprime, xi2_doubleprime, xi3_doubleprime, xi4_doubleprime, xi5_doubleprime, xi6_doubleprime];

end
