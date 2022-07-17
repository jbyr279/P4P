function trial_rand_1D = randomiseTrials(theta_v, degradation)
    current_trials = cell(size(degradation,2), size(theta_v,2));

    for i = 1:size(degradation,2)
        for j = 1:size(theta_v,2)
            current_trials{i, j}.degradation = degradation(i);
            current_trials{i, j}.theta_v = theta_v(j);
            current_trials{i, j}.correct = false;
            current_trials{i, j}.inputKey = "";
        end
    end
    
    len = size(degradation,2) * size(theta_v,2);
    current_trials = reshape(current_trials,[1,len]);
    
    trial_rand_1D = current_trials(randperm(length(current_trials)));
end