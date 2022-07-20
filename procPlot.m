clear
clc
close all

% START IN P4P DIRECTORY %

rand = true; %% Randomised blocking => rand = true

if rand
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


res = cell(1, 2); % Eccentricity results
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
        for j = 1:length(res)
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

degradation = [2, 4, 8, 12, 16, 20, 24];
theta_v = [90, 120, 150, 180];
ecc = [0, 40];

labels = [];

figure('Position', [100 60 1700 900]);
tiledlayout(2,2,"Title",title_);

for j = 1:length(res)
    nexttile
    for k = 1:length(theta_v)
        
        title(sprintf("%d^o Peripheral Eccentricity ", (j-1)*ecc(2)));

        
        plot(degradation, res{j}(k, :));
        ylim([-0.1 1.1]);
        xlim([0 40]);
        
        if j == 1
            labels = [labels, (sprintf(" {\\theta}_v  =  %.2f deg", theta_v(k) - 90))];
        end

        if k == length(theta_v)
            yline(0.25, 'LineStyle','--');
        end

        if j == 1 && k == length(theta_v)
            labels = [labels, (" Guess rate: 25.00%")];
        end
        xlabel("Number of Nodes, {\eta}_d");
        ylabel("Success Rate, {\rho}");
        hold on
    end
    legend(labels)
    hold off
end

labels = [];
nexttile([1 2]);

ylim([-0.1 1.1]);
xlim([0 40]);

for i = 1:length(res)
    
    avg = mean(res{i},1);
    plot(degradation, avg);
    
    labels = [labels, sprintf(" %d^o Peripheral Eccentricity Mean, {\\mu}_e, where Standard Deviation, {\\sigma} = %.2f", (i-1)*ecc(2), std(avg))];

    hold on
end

ylim([-0.1 1.1]);
xlim([0 40]);

yline(0.25, 'LineStyle','--');
hold off
legend(labels)

cd ..
