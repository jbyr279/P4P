clear
clc
close all

% START IN P4P DIRECTORY %

rand = true; %% Randomised blocking => rand = true

if rand
    cd 'C:\Users\joeby\P4P'
    subs = {dir(fullfile('PrelimTrialData','*.mat')).name};
    noSubs = length(subs);
else
    cd 'C:\Users\joeby\P4P\PrelimTrialData'
    files = dir;
    dirFlags = [files.isdir];
    subFolders = files(dirFlags);
    subFolderNames = {subFolders(3:end).name};
    
    cd(subFolderNames{1});
    noSubs = length(dir) - 2;
    
    files = dir;
    subNames = {files(3:end).name};
    
    cd ..
end 


res = cell(1, 4); % Eccentricity results
store = zeros([4, 7]); % Subj. results
totalTrials = 0;

for i = 1:length(res)
    res{i} = store;
end

title_ = matlab.graphics.layout.Text;
title_.FontWeight = 'bold';

if rand
    cd PrelimTrialData
    
    for i = 1:noSubs
        load(subs{i})
        for j = 1:4
            res{j} = res{j} + matrix{j};
        
            if j == 1            
                totalTrials = totalTrials + num_trials;
            end
        end 
    end
    title_.String = "Randomized Blocking Trials";
else 
    for j = 1:length(subFolderNames)
        cd(subFolderNames{j});
        for i = 1:noSubs
            load(subNames{i})
    
            res{j} = res{j} + matrix;
    
            if j == length(subFolderNames)
                totalTrials = totalTrials + num_trials;
            end
    
        end
        cd ..
    end
    title_.String = "Unrandomized Blocking Trials";
end


% Averaging the results
for i = 1:length(res)
    res{i} = res{i} / totalTrials;
end

degradation = [4, 8, 12, 16, 20, 24, 28];
theta_v = [90, 120, 150, 180];

labels = [];

figure('Position', [400 60 1200 900]);
tiledlayout(2,2,"Title",title_);

for j = 1:length(res)
    nexttile
    for k = 1:length(theta_v)
        
        if rand
            title(sprintf("Angle%d", (j-1)*20));
        else
            title(subFolderNames{j});
        end

        plot(degradation, res{j}(k, :));
        ylim([-0.1 1.1]);
        if j == 1
            labels = [labels, (sprintf(" {\\theta}_v  =  %.2f deg", theta_v(k) - 90))];
        end

        if k == length(theta_v)
            yline(0.25, 'LineStyle','--');
        end

        if j == 1 && k == length(theta_v)
            labels = [labels, (" Guess rate: 25.00%")];
        end

        hold on
    end
    legend(labels, 'Location','southeast')
    hold off
end

