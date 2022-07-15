function trial_rand = populateCorrect(trial_rand, trial, inputKey)
    if (trial_rand{trial}.theta_v == 90)
        trial_rand{trial}.correct = (strcmp(inputKey, '1!'));
    elseif  (trial_rand{trial}.theta_v == 120)
        trial_rand{trial}.correct = (strcmp(inputKey, '2@'));
    elseif (trial_rand{trial}.theta_v == 150)
        trial_rand{trial}.correct = (strcmp(inputKey, '3#'));
    elseif (trial_rand{trial}.theta_v == 180)
        trial_rand{trial}.correct = (strcmp(inputKey, '4$'));
    end