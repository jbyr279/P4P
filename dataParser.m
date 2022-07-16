function standardArray = dataParser(randomisedTrials)
    % Convert to 4x4 standard
    standardArray = zeros(4);
    for i = 1:length(randomisedTrials)
        dot_index = randomisedTrials{i}.degradation/7;
        theta_index = randomisedTrials{i}.theta_v/30 - 2;
        standardArray(theta_index, dot_index) = randomisedTrials{i}.correct;
    end
end
    
    