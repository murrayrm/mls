function mu = manipulability(J,measure)
% – Purpose: Compute a measure of manipulability. Implement all three different types: ‘sigmamin’,
% ‘detjac’, or ‘invcond’, as defined in Chapter 3, Section 4.4 of MLS. This function will return
% any one of the three measures of manipulability as defined by the second argument (see
% below).
% – Inputs: There are two inputs to this function:
% ∗ J: a 6 × 6 matrix
% ∗ measure: a single string argument that can only be one of ‘sigmamin’, ‘detjac’, or
% ‘invcond’. Defines which manipulability measure is used.
% – Output: mu: The corresponding measure of manipulability
sing_val = sqrt(eig(J'*J));

% Minimum singular value of J
if measure == "sigmamin"
    mu = min(sing_val);
% Inverse of the condition number of J
elseif measure == "detjac"
    mu = det(J);
% Determinant of J
elseif measure == "invcond"
    mu = min(sing_val)/max(sing_val);
else
    disp('Measure not defined! Please enter one among "sigmamin", "detjac" and "invcond".')
end

end