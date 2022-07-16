% Load in trajectory data
function trajData = getTrajData(visibleMarkers, viewpointAngle, directory, scale)
    trajFiles = dir(directory);
    
    remove = 28 - visibleMarkers;
    randIndex = randperm(length(trajFiles), remove);
    index = 1;
    
    for i=1:length(trajFiles)
        
        if ~(ismember(i, randIndex))
            trajData{1,index} = trajFiles(i).name;
            trajData{2,index} = load(['TrajectoryData/', trajFiles(i).name]);
    
            data = trajData{2,index}.array;
            data(4,:) = [];
            transData = rotateAxis(data, viewpointAngle, "profile");
            trajData{2,index}.array = transData;
            trajData{2,index}.array(1, :) = trajData{2,index}.array(1, :) + scale*(-4.5*viewpointAngle + 805);
    
            index = index + 1;
        end
    end
end