mu = 3.4;    


sample=[3.4, 3.6, 3.8, 3.3, 3.4, 3.5, 3.7, 3.6, 3.7]

n = numel(sample)

xobs = mean(sample)  

s = std(sample)      

t = (xobs - mu)/(s/sqrt(n))

p = 1-tcdf(t,n-1)

[h,ptest] = ttest(sample,mu,0.05,'right')