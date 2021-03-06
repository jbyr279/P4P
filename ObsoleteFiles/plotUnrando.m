clear
clc
close all

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

res = cell(1, length(subFolderNames)); % Eccentricity results
store = zeros([4, 7]); % Subj. results
totalTrials = 0;

for i = 1:length(res)
        res{i} = store;
end

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

% Averaging the results
for i = 1:length(res)
    res{i} = res{i} / totalTrials;
end

degradation = [4, 8, 12, 16, 20, 24, 28];
theta_v = [90, 120, 150, 180];

labels = [];

tiledlayout(2,2)

for j = 1:length(res)
    nexttile
    for k = 1:length(theta_v)
        title(subFolderNames{j});
        plot(degradation, res{j}(k, :));
        ylim([-0.1 1.1]);
        if j == 1
            labels = [labels, (sprintf("Viewpoint angle: %.2f deg", theta_v(k) - 90))];
        end

        hold on
    end
    legend(labels, 'Location','southeast')
    hold off
end

