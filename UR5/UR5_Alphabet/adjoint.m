function Ad = adjoint(g)
    % Compute the adjoint matrix of g
    R = g(1:3, 1:3);
    p = g(1:3, 4);
    p_hat = [0, -p(3), p(2); p(3), 0, -p(1); -p(2), p(1), 0];
    Ad = [R, p_hat * R; zeros(3,3), R];
end