function out = pfd_pc_to_xy(in,pc,std_score,avg_face)
%Inputs:
%in: 1 x 166 vector of principal component (pc) coefficients (normally distributed)
%pc: 166 x 166 pc matrix
%std_score: 1 x 166 vector = standard deviation of the 400x166 score matrix
%avg_face: 85 x 2 matrix, the average face in xy coordinates
%
%Output:
%out: 85 x 2 xy coordinate representation of the face

npts = 85;

avg_face2 = avg_face;
avg_face2(44,:) = [];
avg_face2(37,:) = [];

in2 = in.*std_score;
fd1 = in2*pc';
fd2 = [fd1(1:end/2)' fd1(end/2+1:end)'];
fd3 = avg_face2 + fd2;

%insert missing points
fd4 = [];
fd4(1:36,:) = fd3(1:36,:);
fd4(37,:) = [2 0];
fd4(38:43,:) = fd3(37:42,:);
fd4(44,:) = [0 0];
fd4(45:85,:) = fd3(43:end,:);

out = fd4;
