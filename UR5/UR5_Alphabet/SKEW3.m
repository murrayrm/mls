function R = SKEW3(X)
% SkEW function
R = [0 -X(3,1) X(2,1);
     X(3,1) 0  -X(1,1);
    -X(2,1) X(1,1) 0];
end