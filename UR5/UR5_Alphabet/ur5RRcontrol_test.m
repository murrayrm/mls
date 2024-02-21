%% Resolved Rate Controller Test 1
% the test can take 1-2 minutes to finish
clear;
clc;
ur5 = ur5_interface();
% Define and move to the initial configuration
q_ini = [pi/2; -pi/2; pi/4; pi/2; pi/4; pi/2];
ur5.move_joints(q_ini, 15);
pause(15);
% Define the gain
K = 0.3;
% Define the goal configuration
q_goal = [pi/2; -pi/2; pi/4; pi/4; pi/4; pi/2];
g_goal = ur5FwdKin(q_goal);
% Move to the goal and compute positional error
finalerr = ur5RRcontrol(g_goal, K, ur5);

%% Resolved Rate Controller Test 2 (Singularity)
clear;
clc;
ur5 = ur5_interface();
% Define and move to the initial configuration (Singularity)
q_ini = [pi/2; -pi/2; pi/4; pi/2; pi; pi/2];
ur5.move_joints(q_ini, 15);
pause(15);
% Define the gain
K = 0.3;
% Define the goal configuration
q_goal = [pi/2; -pi/2; pi/4; pi/4; pi/4; pi/2];
g_goal = ur5FwdKin(q_goal);
% Should be -1 for singularity
finalerr = ur5RRcontrol(g_goal, K, ur5);