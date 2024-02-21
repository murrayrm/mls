% Function
% Params: roll value (radians) 
% Return: 3x3 rotation matrix

function rot_m33 = ROTX(roll)
    rot_m33 = [1 0 0 ; 0 cos(roll) -sin(roll); 0 sin(roll) cos(roll)];
end