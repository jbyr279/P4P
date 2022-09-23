function pci = bootstrap(data)
% Data input is the overall success matrix for one given eccentricity and
% one given degredation
    
    NBOOT = 1000;
    Bmean = zeros(NBOOT,1);
    for iiboot = 1:NBOOT

        ix = ceil(length(data) * rand(length(data),1));
        data_ = data(ix);
        Bmean(iiboot) = mean(data_);

    end
    pci = prctile(Bmean, [2.5 97.5]);
end 