function finalerr = ur5RRcontrol(g_des, K, ur5)
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
    
    % Compute desired position
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
    
        % Compute current unscale twist
        gtt_ = g_des \ g_k;
        xi_k = getXi(gtt_);
        %tmd = g_des-g_k;
        %disp(tmd);
        if  isnan(xi_k(1)) 
            xi_k = [tmd(1,4); tmd(2,4); tmd(3,4);0;0;0];
        end

        % Terminate when the current twist scale is small
        if norm(xi_k(1:3)) < v_thres && norm(xi_k(4:6)) < w_thres
            % Compute and return the positional error in cm
            pos_k = g_k(1:3, 4);
            finalerr = 100 * norm(pos_des - pos_k);
            return
        end
        
        % Update and move to next joints
        q_new = q_k - K * t_step * (Jb_k \ xi_k);
        mvmt_t = max(abs(q_new - q_k)/(ur5.speed_limit*pi)*60); 
        ur5.move_joints(q_new, mvmt_t);
        pause(mvmt_t);
    end
end