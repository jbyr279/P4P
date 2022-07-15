% function [traj3Drot] = rotateAxis(traj3D, theta, axis)
%     if (axis == "overhead")
%         % x axis rotation 
%         A = [1 0 0; 
%             0 cosd(theta) -sind(theta); 
%             0 sind(theta) cosd(theta)];
%         traj3Drot = A*traj3D;
%         % z axis rotation
%     elseif (axis == "profile")
%         A = [cosd(theta) -sind(theta) 0; 
%             sind(theta) cosd(theta) 0; 
%             0 0 1];

function [traj3Drot] = rotateAxis(traj3D, theta, vp)
    if (vp == "overhead")
        A = [1 0 0; 0 cosd(theta) -sind(theta); 0 sind(theta) cosd(theta)];
        traj3Drot = A*traj3D; 
    elseif (vp == "profile")
        A = [cosd(theta) sind(theta) 0; -sind(theta) cosd(theta) 0; 0 0 1];
        traj3Drot = A*traj3D;
    end 
end