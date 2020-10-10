function out = pfd_xy_to_pc(in,pc,std_score,avg_face)
%Inputs: 
%in: 85 x 2 xy coordinate representation of the face
%pc: 166 x 166 pc matrix
%std_score: 1 x 166 vector = standard deviation of the 400x166 score matrix
%avg_face: 85 x 2 matrix, the average face in xy coordinates
%
%Output:
%out: 1 x 166 vector of principal component (pc) coefficients (normally distributed)

npts = 85;

avg_face2 = avg_face;
avg_face2(44,:) = [];
avg_face2(37,:) = [];


%remove pupil points
in2 = in([1:36 38:43 45:85],:);

in3 = in2 - avg_face2;
in4 = [in3(:,1)' in3(:,2)'];
in5 = in4*(inv(pc))';
in6 = in5./std_score;


out = in6;

