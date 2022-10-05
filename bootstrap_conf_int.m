
% % for one eccentricity, for one number-of-nodes, imagine you had data for 80 trials where 1 is correct and 0 is incorrect
% data = [ 1 1 1 0 1 1 0 1 1 1 1 1 0 1 0 0 0 0 1 0 0 0 1 1 0 1 0 0 0 1 1 1 1 0 0 1 1 0 1 1 1 0 0 1 1 0 0 0 0 0 0 1 0 0 1 0 1 1 0 1 1 1 1 0 0 0 0 1 0 0 0 1 1 0 1 1 0 1 0 0];
% 
% load("total_fourty.mat")
% load("total_zero.mat")
% 
% data = totalFourtyArray(:,1);
% 
% % the mean success rate is this
% mean(data)
% 
% % the 95% confidence intervals for your estimate of the mean can be computed with bootstrapping
% NBOOT = 1000;
% Bmean = zeros(NBOOT,1);
% for iiboot = 1:NBOOT
%   ix = ceil(length(data) * rand(length(data),1));
%   data_ = data(ix); % resample _with_ replacement
%   Bmean(iiboot) = mean(data_);
% end
% prctile(Bmean, [2.5 97.5])

% ****************************************************** %
clear

load("total_fourty.mat")
load("total_zero.mat")

DATA = totalFourtyArray;
for dat = 1:2
    for NBOOT = 1:100
        for deg = 1:size(DATA,2)
            data = DATA(:, deg);
            ix = ceil(length(data) * rand(length(data),1));
            data_{dat}(:, deg) = data(ix); % resample _with_ replacement
        end
        crit(NBOOT, dat) = psychFit(data_{dat});
    end
    DATA = totalZeroArray;
end

confint40 = prctile(crit(:, 1), [2.5 97.5]);
confint0 = prctile(crit(:, 2), [2.5 97.5]);
























