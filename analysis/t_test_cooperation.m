function s = t_test_cooperation(a, b)
% Calculate whether there is a statistically significant difference between
% two categories of payoff matrices

% Descriptives
s.a_mean = mean(a)*100;
s.b_mean = mean(b)*100;
s.a_std = std(a)*100;
s.b_std = std(b)*100;

% Run the t-test (within)
[s.h, s.p, s.ci, s.stats] = ttest(a, b);

s.CohensD = (s.a_mean - s.b_mean)/(sqrt((s.a_std^2+s.b_std^2)/2));

%s.CohensDRosenthal = s.stats.tstat/sqrt(length(a));

end
