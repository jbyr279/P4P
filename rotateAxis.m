function [traj3Drot] = rotateAxis(traj3D, theta, axis)
    if (axis == "overhead")
        A = [1 0 0; 0 cos(theta) -sin(theta); 0 sin(theta) cos(theta)];
        traj3Drot = A*traj3D; 
    elseif (axis == "profile")
        A = [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; 0 0 1];
        traj3Drot = A*traj3D;
    end 
end