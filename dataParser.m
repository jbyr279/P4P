function standardCell = dataParser(randomisedTrials, theta_v, degradation, eccentricity)
    % Convert to 4x4 standard
    standardArray = zeros([length(theta_v), length(degradation)]); % zeros(4)
    standardCell = cell(1, length(eccentricity));

    for i = 1:length(standardCell)
        standardCell{i} = standardArray;
    end

    for i = 1:length(randomisedTrials)
        dot_index = mapDegradation(randomisedTrials{i}.degradation);%randomisedTrials{i}.degradation/min(degradation);
        theta_index = randomisedTrials{i}.theta_v/30 - 2;
        eccent_index = randomisedTrials{i}.eccentricity/eccentricity(2) + 1;
        standardCell{eccent_index}(theta_index, dot_index) = standardCell{eccent_index}(theta_index, dot_index) + randomisedTrials{i}.correct;
    end
end

function index = mapDegradation(dots)
    if dots == 2
        index=1;
    else
        index = dots/4 + 1;
    end
end

    
    