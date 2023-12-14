function study = randomisePOMorder(study)
rand('seed', sum(100 * clock));
a=study.POM.val;
n=numel(a);
b=randperm(n);
study.POM.randomOrder=a(b);
end