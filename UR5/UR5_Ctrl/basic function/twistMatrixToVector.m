function twist_vector = twistMatrixToVector(twist_matrix)
    % Compute the vector form from the matrix form of a twist
    R = twist_matrix(1:3, 1:3);
    w=zeros(3,1);
    w(1)=(R(3,2)-R(2,3))/2;
    w(2)=(R(1,3)-R(3,1))/2;
    w(3)=-(R(1,2)-R(2,1))/2;

    v=twist_matrix(1:3,4);

    twist_vector=[v;w];
end
