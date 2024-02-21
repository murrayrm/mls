function finalerr = ur5JTcontrol(g_des, K, ur5)
    % – Inputs:
    % ∗ gdesired: a homogeneous transform that is the desired end-effector pose, i.e. gst∗ .
    % ∗ K: the gain on the controller
    % ∗ ur5: the ur5 interface object
    % – Output: finalerr: -1 if there is a failure. If convergence is achieved, give the final positional
    % error in cm.
    
    % Define time step and parameter thresholds
    t_step = 0.1;
    mani_thres = 0.03;
    w_thres = 0.002;
    v_thres = 0.002;
    
    % Compute desired rotation and position
    r_des = g_des(1:3, 1:3);
    pos_des = g_des(1:3, 4);
    
    while true
        % Get current joints
        q_k = ur5.get_current_joints();
        % Compute current transformation matrix, body jacobian & manipulability
        g_k = ur5FwdKin(q_k);
        Jb_k = ur5BodyJacobian(q_k);
        mani_k = manipulability(Jb_k, 'sigmamin');
    
        % Check For Singularities
        if rank(Jb_k) < 6 || mani_k < mani_thres
            % If so, abort and return -1
            finalerr = -1;
            disp('Singularity! ABORT!');
            return
        end

        % Safety Check
        if safety_check(q_k) == 1
            error("Safety Protection");
        end
    
        % Compute current unscale twist
        xi_k = getXi(g_des \ g_k);
        % Terminate when the current twist scale is small
        if norm(xi_k(1:3)) < v_thres && norm(xi_k(4:6)) < w_thres
            % Compute and return the rotational and positional error in cm
            r_k = g_k(1:3, 1:3);
            pos_k = g_k(1:3, 4);
            err_r = sqrt(trace((r_k - r_des)*transpose(r_k - r_des)));
            err_p = 100 * norm(pos_des - pos_k);
            finalerr = [err_r; err_p];
            return
        end
        
        % Update and move to next joints
        q_new = q_k - K * t_step * transpose(Jb_k) * xi_k;
        ur5.move_joints(q_new, t_step);
        pause(t_step);
    end
end