function [] = InvKinControl(q_start, q_des, ur5)

    % addpath('interface_trframe/');
    % addpath('InvKin_UR5/');

    % tuning parameters
    move_time = 0.8; % time between each intermediate points
    move_time_from_home = 10; % move speed from home to start point
    resolution = 0.005; % every step will go resolution mm by move_time
    

    % calculate g configuration of the staring point
    g_start = ur5FwdKin(q_start);
    g_des = ur5FwdKin(q_des);
    % calculate rotation matrix in rigidtransformation start and dest
    orientation1 = g_start(1:3,1:3);
    angles1 = EULERXYZINV(orientation1);
    orientation2 = g_des(1:3,1:3);
    angles2 = EULERXYZINV(orientation2);
    x_start = g_start(1:3,4);
    x_target = g_des(1:3,4);
    % use the same orient with start point
    % x_target = g_start(1:3,4);
    
    num_points = round(norm(x_start-x_target, 2)/resolution); % Euclidean distance from start to target / move step resolution
    % num_points = resolution; % number of intermediate points for each line
    x_waypoint = linspace(x_start(1), x_target(1), num_points);
    y_waypoint = linspace(x_start(2), x_target(2), num_points);
    z_waypoint = linspace(x_start(3), x_target(3), num_points);
    x_rot = linspace(angles1(1), angles2(1), num_points);
    y_rot = linspace(angles1(2), angles2(2), num_points);
    z_rot = linspace(angles1(3), angles2(3), num_points);
    
    q_current = ur5.get_current_joints();
    q = q_start;
    if rad2deg(max(abs(q_current-q_start))) > 0.1 % if not at start position
        ur5.move_joints(q_start,move_time_from_home);
        pause(move_time_from_home);
    end
    
    for i=1:num_points
        g = [EULERXYZ([x_rot(i), y_rot(i), z_rot(i)]) [x_waypoint(i) y_waypoint(i) z_waypoint(i)]';
            0 0 0 1];
        new_q = ur5InvKin(g);
        q_diff = abs(new_q - q);
        q_err = sum(q_diff);
        [~,index] = min(q_err);
        next_q = new_q(:,index);
        
        % Safety Check
        if safety_check(next_q) == 1
            error("Safety Protection");
        end


        ur5.move_joints(next_q, move_time);
        pause(move_time);
        q = ur5.get_current_joints();
        pause(1);
    end
    
end

