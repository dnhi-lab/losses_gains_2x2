function results = chi_squared(var1,var2)

% Format data
n1 = sum(var1);   N1 = size(var1,1);
n2 = sum(var2);   N2 = size(var2,1);
x1 = [repmat('a',N1,1); repmat('b',N2,1)];
x2 = [repmat(1,n1,1);   repmat(2,N1-n1,1); repmat(1,n2,1); repmat(2,N2-n2,1)];

% Run chi-squared test
[results.tbl,results.chi2stat,results.pval] = crosstab(x1,x2);

% Calculate effect size (phi for a 2x2)
results.phi = sqrt(results.chi2stat/(N1+N2));

% Calculate mean cooperation rates for each group
results.M1 = 100 - (n1/(N1))*100;
results.M2 = 100 - (n2/(N2))*100;

end
