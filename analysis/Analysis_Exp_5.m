%% Script to analyse prisoner's dilemma study one-shot online (Exp 5)

clear all
clc

cd('')


%{
%% Save data for sharing publically
% For privacy reasons (e.g., Prolific ID), we do not share the entire raw 
% data, but the code in format_data_Exp_5 shows how we go from raw data to 
% the published data
% Import the data
data_5 = xlsread('data_LT_PD_5');

%% Clean and format the data
[d, Q, C1, C2, C3, C4, C5] = format_data_Exp_5(data_5);

clear data_5
save('data_Exp5')
% Also save a CSV for people who don't use Matlab
writematrix(d, 'data_Exp5.csv')
%}

load('data_Exp5.mat')

%{
1:  Age
2:  Gender (1 = female, 2 = male, 3 = diverse, 4 = prefer not to say)
3:  Category
4:  Test Q1 (correct response = 4)
5:  Test Q2 (correct response = 2)
6:  Test Q3 (correct response = 1)
7:  Test Q4 (correct response = 3)
8:  Decision Prisoner's Dilemma (0 = Cooperate, 1 = Defect)
9:  NaN
10: NaN
11: Expectation Prisoner's Dilemma (0 = Definitely cooperate, 100 = Definitly defect)
12: NaN
13: NaN
14: Utility 1st highest outcome
15: Utility 2nd highest outcome
16: Utility 3rd highest outcome
17: Utility 4th highest outcome
18: Loss avoidance PD
19: Loss aversion  PD
20: NaN
21: NaN
22: NaN
23: NaN
%}

%% Plot cooperation rates for the 5 categories
plot_cooperation_rate(C1, C2, C3, C4, C5, 'PD', '5', 0)

%% Analyses (not preregistered, but same as before)
game = 8;

% Loss avoidance:
% (c1, c3, c5) > (c2, c4), with chi-squared
results.h1 = chi_squared([C1(:,game); C3(:,game); C5(:,game)], [C2(:,game); C4(:,game)]);

% Loss aversion:
% c1 > c5, with chi-squared
results.h2 = chi_squared(C1(:,game), C5(:,game));

%% Demographics
age.mean    = mean(d(:,1), 'omitnan');
age.std     = std(d(:,1), 'omitnan');

gender.female   = (sum(d(:,2) == 1)/length(d))*100;
gender.male     = (sum(d(:,2) == 2)/length(d))*100;
gender.divers   = (sum(d(:,2) == 3)/length(d))*100;
gender.not_say  = (sum(d(:,2) == 4)/length(d))*100;

%% Logistic regression

% Prisoner's Dilemma
coop_PD = d(:,8); avoid_PD = d(:,18); averse_PD = d(:,19); exp_PD = d(:,11);
T = table(coop_PD, avoid_PD, averse_PD, exp_PD);
modelspec_1_PD = 'coop_PD ~ avoid_PD + averse_PD';
modelspec_2_PD = 'coop_PD ~ avoid_PD + averse_PD + exp_PD';
model_1_PD = fitglm(T, modelspec_1_PD, 'Distribution', 'binomial');
model_2_PD = fitglm(T, modelspec_2_PD, 'Distribution', 'binomial');

%% Explicit utility ratings
utils = calc_utils(C1, C2, C3, C4, C5);
plot_utils(utils, 5)

% Compare loss avoidance and non-loss avoidance steps in utility (loss avoidance)
[~,results.e1.p,results.e1.ci,results.e1.stats] = ttest2(utils.gaps_lossAvoidance, utils.gaps_NolossAvoidance);
results.e1.d = cohens_d_ttest_between(utils.gaps_NolossAvoidance,utils.gaps_lossAvoidance);

% Compare steepness in gain and loss domain (loss aversion)
[~,results.e2.p,results.e2.ci,results.e2.stats] = ttest2(utils.steep_loss, utils.steep_gain);
results.e2.d = cohens_d_ttest_between(utils.steep_gain,utils.steep_loss);

%% Expectation of what the other will do
plot_expectation_other(C1, C2, C3, C4, C5, 'PD', '5')
