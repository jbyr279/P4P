function standardArray = dataParser(randomisedTrials)
    
    standardArray = zeros(4);
    for i = 1:length(randomisedTrials)
        row = randomisedTrials{i}.degradation/7;
        col = randomisedTrials{i}.theta_v/30 - 2;
        standardArray(row, col) = randomisedTrials{i}.correct;
    end
end
    
    