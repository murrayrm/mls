function pose_m44 = FK_EXP35(theta)
    if length(theta) ~= 6
        error("theta list not equal to 6. ")
    end
       
    xi1 = [0;0;0;0;0;1]; % MLS example 3.5
    xi2 = [0;-1;0;-1;0;0];
    xi3 = [0;-1;1;-1;0;0];
    xi4 = [2;0;0;0;0;1];
    xi5 = [0;-1;2;-1;0;0];
    xi6 = [-1;0;0;0;1;0];
    gst0 = [eye(3), [0;2;1];[0 0 0 1]];

    pose_m44 = TwistExp(xi1, theta(1))*...
        TwistExp(xi2, theta(2))*...
        TwistExp(xi3, theta(3))*...
        TwistExp(xi4, theta(4))*...
        TwistExp(xi5, theta(5))*...
        TwistExp(xi6, theta(6))*gst0;

end