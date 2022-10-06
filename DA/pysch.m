% Columns are stimulus noise, 1 to 7 with noise increasing from
% L to R. Rows are experimental subject.

load("total_fourty.mat")
load("total_zero.mat")

DATA = totalFourtyArray;

NOISE = [2 4 8 12 16 20 24];
NOISE_ = linspace(min(NOISE),max(NOISE),1000);

% Define functions used in the fit, including fnBound() which is used
% to determine the sensible range of fitted parameters.
fnBound = @(bhat) 1/(eps+double((bhat(1) < 0) & (bhat(1) > 3) & (bhat(2) < 2) & (bhat(2) > 6)));
fnPsychometric = @(mu,sd,x) 0.25 + 0.375*(1 + erf((x-mu)/(sd*sqrt(2))));
fnCost = @(bhat) sum(power(fnPsychometric(bhat(1),bhat(2),NOISE - max(NOISE)) - mean(DATA,1),2)) * fnBound(bhat);

% This is a multi-start procedure. We perform the fit 1000 times, using
% different starting parameters each time, and keep track of which of those
% multi-starts ultimately produces the best fit.
best_fval = 1/eps;
for iistart = 1:1000
  BHAT0 = [3 1];
  if (iistart > 1)
    BHAT0 = [2+4*rand() 3*rand()];
  end
  [bhat,fval] = fminsearch(fnCost, BHAT0);
  if (fval < best_fval)
    best_fval = fval;
    best_bhat = bhat;
  end
end

figure; hold on
plot(NOISE, mean(DATA,1), 'ok', 'MarkerFaceColor', 'black');
% Confidence intervals at each level of noise...
for ii = 1:length(NOISE)
  [~,pci] = binofit(sum(DATA(:,ii)), size(DATA,1));
  plot([NOISE(ii) NOISE(ii)], pci, '-k')
end
% Plot fitted psychometric function
PM_ = fnPsychometric(best_bhat(1),best_bhat(2),NOISE_ - max(NOISE_));
plot(NOISE_, PM_, '-b')
plot([min(NOISE) max(NOISE)], [0.25 0.25], '--k')
axis square
axis([0 max(NOISE)+1 0 1])
xlabel('Number of Visible Nodes ')
ylabel('Performance (proportion correct responses)')

% Determine threshold, that is, where the fitted function = 0.75
plot(NOISE_(min(find(PM_ > 0.625))), 0.625, 'sb', 'MarkerFaceColor', 'blue')

