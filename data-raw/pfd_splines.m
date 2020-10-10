function pfd_splines(face)
%function takes in a normalized 85x2 vector (a face) and renders the PFD

%define all the partial vectors
points_outline = face(1:16,:);
points_r_eyebrow = face(17:23,:);
points_l_eyebrow = face(24:30,:);
points_r_eye = face(31:37,:);
points_l_eye = face(38:44,:);
points_r_eyelid = face(45:47,:);
points_l_eyelid = face(48:50,:);
points_r_undereye = face(51:53,:);
points_l_undereye = face(54:56,:);
points_nose_bridge = face(57:62,:);
points_nose_tip = face(63:65,:);
points_nostrils = face(66:71,:);
points_mouth = face(72:85,:);

npts_outline = 16;
npts_r_eyebrow = 7;
npts_l_eyebrow = 7;
npts_r_eye = 7;
npts_l_eye = 7;
npts_r_eyelid = 3;
npts_l_eyelid = 3;
npts_r_undereye = 3;
npts_l_undereye = 3;
npts_nose_bridge = 6;
npts_nose_tip = 3;
npts_nostrils = 6;
npts_mouth = 14;

%set all the feature colors
color_bkgd = [.8 .8 .8];
color_iris = [.8 .8 .8];
outline_color = [0 0 0];
fill_color = [.4 .4 .4];

hold off

%render the PFD
if 1  
    %splining outline
    points_outline2 = [points_outline; points_outline(1,:)];
    n1 = 1;
    n2 = npts_outline+1;
    resolution = 50;   
    t1a = [n1:1:n2];
    z1a = [points_outline2(n1:n2,1) points_outline2(n1:n2,2)]';
    pp1a = spline(t1a,z1a);
    yy1a = ppval(pp1a, linspace(n1,n2,(n2-n1)*resolution+1))';
    plot(yy1a(:,1), -yy1a(:,2),'linewidth',2,'color',outline_color)
    
    axis equal
    axis off
    hold on
    
    %splining r eyebrow
    points_r_eyebrow2 = [points_r_eyebrow; points_r_eyebrow(1,:)];
    n1 = 1;
    n2 = npts_r_eyebrow+1;
    resolution = 50;   
    t1b = [n1:1:n2];
    z1b = [points_r_eyebrow2(n1:n2,1) points_r_eyebrow2(n1:n2,2)]';
    pp1b = spline(t1b,z1b);
    yy1b = ppval(pp1b, linspace(n1,n2,(n2-n1)*resolution+1))';
    plot(yy1b([1:end 1:2],1), -yy1b([1:end 1:2],2),'linewidth',4,'color',outline_color)
    fill(yy1b(:,1), -yy1b(:,2),fill_color);
    
    %splining l eyebrow
    points_l_eyebrow2 = [points_l_eyebrow; points_l_eyebrow(1,:)];
    n1 = 1;
    n2 = npts_l_eyebrow+1;
    resolution = 50;   
    t1c = [n1:1:n2];
    z1c = [points_l_eyebrow2(n1:n2,1) points_l_eyebrow2(n1:n2,2)]';
    pp1c = spline(t1c,z1c);
    yy1c = ppval(pp1c, linspace(n1,n2,(n2-n1)*resolution+1))';
    plot(yy1c(:,1), -yy1c(:,2),'linewidth',2,'color',outline_color)
    fill(yy1c(:,1), -yy1c(:,2),fill_color);
    
    %splining right eye
    points_r_eye2 = [points_r_eye; points_r_eye(1,:)];
    n1 = 1;
    n2 = 4;
    resolution = 50;   
    t1d = [n1:1:n2];
    z1d = [points_r_eye2(n1:n2,1) points_r_eye2(n1:n2,2)]';
    pp1d = spline(t1d,z1d);
    yy1d0 = ppval(pp1d, linspace(n1,n2,(n2-n1)*resolution+1))';
    plot(yy1d0(:,1), -yy1d0(:,2),'linewidth',3,'color',outline_color)

    points_r_eye2 = [points_r_eye([1 6 5 4],1), points_r_eye([1 6 5 4],2)];      
    n1 = 1;
    n2 = 4;
    resolution = 50;   
    t1d = [n1:1:n2];
    z1d = [points_r_eye2(n1:n2,1) points_r_eye2(n1:n2,2)]';
    pp1d = spline(t1d,z1d);
    yy1d = ppval(pp1d, linspace(n1,n2,(n2-n1)*resolution+1))';
    plot(yy1d(:,1), -yy1d(:,2),'linewidth',2,'color',outline_color)

    %redraw curve of iris
    iris = [[points_r_eye([2 6],1); points_r_eye([5 3],1); points_r_eye([2],1)] [points_r_eye([2 6],2); points_r_eye([5 3],2); points_r_eye([2],2)]]; 

    n1 = 1;
    n2 = 5;
    resolution = 50;   
    t1c = [n1:1:n2];
    z1c = [iris(:,1), iris(:,2)]';
    pp1c = spline(t1c,z1c);
    yy1c = ppval(pp1c, linspace(n1,n2,(n2-n1)*resolution+1))';
    fff = [[yy1c(1:50,1); yy1d(51:100,1); yy1c(101:150,1); yy1d0(100:-1:51,1)] [ -yy1c(1:50,2); -yy1d(51:100,2); -yy1c(101:150,2); -yy1d0(100:-1:51,2)]];
    
    plot(fff(:,1),fff(:,2),'linewidth',2,'color',outline_color);
    fill(fff(:,1),fff(:,2),fill_color);

    % plot pupil & glint
    plot(points_r_eye(7,1), -points_r_eye(7,2),'.','markersize',30,'color',outline_color);    %pupil
    fill([points_r_eye(7,1) points_r_eye(7,1)+.04 points_r_eye(7,1)+.04 points_r_eye(7,1) points_r_eye(7,1)], ...
        [-points_r_eye(7,2) -points_r_eye(7,2) -points_r_eye(7,2)+.04 -points_r_eye(7,2)+.04 -points_r_eye(7,2)],color_iris);    %glint
    plot([points_r_eye(7,1) points_r_eye(7,1)+.04 points_r_eye(7,1)+.04 points_r_eye(7,1) points_r_eye(7,1)], ...
        [-points_r_eye(7,2) -points_r_eye(7,2) -points_r_eye(7,2)+.04 -points_r_eye(7,2)+.04 -points_r_eye(7,2)],'color',color_iris);    %glint
     
    n1 = 1;
    n2 = 5;
    resolution = 50;   
    t1c = [n1:1:n2];
    z1c = [iris(:,1), iris(:,2)]';
    pp1c = spline(t1c,z1c);
    yy1c = ppval(pp1c, linspace(n1,n2,(n2-n1)*resolution+1))';
    plot(fff(:,1),fff(:,2),'linewidth',2,'color',outline_color);
  
    %splining left eye
    points_l_eye2 = [points_l_eye; points_l_eye(1,:)];
    n1 = 1;
    n2 = 4;
    resolution = 50;   
    t1d = [n1:1:n2];
    z1d = [points_l_eye2(n1:n2,1) points_l_eye2(n1:n2,2)]';
    pp1d = spline(t1d,z1d);
    yy1d0 = ppval(pp1d, linspace(n1,n2,(n2-n1)*resolution+1))';
    plot(yy1d0(:,1), -yy1d0(:,2),'linewidth',3,'color',outline_color)
    
 
    points_l_eye2 = [points_l_eye([1 6 5 4],1), points_l_eye([1 6 5 4],2)];    
    n1 = 1;
    n2 = 4;
    resolution = 50;   
    t1d = [n1:1:n2];
    z1d = [points_l_eye2(n1:n2,1) points_l_eye2(n1:n2,2)]';
    pp1d = spline(t1d,z1d);
    yy1d = ppval(pp1d, linspace(n1,n2,(n2-n1)*resolution+1))';
    plot(yy1d(:,1), -yy1d(:,2),'linewidth',2,'color',outline_color)

  
    %redraw curve of iris
    iris = [[points_l_eye([2 6],1); points_l_eye([5 3],1); points_l_eye([2],1)] [points_l_eye([2 6],2); points_l_eye([5 3],2); points_l_eye([2],2)]]; 

    n1 = 1;
    n2 = 5;
    resolution = 50;   
    t1c = [n1:1:n2];
    z1c = [iris(:,1), iris(:,2)]';
    pp1c = spline(t1c,z1c);
    yy1c = ppval(pp1c, linspace(n1,n2,(n2-n1)*resolution+1))';
    
    fff = [[yy1c(1:50,1); yy1d(51:100,1); yy1c(101:150,1); yy1d0(100:-1:51,1)] [ -yy1c(1:50,2); -yy1d(51:100,2); -yy1c(101:150,2); -yy1d0(100:-1:51,2)]];

    plot(fff(:,1),fff(:,2),'linewidth',2,'color',outline_color);
    fill(fff(:,1),fff(:,2),fill_color);


    %plot pupil & glint
    plot(points_l_eye(7,1), -points_l_eye(7,2),'.','markersize',30,'color',outline_color);    %pupil
    fill([points_l_eye(7,1) points_l_eye(7,1)+.04 points_l_eye(7,1)+.04 points_l_eye(7,1) points_l_eye(7,1)], ...
        [-points_l_eye(7,2) -points_l_eye(7,2) -points_l_eye(7,2)+.04 -points_l_eye(7,2)+.04 -points_l_eye(7,2)],color_iris);    %glint

    plot([points_l_eye(7,1) points_l_eye(7,1)+.04 points_l_eye(7,1)+.04 points_l_eye(7,1) points_l_eye(7,1)], ...
        [-points_l_eye(7,2) -points_l_eye(7,2) -points_l_eye(7,2)+.04 -points_l_eye(7,2)+.04 -points_l_eye(7,2)],'color',color_iris);    %glint

    n1 = 1;
    n2 = 5;
    resolution = 50;   
    t1c = [n1:1:n2];
    z1c = [iris(:,1), iris(:,2)]';
    pp1c = spline(t1c,z1c);
    yy1c = ppval(pp1c, linspace(n1,n2,(n2-n1)*resolution+1))';
    plot(fff(:,1),fff(:,2),'linewidth',2,'color',outline_color);
    
    %splining r eyelid
    points_r_eyelid2 = [points_r_eyelid; points_r_eyelid(1,:)];
    n1 = 1;
    n2 = npts_r_eyelid;
    resolution = 50;   
    t1b = [n1:1:n2];
    z1b = [points_r_eyelid2(n1:n2,1) points_r_eyelid2(n1:n2,2)]';
    pp1b = spline(t1b,z1b);
    yy1b = ppval(pp1b, linspace(n1,n2,(n2-n1)*resolution+1))';
    plot(yy1b(:,1), -yy1b(:,2),'linewidth',2,'color',outline_color)
    
    
    %splining l eyelid
    points_l_eyelid2 = [points_l_eyelid; points_l_eyelid(1,:)];
    n1 = 1;
    n2 = npts_l_eyelid;
    resolution = 50;   
    t1c = [n1:1:n2];
    z1c = [points_l_eyelid2(n1:n2,1) points_l_eyelid2(n1:n2,2)]';
    pp1c = spline(t1c,z1c);
    yy1c = ppval(pp1c, linspace(n1,n2,(n2-n1)*resolution+1))';
    plot(yy1c(:,1), -yy1c(:,2),'linewidth',2,'color',outline_color)
    
    %splining r undereye
    points_r_undereye2 = [points_r_undereye; points_r_undereye(1,:)];
    n1 = 1;
    n2 = npts_r_undereye;
    resolution = 50;   
    t1b = [n1:1:n2];
    z1b = [points_r_undereye2(n1:n2,1) points_r_undereye2(n1:n2,2)]';
    pp1b = spline(t1b,z1b);
    yy1b = ppval(pp1b, linspace(n1,n2,(n2-n1)*resolution+1))';
    plot(yy1b(:,1), -yy1b(:,2),'linewidth',2,'color',outline_color);
    
    %splining r undereye
    points_l_undereye2 = [points_l_undereye; points_l_undereye(1,:)];
    n1 = 1;
    n2 = npts_l_undereye;
    resolution = 50;   
    t1b = [n1:1:n2];
    z1b = [points_l_undereye2(n1:n2,1) points_l_undereye2(n1:n2,2)]';
    pp1b = spline(t1b,z1b);
    yy1b = ppval(pp1b, linspace(n1,n2,(n2-n1)*resolution+1))';
    plot(yy1b(:,1), -yy1b(:,2),'linewidth',2,'color',outline_color);
   

    %splining nose bridge
    points_nose_bridge2 = [points_nose_bridge; points_nose_bridge(1,:)];
    n1 = 1;
    n2 = 3; %npts_nose_bridge;
    resolution = 50;   
    t1b = [n1:1:n2];
    z1b = [points_nose_bridge2(n1:n2,1) points_nose_bridge2(n1:n2,2)]';
    pp1b = spline(t1b,z1b);
    yy1b = ppval(pp1b, linspace(n1,n2,(n2-n1)*resolution+1))';
    plot(yy1b(:,1), -yy1b(:,2),'linewidth',2,'color',outline_color)
    
    n1 = 4;
    n2 = 6; %npts_nose_bridge;
    resolution = 50;   
    t1b = [n1:1:n2];
    z1b = [points_nose_bridge2(n1:n2,1) points_nose_bridge2(n1:n2,2)]';
    pp1b = spline(t1b,z1b);
    yy1b = ppval(pp1b, linspace(n1,n2,(n2-n1)*resolution+1))';
    plot(yy1b(:,1), -yy1b(:,2),'linewidth',2,'color',outline_color)
    
    %splining l eyebrow
    points_l_eyebrow2 = [points_l_eyebrow; points_l_eyebrow(1,:)];
    n1 = 1;
    n2 = npts_l_eyebrow+1;
    resolution = 50;   
    t1c = [n1:1:n2];
    z1c = [points_l_eyebrow2(n1:n2,1) points_l_eyebrow2(n1:n2,2)]';
    pp1c = spline(t1c,z1c);
    yy1c = ppval(pp1c, linspace(n1,n2,(n2-n1)*resolution+1))';
    plot(yy1c(:,1), -yy1c(:,2),'linewidth',2,'color',outline_color)
    
    %plot nose tip
    points_nosetip2 = points_nose_tip;
    n1 = 1;
    n2 = 3;
    resolution = 50;   
    t1c = [n1:1:n2];
    z1c = [points_nosetip2(n1:n2,1) points_nosetip2(n1:n2,2)]';
    pp1c = spline(t1c,z1c);
    yy1c = ppval(pp1c, linspace(n1,n2,(n2-n1)*resolution+1))';
    plot(yy1c(:,1), -yy1c(:,2),'linewidth',2,'color',outline_color)
    
    %plot nostrils
    points_nostrils2 = points_nostrils(1:3,:);
    n1 = 1;
    n2 = 3;
    resolution = 50;   
    t1c = [n1:1:n2];
    z1c = [points_nostrils2(n1:n2,1) points_nostrils2(n1:n2,2)]';
    pp1c = spline(t1c,z1c);
    yy1c = ppval(pp1c, linspace(n1,n2,(n2-n1)*resolution+1))';
    plot(yy1c(:,1), -yy1c(:,2),'linewidth',2,'color',outline_color)

    points_nostrils2 = points_nostrils([4:6],:);
    n1 = 1;
    n2 = 3;
    resolution = 50;   
    t1c = [n1:1:n2];
    z1c = [points_nostrils2(n1:n2,1) points_nostrils2(n1:n2,2)]';
    pp1c = spline(t1c,z1c);
    yy1c = ppval(pp1c, linspace(n1,n2,(n2-n1)*resolution+1))';
    plot(yy1c(:,1), -yy1c(:,2),'linewidth',2,'color',outline_color)
    
    
    %plot mouth
    points_mouth2 = points_mouth([6 1 2 3 10],:);
    n1 = 1;
    n2 = 5;
    resolution = 50;   
    t1c = [n1:1:n2];
    z1c = [points_mouth2(n1:n2,1) points_mouth2(n1:n2,2)]';
    pp1c = spline(t1c,z1c);
    yy1c = ppval(pp1c, linspace(n1,n2,(n2-n1)*resolution+1))';
    
    plot(yy1c(:,1), -yy1c(:,2),'linewidth',2,'color',outline_color)
    
    points_mouth2 = points_mouth([6 8 10],:);
    n1 = 1;
    n2 = 3;
    resolution = 50;   
    t1c = [n1:1:n2];
    z1c = [points_mouth2(n1:n2,1) points_mouth2(n1:n2,2)]';
    pp1c = spline(t1c,z1c);
    yy1c = ppval(pp1c, linspace(n1,n2,(n2-n1)*resolution+1))';
    
    yy1c_ = yy1c;
    plot(yy1c(:,1), -yy1c(:,2),'linewidth',2,'color',outline_color)
    
    
    %bottom of upper lip
    points_mouth2 = points_mouth([6 7 4 9 10],:);
    n1 = 1;
    n2 = 5;
    resolution = 50;   
    t1c = [n1:1:n2];
    z1c = [points_mouth2(n1:n2,1) points_mouth2(n1:n2,2)]';
    pp1c = spline(t1c,z1c);
    yy1c = ppval(pp1c, linspace(n1,n2,(n2-n1)*resolution+1))';
    plot(yy1c(:,1), -yy1c(:,2),'linewidth',2,'color',outline_color)
    
   fill([yy1c_(:,1); yy1c(end:-1:1,1)],-[yy1c_(:,2); yy1c(end:-1:1,2)],'k'); %fill gap between lips
    
   
   %connect mouth corners
   plot([points_mouth(5,1) points_mouth(6,1)], [-points_mouth(5,2) -points_mouth(6,2)], 'linewidth',2,'color',outline_color);
   plot([points_mouth(10,1) points_mouth(11,1)], [-points_mouth(10,2) -points_mouth(11,2)], 'linewidth',2,'color',outline_color);
   points_mouth2 = points_mouth([5 14 13 12 11],:);
    
   %adjust first and last points of mouth to be half-way between 5/6 and 10/11
   points_mouth2(1,:) = .5*points_mouth(5,:) + .5*points_mouth(6,:);
   points_mouth2(5,:) = .5*points_mouth(10,:) + .5*points_mouth(11,:);
   n1 = 1;
   n2 = 5;
   resolution = 50;
   t1c = [n1:1:n2];
   z1c = [points_mouth2(n1:n2,1) points_mouth2(n1:n2,2)]';
   pp1c = spline(t1c,z1c);
   yy1c = ppval(pp1c, linspace(n1,n2,(n2-n1)*resolution+1))';
   plot(yy1c(:,1), -yy1c(:,2),'linewidth',2,'color',outline_color)
   
   
   axis equal
   axis off
   
end