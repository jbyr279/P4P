addpath PrelimTrialData\

procPlot;
close all
clearvars -except res

deg = [2 4 8 12 16 20 24];
theta_v = [0 30 60 90];
ecc = [0 40];

subs = {dir(fullfile('PrelimTrialData','*.mat')).name};
noSubs = length(subs);

format = '%6s %6s %6s %6s\n';
fileName = 'res.txt';

fileID = fopen(fileName,'w');
fprintf(fileID, format, 'rate', 'vp', 'deg', 'ecc');

format = '%6.2f %6.2f %6.2f %6.2f\n';

for dim = 1:length(ecc)
    for col = 1:length(deg)
        for row = 1:length(theta_v)
            fprintf(fileID, format, res{dim}(row,col), theta_v(row), deg(col), ecc(dim));
        end
    end
end

fclose(fileID);
edit(fileName);






