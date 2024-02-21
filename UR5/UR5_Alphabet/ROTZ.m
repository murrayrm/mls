function Rz = ROTZ(xita)
% Rotation along Z axis
% accept a scalar in radius and return the rotation matrix along z axis
Rz = [cos(xita)    -sin(xita)     0;
      sin(xita)   cos(xita)     0;
        0          0             1];
end