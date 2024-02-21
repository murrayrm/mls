% Function
% Params: yaw value (radians) 
% Return: 3x3 rotation matrix

function rot_m33 = ROTZ(yaw)
    rot_m33 = [cos(yaw) -sin(yaw) 0; sin(yaw) cos(yaw) 0; 0 0 1];
end