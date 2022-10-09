clear
% close all

NOISE = [2 4 8 12 16 20 24];
NOISE_ = linspace(0,max(NOISE),1000);

load("total_fourty.mat")
load("total_zero.mat")

DATA = totalFourtyArray;

fnBound = @(bhat) 1/(eps+double((bhat(1) > 0) & (bhat(2) > 0)));
fnPsychometric = @(lam,k,x) 0.25 + 0.75*(1 - exp(-power(max(0,x)/lam,k)));
fnCost = @(bhat) sum(power(fnPsychometric(bhat(1),bhat(2),NOISE) - mean(DATA,1),2)) * fnBound(bhat);

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

% BHAT0 = [1 5];
% [bhat,fval] = fminsearch(fnCost, BHAT0);


PM_ = fnPsychometric(bhat(1),bhat(2),NOISE_);
figure; hold on
plot(NOISE, mean(DATA,1), 'ok', 'MarkerFaceColor', 'k'); axis square
for ii = 1:length(NOISE)
  [~,pci] = binofit(sum(DATA(:,ii)), size(DATA,1));
  plot([NOISE(ii) NOISE(ii)], pci, '-k')
end
plot(NOISE_, PM_, '-b')

title("0^o Psychometric Curve")
if DATA == totalFourtyArray
    title("40^o Psychometric Curve")
end

plot([min(NOISE) max(NOISE)], [0.25 0.25], '--k')
axis square
axis([0 max(NOISE)+1 0 1])
xlabel('Number of Visible Nodes ')
ylabel('Performance (proportion correct responses)')


% Determine threshold, that is, where the fitted function = 0.75
plot(NOISE_(min(find(PM_ > 0.625))), 0.625, 'sb', 'MarkerFaceColor', 'blue')