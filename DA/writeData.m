addpath PrelimTrialData\

procPlot;
close all
clearvars -except res

deg = [2 4 8 12 16 20 24];
theta_v = [0 30 60 90];
ecc = [0 40];

subs = {dir(fullfile('PrelimTrialData','*.mat')).name};
noSubs = length(subs);

format = '%6s %6s %6s\n';

fileNameVP{1} = 'resVP00.txt';
fileNameVP{2} = 'resVP30.txt';
fileNameVP{3} = 'resVP60.txt';
fileNameVP{4} = 'resVP90.txt';

fileID = zeros([1 4]);

for i = 1:length(fileNameVP)
    fileID(i) = fopen(fileNameVP{i},'w');
end

for i = 1:length(fileNameVP)
    fprintf(fileID(i), format, 'rate', 'deg', 'ecc');
end

format = '%6.2f %6.2f %6.2f\n';

for v = 1:length(theta_v)
    for e = 1:length(ecc)
        for d = 1:length(deg)
            fprintf(fileID(v), format, res{e}(v,d), deg(d), ecc(e));
        end
    end
end

for i = 1:length(fileNameVP)
    fclose(fileID(i));
    edit(fileNameVP{i});
end
