%%lab 3
g = eye(4);
g(1:3,1:3) = ROTZ(pi);
g(1:3,4) = [1 1 1];
[xi,theta] = getXi(g);
xi_hat = zeros(4,4);
xi_hat(1:3,1:3) = SKEW3(xi(4:6));
xi_hat(1:3,4) = xi(1:3);
f = expm(xi_hat);
f - g