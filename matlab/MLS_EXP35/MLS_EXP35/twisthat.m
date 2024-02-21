function th = twisthat(v,w)
% hat of pair of 3x1 twist vector coordinates into 4x4 matrix
% twisthat(v,w) = (w^ v)
%                 (0  0)
%
% DC Deno 9-26-91

th = [0     -w(3)   w(2)   v(1); 
      w(3)   0     -w(1)   v(2);
     -w(2)   w(1)   0      v(3);
      0      0      0      0];