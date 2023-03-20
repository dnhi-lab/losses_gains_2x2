% The data was counted by hand from the sheets that participants filled in,
% put into Excel and then added here

clear all
clc

% Run chi-squared test
n1 = 33; N1 = 52;
n2 = 12; N2 = 31;
x1 = [repmat('a',N1,1); repmat('b',N2,1)];
x2 = [repmat(1,n1,1); repmat(2,N1-n1,1); repmat(1,n2,1); repmat(2,N2-n2,1)];
[results.tbl,results.chi2stat,results.pval] = crosstab(x1,x2);

% Calculate total N of participants
results.N_total = N1+N2;

% Calculate cooperation rates
results.M1 = (n1/N1)*100;
results.M2 = (n2/N2)*100;

% Calculate effect size (phi for a 2x2)
results.phi = sqrt(results.chi2stat/(results.N_total));

%% Plot cooperation rates for each category

% Cooperation % from Excel
AllPos      = 50;
Spec1       = 47;
Midd        = 75;
Spec2       = 31;
AllNeg      = 63;
five_categories = [AllPos Spec1 Midd Spec2 AllNeg];

x = 1:5;
data = five_categories;
N = [16 15 20 16 16];
error = [SEM_binary(N(1)) SEM_binary(N(2)) SEM_binary(N(3)) SEM_binary(N(4)) SEM_binary(N(5))]';

figure
hold on
for y = 10:10:90
    line([0,6],[y,y])
end
b = bar(x,data);
hold off
hold on
er = errorbar(x,data,error);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
hold off
ylim([0 100])
set(gca,'TickLength',[0,0])
ylabel('Cooperation % (+SEM)')
xlabel(['Payoff matrix category (N of participants)'])
xticklabels({'' 'C1 (16)' 'C2 (15)' 'C3 (20)' 'C4 (16)' 'C5 (16)'})
xtickangle(45)
title('Experiment 4: Prisoner''s Dilemma')

%{
%% Counts for collating data from different experiments
% Only needs to be done once (I took the defect Ns straight from Excel)
PD_Ex4.AllPos = [8 N(1)];
PD_Ex4.Spec1 = [8 N(2)];
PD_Ex4.Midd = [5 N(3)];
PD_Ex4.Spec2 = [11 N(4)];
PD_Ex4.AllNeg = [6 N(5)];

save('PD_Ex4.mat', 'PD_Ex4')
%}
