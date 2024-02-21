function getEigen(M)
    [eigenVect, eigenValue] = eig(M);
    disp("eigenvalue");
    disp(eigenValue);
    disp("eigenvector");
    disp(eigenVect);
    
end