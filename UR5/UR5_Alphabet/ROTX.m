function Rx = ROTX(xita)
% Rotation along X axis
% accept a scalar in radius and return the rotation matrix along x axis
Rx =[1     0           0;
     0 cos(xita)  -sin(xita);
     0 sin(xita) cos(xita)];
end