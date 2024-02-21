% Function
% Params: pitch value (radians) 
% Return: 3x3 rotation matrix

function rot_m33 = ROTY(pitch)
    rot_m33 = [cos(pitch) 0 sin(pitch); 0 1 0; -sin(pitch) 0 cos(pitch)];
end