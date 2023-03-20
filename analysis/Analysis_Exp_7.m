%% Script to analyse Chicken, stag-hunt & prisoner's dilemma study (Exp 7)

clear all
clc

cd('')

%{
%% Save data for sharing publically
% For privacy reasons (e.g., Prolific ID), we do not share the entire raw 
% data, but the code in format_data_Exp_5 shows how we go from raw data to 
% the published data

% Import the data
data_7 = xlsread('data_LT_PD_7');

%% Clean and format the data
[d, Q, C1, C2, C3, C4, C5] = format_data_Exp_7(data_7);

clear data_7
save('data_Exp7')
% Also save a CSV for people who don't use Matlab
writematrix(d, 'data_Exp7.csv')
%}

load('data_Exp7.mat')

%{
1:  Age
2:  Gender
3:  Category
4:  Test Q1 (correct response = 1)
5:  Test Q2 (correct response = 2)
6:  NaN
7:  NaN
8:  Decision Prisoner's Dilemma (PD)
9:  Decision Stag-Hunt (SH)
10: Decision Chicken (CH)
11: Expectation Prisoner's Dilemma (100 = cooperation)
12: Expectation Stag-Hunt
13: Expectation Chicken
14: Utility 1st highest outcome
15: Utility 2nd highest outcome
16: Utility 3rd highest outcome
17: Utility 4th highest outcome
18: Loss avoidance PD
19: Loss aversion  PD
20: Loss avoidance SH
21: Loss aversion  SH
22: Loss avoidance CH
23: Loss aversion  CH
%}

%% Plot cooperation rates for the 5 categories for each game
plot_cooperation_rate(C1, C2, C3, C4, C5, 'PD', '7', 0)
plot_cooperation_rate(C1, C2, C3, C4, C5, 'SH', '7', 0)
plot_cooperation_rate(C1, C2, C3, C4, C5, 'CH', '7', 0)

%% Preregistered hypotheses Chicken
game = 10;

% Loss avoidance:
% c4 < c2, with chi-squared
results.h1 = chi_squared(C2(:,game), C4(:,game));
% (c1, c3, c5) < c2, with chi-squared
results.h2 = chi_squared([C1(:,game); C3(:,game); C5(:,game)], C2(:,game));
% (c1, c3, c5) > c4, with chi-squared
results.h3 = chi_squared([C1(:,game); C3(:,game); C5(:,game)], C4(:,game));

% Loss aversion:
% (c1, c5) < c3, with chi-squared
results.h4 = chi_squared([C1(:,game); C5(:,game)], C3(:,game));

%% Preregistered hypotheses Stag Hunt
game = 9;

% Loss avoidance:
% c4 > c2, with chi-squared
results.h5 = chi_squared(C2(:,game), C4(:,game));
% (c1, c3, c5) > c2, with chi-squared
results.h6 = chi_squared([C1(:,game); C3(:,game); C5(:,game)], C2(:,game));
% (c1, c3, c5) < c4, with chi-squared
results.h7 = chi_squared([C1(:,game); C3(:,game); C5(:,game)], C4(:,game));

% Loss aversion:
% (c1, c5) > c3, with chi-squared
results.h8 = chi_squared([C1(:,game); C5(:,game)], C3(:,game));

%% Preregistered hypotheses Prisoner's Dilemma
game = 8;

% Loss avoidance:
% (c1, c3, c5) > (c2, c4), with chi-squared
results.h9 = chi_squared([C1(:,game); C3(:,game); C5(:,game)], [C2(:,game); C4(:,game)]);

% Loss aversion:
% c1 > c5, with chi-squared
results.h10= chi_squared(C1(:,game), C5(:,game));

%% Demographics
age.mean    = mean(d(:,1), 'omitnan');
age.std     = std (d(:,1), 'omitnan');

gender.female   = (sum(d(:,2) == 1)/length(d))*100;
gender.male     = (sum(d(:,2) == 2)/length(d))*100;
gender.divers   = (sum(d(:,2) == 3)/length(d))*100;
gender.not_say  = (sum(d(:,2) == 4)/length(d))*100;

%% Logistic regression

% Chicken
coop_CH = d(:,10); avoid_CH = d(:,22); averse_CH = d(:,23); exp_CH = d(:,13);
T = table(coop_CH, avoid_CH, averse_CH, exp_CH);
modelspec_1_CH = 'coop_CH ~ avoid_CH + averse_CH';
modelspec_2_CH = 'coop_CH ~ avoid_CH + averse_CH + exp_CH';
modelspec_3_CH = 'coop_CH ~ (avoid_CH + averse_CH) * exp_CH';
model_1_CH = fitglm(T, modelspec_1_CH, 'Distribution', 'binomial');
model_2_CH = fitglm(T, modelspec_2_CH, 'Distribution', 'binomial');
model_3_CH = fitglm(T, modelspec_3_CH, 'Distribution', 'binomial');

% Stag-Hunt
defect_SH = d(:,9); avoid_SH = d(:,20); averse_SH = d(:,21); exp_SH = d(:,12);
T = table(defect_SH, avoid_SH, averse_SH, exp_SH);
modelspec_1_SH = 'defect_SH ~ avoid_SH + averse_SH';
modelspec_2_SH = 'defect_SH ~ avoid_SH + averse_SH + exp_SH';
modelspec_3_SH = 'defect_SH ~ (avoid_SH + averse_SH) * exp_SH';
model_1_SH = fitglm(T, modelspec_1_SH, 'Distribution', 'binomial');
model_2_SH = fitglm(T, modelspec_2_SH, 'Distribution', 'binomial');
model_3_SH = fitglm(T, modelspec_3_SH, 'Distribution', 'binomial');

% Prisoner's Dilemma
coop_PD = d(:,8); avoid_PD = d(:,18); averse_PD = d(:,19); exp_PD = d(:,11);
T = table(coop_PD, avoid_PD, averse_PD, exp_PD);
modelspec_1_PD = 'coop_PD ~ avoid_PD + averse_PD';
modelspec_2_PD = 'coop_PD ~ avoid_PD + averse_PD + exp_PD';
modelspec_3_PD = 'coop_PD ~ (avoid_PD + averse_PD) * exp_PD';
model_1_PD = fitglm(T, modelspec_1_PD, 'Distribution', 'binomial');
model_2_PD = fitglm(T, modelspec_2_PD, 'Distribution', 'binomial');
model_3_PD = fitglm(T, modelspec_3_PD, 'Distribution', 'binomial');

%% Explicit utility ratings
utils = calc_utils(C1, C2, C3, C4, C5);
plot_utils(utils, 7)

% Compare loss avoidance and non-loss avoidance steps in utility (loss avoidance)
[~,results.e1.p,results.e1.ci,results.e1.stats] = ttest2(utils.gaps_lossAvoidance, utils.gaps_NolossAvoidance);
results.e1.d = cohens_d_ttest_between(utils.gaps_NolossAvoidance,utils.gaps_lossAvoidance);

% Compare steepness in gain and loss domain (loss aversion)
[~,results.e2.p,results.e2.ci,results.e2.stats] = ttest2(utils.steep_loss, utils.steep_gain);
results.e2.d = cohens_d_ttest_between(utils.steep_gain,utils.steep_loss);

%% Expectation of what the other will do
plot_expectation_other(C1, C2, C3, C4, C5, 'PD', '7')
plot_expectation_other(C1, C2, C3, C4, C5, 'SH', '7')
plot_expectation_other(C1, C2, C3, C4, C5, 'CH', '7')
