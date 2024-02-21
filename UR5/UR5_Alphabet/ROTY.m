function Ry = ROTY(xita)
% Rotation along Y axis
% accept a scalar in radius and return the rotation matrix along y axis
Ry = [cos(xita)    0       sin(xita);
        0          1           0;
      -sin(xita)   0       cos(xita)];
end