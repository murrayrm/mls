addpath('basic function/');
addpath('interface_trframe/');
addpath('InvKin_UR5');

% start the ur5_interface
ur5 = ur5_interface();
% move to nearby position of teaching
ur5.move_joints(deg2rad([-90; -97.6501; -115.3289; -55.6628; 91.3168; 0]), 20);
pause(20);

s1 = 'NULL';
e1 = 'NULL';
keys1 = 0;
keye1 = 0;
key_p = 0;
keys = ["Y","y"];

%%%%%%%%%%%%%%%%% select the mode %%%%%%%%%%%%%%%%%%%%
mode = 2; % 1 demo mode; 2 simulation mode
teach_pen = 1; % 1 teach w pen; 0 teach w/o pen

% use test mode when doing demo
if mode == 1
    fprintf("test mode selected \n");
    % Teach UR5 start and goal points configurations
    ur5.swtich_to_pendant_control() 
    % Record two points configurations
    while(keys1~=1) 
        prompt = 'Please move the end effector to the first start point... Done ? Y/N ';
        s1 = input(prompt,'s');
        keys1 = max(strcmp(s1,keys));
    end
    
    % Record the 1st point
    q_s1 = ur5.get_current_joints();
    
    while(keye1~=1)
        prompt = 'Please move the end effector to the first end point... Done ? Y/N ';
        e1 = input(prompt,'s');
        keye1 = max(strcmp(e1,keys));
    end

    % Record the 2nd point
    q_e1 = ur5.get_current_joints();
    
    % Ensure the pen installed
    while(key_p~=1)
        prompt = 'Please install the pen to the end effector... Done ? Y/N ';
        p = input(prompt,'s');
        key_p = max(strcmp(p,keys));
    end

    % Finish teaching UR5 points configurations
    ur5.swtich_to_ros_control();
end

% use simulation mode when simulate offline
if mode == 2
    fprintf("simu mode selected \n");
    q_s1 = deg2rad(input('Input start point joint matrix 6X1 (degree): \n'));
    q_e1 = deg2rad(input('Input end point joint matrix 6X1 (degree): \n'));
    % q_s1 = deg2rad([-90.109278, -112.233509, -120.854908, -35.869582, 91.048015, -0.060722]');
    % q_e1 = deg2rad([-94.347798, -127.697953, -93.107041, -48.237714, 91.126080, -4.518129]');
end


%%%%%%%%%%%%%%%%%%% variables for control %%%%%%%%%%%%%%%%%%%
% gs1: start point transformation     | q_s1 start point joints
% ge1: end point transformation       | q_e1 end point joints
% g_ready: ready point transformation | q_ready: ready point joints
% gtp: from tool to pen transformation

% Define variables used across control methods
gs1 = ur5FwdKin(q_s1);
ge1 = ur5FwdKin(q_e1);
pen_length = 0.05; % maximum 0.12228 
gtp = [eye(3), [0; -0.049; pen_length]; 0 0 0 1]; % g from tool0 to pen_tip

% teach point without pen
if teach_pen == 0
    gs1 = gs1 / gtp; % offset the pen's matrix
    ge1 = ge1 / gtp; % offset the pens's matrix
    q_s1_list = ur5InvKin(gs1);
    q_s1 = theta_criteria(q_s1_list, q_s1);
    q_e1_list = ur5InvKin(ge1);
    q_e1 = theta_criteria(q_e1_list, q_e1);
end

% ready position which is exactly above start point
% suppose all drwing on the xy plane
g_ready = gs1; 
g_ready(3,4) =  g_ready(3,4) + 0.1; % offset 10cm wrt base link frame

q_ready_list = ur5InvKin(g_ready);
q_ready = theta_criteria(q_ready_list, q_s1); % select ready position with the minimal movement of joints

g_ready_p = g_ready * gtp;
gs1_p = gs1 * gtp;
ge1_p = ge1 * gtp;
tf_frame('base_link', 'ready_point', g_ready_p); % display ready point at pen tip
pause(0.5);
tf_frame('base_link', 'start_point', gs1_p); % display start point at pen tip
pause(0.5);
tf_frame('base_link', 'dest_point', ge1_p); % display destination point at pen tip
pause(0.5);

vec1 = ge1(1:3, 4) - gs1(1:3, 4); % vector from start to dest points
vec1_1 = ROTZ(deg2rad(18.5))*vec1; % similar triangle to get the angle
middle_point1_offset = vec1_1/norm(vec1_1)*0.1; % offset along vec by 10cm
vec1_2 = ROTZ(deg2rad(18.5-90))*vec1; % vector from middlepoint1 to middlepoint2
middle_point2_offset = vec1_2/norm(vec1_2)*0.05; % offset along vec by 5cm
% middle point 1
g_middle_point1 = gs1;
g_middle_point1(1:3, 4) = g_middle_point1(1:3, 4) + middle_point1_offset;
q_middle_list = ur5InvKin(g_middle_point1);
q_middle_point1 = theta_criteria(q_middle_list, q_s1);
g_middle_point1_p = g_middle_point1 * gtp;
tf_frame('base_link', 'middle_point1', g_middle_point1_p); % display ready point at pen tip
pause(0.5);
% middle point 2
g_middle_point2 = g_middle_point1;
g_middle_point2(1:3, 4) = g_middle_point2(1:3, 4) + middle_point2_offset;
q_middle_list = ur5InvKin(g_middle_point2);
q_middle_point2 = theta_criteria(q_middle_list, q_middle_point1);
g_middle_point2_p = g_middle_point2 * gtp;
tf_frame('base_link', 'middle_point2', g_middle_point2_p); % display ready point at pen tip
pause(0.5);


n = input(['Press "1" for Inverse Kinematic Control. \n ' ...
           'Press "2" for Resolved-Rate Control. \n ' ...
           'Press "3" for Transpose Jacobian. \n ' ...
           'Press "0" to exit. \n']);


while (n ~= 0)
    switch n
        case 1 %Inverse Kinematic Control
 
            ur5.move_joints(q_ready, 10);
            pause(10);
            InvKinControl(q_ready,q_s1,ur5);
            
            %display error
            reportError(ur5FwdKin(ur5.get_current_joints()), gs1);
            tic;
            % drawing line1
            InvKinControl(q_s1,q_middle_point1, ur5);
            
            % drawing line2
            InvKinControl(q_middle_point1,q_middle_point2, ur5);
            
            % drawing line3
            InvKinControl(q_middle_point2, q_e1, ur5);
            
            %display error
            reportError(ur5FwdKin(ur5.get_current_joints()), ge1);
            time_elapse = toc;
            disp("running time for IK / s: ");
            disp(time_elapse);

        case 2 %Resolved-Rate Control

            % Define the gain
            K = 0.25;

            ur5.move_joints(q_ready, 10);
            pause(10);
            err1 = ur5RRcontrol(gs1, K, ur5);

            % drawing line1
            err2 = ur5RRcontrol(g_middle_point1, K, ur5);
            
            % drawing line2
            err3 = ur5RRcontrol(g_middle_point2, K, ur5);
            
            % drawing line3
            err4 = ur5RRcontrol(ge1, K, ur5);

            disp(err1);
            disp(err4);

        case 3 %Transpose Jacobian
             % Define the gain
            K = 1;

            ur5.move_joints(q_ready, 10);
            pause(10);
            err1 = ur5JTcontrol(gs1, K, ur5);

            % drawing line
            for n = 1:50
                insert_point = gs1 + (ge1 - gs1) / 50 * n;
                err2 = ur5JTcontrol(insert_point, K, ur5);
            end
            
            disp(err1);
            disp(err2);
            
    end
    
    n = input('Press "1" for Inverse Kinematic Control. \n Press "2" for Resolved-Rate Control. \n Press "3" for Transpose Jacobian Control. \n Press "0" to exit.');
end



