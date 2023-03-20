%% Analyse Experiments 1-3

clear all
clc

cd('')

load('data_Exp_1_2_3.mat')

% Load the data
d = data.Exp_1_2_3;

% Clean the data (exclude 6 participants and any invalid/late trials)
[d, ps, demo] = exclude_participants_iterated(d);

ps_Exp1 = ps(ps < 100);
ps_Exp2 = ps(ps > 100 & ps < 200);
ps_Exp3 = ps(ps > 200);

exp1 = d(sum(d(:,3) == ps_Exp1,2) == 1,:);
exp2 = d(sum(d(:,3) == ps_Exp2,2) == 1,:);
exp3 = d(sum(d(:,3) == ps_Exp3,2) == 1,:);

%{
% Columns structure for all 3 iterated experiments
01: Which experiment
02: Which group (Exp1: 1-4, Exp2: 5-12, Exp3: 13-20)
03: Participant ID
04: Other player ID
05: Trial number overall (for this participant in entire study: 1-300)
06: Trial number in this block (1-60)
07: Trial number of this POM against this player (1-5 for Exp1, 1-3 for Exp 2-3)
08: Block number (1-5)
09: Who played row, who played columns (1 = self rows, other columns; 0 = self columns, other rows)
10: T for that trial
11: R for that trial
12: P for that trial
13: S for that trial
14: Which payoff matrix. Not sure I need this column, keep it NaN for now
15: Which base-POM (1 = {3, 1, -1, -2}, 2 = {6, 2, -2, -6} and 3 = {11, 3, -3, -11})
16: *a (0.5, 1, 2, 4)
17: +b
18: Which category of payoff matrix (C1-5)
19: Whether the category expects loss avoidance not (C2 & C4 = 1, others = 0)
20: Whether player pressed a button that trial (1 = yes, 0 = no)
21: Type of button press (0 = none, 1 = valid, 2 = invalid)
22: Response time (in s; of valid button press if multiple buttons pressed)
23: Response for that trial (1 = left, 2 = up, 3 = right, 4 = down)
24: Other"s response for that trial
25: Cooperate (1) or defect (0) on that trial
26: Other cooperate (1) or defect (0) on that trial
27: Outcome on this trial (1 = CC, 2 = CD, 3 = DC, 4 = DD)
28: Participant points that trial
29: Other points that trial
30: Previous decision self
31: Previous decision other
%}

%% Demographics
demo_exp1 = demographics(demo,ps_Exp1);
demo_exp2 = demographics(demo,ps_Exp2);
demo_exp3 = demographics(demo,ps_Exp3);

%% Experiment 1 analysis

% Sort data into the 5 categories
for iC = 1:5
    C1_5_Exp1{iC} = exp1(exp1(:,18) == iC,:);
end

% Combine C(2,4) and C(1,3,5)
data_Two   = [C1_5_Exp1{2}; C1_5_Exp1{4}];
data_Three = [C1_5_Exp1{1}; C1_5_Exp1{3}; C1_5_Exp1{5}];

% Separate each participants' data
for i = 1:length(ps_Exp1)
    d_2_4{i}   = data_Two(data_Two(:,3)         == ps_Exp1(i),:);
    d_1_3_5{i} = data_Three(data_Three(:,3)     == ps_Exp1(i),:);
    d_1{i}     = C1_5_Exp1{1}(C1_5_Exp1{1}(:,3) == ps_Exp1(i),:);
    d_5{i}     = C1_5_Exp1{5}(C1_5_Exp1{5}(:,3) == ps_Exp1(i),:);
end

% Calculate the mean cooperation rate per participant
for i = 1:length(ps_Exp1)
    d_2_4_part_mean(i)   = mean(d_2_4{i}    (:,25));
    d_1_3_5_part_mean(i) = mean(d_1_3_5{i}  (:,25));
    d_1_part_mean(i)     = mean(d_1{i}      (:,25));
    d_5_part_mean(i)     = mean(d_5{i}      (:,25));
end

% Run the t-test (and descriptives)
Exp_1_avoidance = t_test_cooperation(d_2_4_part_mean, d_1_3_5_part_mean);
Exp_1_aversion  = t_test_cooperation(d_1_part_mean,   d_5_part_mean);

% Create boxplots with individual data points for Appendix
boxplot_data_points(d, ps_Exp1, 1);

%% Experiment 2 analysis

%{
First, the preregistered analyses (https://osf.io/dzkqg)

LT in PD I
H1:     Participants will show loss aversion:
        In Matlab: Mean cooperation (C1 & C2) < mean cooperation
        (C1, C3 & C5), with t-test
H1.1:   No effect of base POM
####### In R: LME with base POM as predictor with the loss avoidance/no 
####### loss avoidance contrast won't perform better than without base POM 
####### as predictor
H1.2:   +b won't have an effect within category
####### In R: LME with +b as predictor with the loss avoidance/no loss 
####### avoidance contrast won't perform better than without +b as predictor
H1.3:   Effect of SVO
        In Matlab: correlation between SVO and loss avoidance (more
        individualistic -> stronger effect of loss avoidance), with linear regression 
        (ordinary least squares) with the effect from H1 (per participant) 
        as dependent variable and each participant’s SVO-angle as independent variable
H2:     More cooperation in C5 than in C1
        In Matlab: ALL- > ALL+ for cooperation rate, with t-test
H2.1:   No effect of base POM
####### In R: LME with base POM as predictor with the C5/C1 contrast
####### won't perform better than without base POM as predictor
H2.2:   +b won't have an effect within category
####### In R: LME with +b as predictor with the C5/C1 contrast won't
####### perform better than without +b as predictor
%}

% H1: t-test between C(2,4) and C(1,3,5)
% and
% H2: t-test between C1 and C5

% Sort data into the 5 categories
for iC = 1:5
    dd{iC} = exp2(exp2(:,18) == iC,:);
end

% Combine C(2,4) and C(1,3,5)
data_Two = [dd{2}; dd{4}];
data_Three = [dd{1}; dd{3}; dd{5}];

% Separate each participants' data
for i = 1:length(ps_Exp2)
    d_2_4{i}   = data_Two(data_Two(:,3)     == ps_Exp2(i),:);
    d_1_3_5{i} = data_Three(data_Three(:,3) == ps_Exp2(i),:);
    d_1{i}     = dd{1}(dd{1}(:,3)           == ps_Exp2(i),:);
    d_5{i}     = dd{5}(dd{5}(:,3)           == ps_Exp2(i),:);
end

% Calculate the mean cooperation rate per participant
for i = 1:length(ps_Exp2)
    d_2_4_part_mean(i)   = mean(d_2_4{i}    (:,25));
    d_1_3_5_part_mean(i) = mean(d_1_3_5{i}  (:,25));
    d_1_part_mean(i)     = mean(d_1{i}      (:,25));
    d_5_part_mean(i)     = mean(d_5{i}      (:,25));
end

% Run the t-test (and descriptives)
Exp_2_avoidance = t_test_cooperation(d_2_4_part_mean, d_1_3_5_part_mean);
Exp_2_aversion  = t_test_cooperation(d_1_part_mean,   d_5_part_mean);

% H1.3: linear regression to predict loss avoidance score from SVO score
% Load the SVO data (I used Ackermann's script to calculate SVO scores)
excluded_ps_Exp_2 = [116 135];
ps_og_Exp_2 = [111:116, 121:126, 131:136, 141:146, 151:156, 161:166, 171:176, 181:186];
SVO_loss_avoid_Exp_2 = SVO_loss(ps_og_Exp_2, excluded_ps_Exp_2, 2, d_2_4_part_mean, d_1_3_5_part_mean);

% Run H1.3 also for loss aversion
SVO_loss_avers_Exp_2 = SVO_loss(ps_og_Exp_2, excluded_ps_Exp_2, 2, d_5_part_mean, d_1_part_mean);

% Create boxplots with individual data points for Appendix
boxplot_data_points(d, ps_Exp2, 2);

%% Experiment 3 analysis

%{
First, the preregistered analyses (https://osf.io/z4geq)

H1:     Participants will show loss avoidance ():
        In Matlab: Mean cooperation (C2 & C4) < mean cooperation 
        (C1, C3 & C5), with two-way ANOVA
H1.1:   Effect of SVO
        In Matlab: correlation between SVO and loss avoidance (more
        individualistic -> stronger effect of loss avoidance), with linear regression 
        (ordinary least squares) with the effect from H1 (per participant) 
        as dependent variable and each participant’s SVO-angle as independent variable
H2:     No main effect of stake size on cooperation
        In Matlab: test effect of stake size on cooperation, with two-way 
        ANOVA, and if small: equivalence test
H3:     Interaction between loss avoidance and stake size
        In Matlab: more loss avoidance with larger stake sizes
%}

% H1, H2, and H3: all in one ANOVA
% Calculate the average cooperation rate per person for each combination of
% the 2 loss avoidance factors and the four levels of the stake size
% (basically, do the same as for Exp1 & 2, but for each level of stake size)
h1_2_3_stats = Exp_3_h_1_2_3_anova(exp3, ps_Exp3);

% Some variable names are identical in Experiments 2 and 3, so rerun the
% preprocessing before running the following sections

% H1.1 SVO and loss avoidance
% Run the linear regression
% Sort data into the 5 categories
for iC = 1:5
    dd{iC} = exp3(exp3(:,18) == iC,:);
end

% Combine C(2,4) and C(1,3,5)
data_Two = [dd{2}; dd{4}];
data_Three = [dd{1}; dd{3}; dd{5}];

% Separate each participants' data
for i = 1:length(ps_Exp3)
    d_2_4{i}   = data_Two(data_Two(:,3)     == ps_Exp3(i),:);
    d_1_3_5{i} = data_Three(data_Three(:,3) == ps_Exp3(i),:);
    d_1{i}     = dd{1}(dd{1}(:,3)           == ps_Exp3(i),:);
    d_5{i}     = dd{5}(dd{5}(:,3)           == ps_Exp3(i),:);
end

% Calculate the mean cooperation rate per participant
for i = 1:length(ps_Exp3)
    d_2_4_part_mean(i)   = mean(d_2_4{i}    (:,25));
    d_1_3_5_part_mean(i) = mean(d_1_3_5{i}  (:,25));
    d_1_part_mean(i)     = mean(d_1{i}      (:,25));
    d_5_part_mean(i)     = mean(d_5{i}      (:,25));
end

excluded_ps_Exp_3 = [231 246 253 255];
ps_og_Exp_3 = [211:216, 221:226, 231:236, 241:246, 251:256, 261:266, 271:276, 281:286];
SVO_loss_avoid_Exp_3 = SVO_loss(ps_og_Exp_3, excluded_ps_Exp_3, 3, d_2_4_part_mean, d_1_3_5_part_mean);

% Also run this for loss aversion
SVO_loss_avers_Exp_3 = SVO_loss(ps_og_Exp_3, excluded_ps_Exp_3, 3, d_5_part_mean, d_1_part_mean);


% Loss aversion test: C1 vs C5
Exp_3_aversion = t_test_cooperation(d_1_part_mean, d_5_part_mean);

% Plot effect of stake size on cooperation rate and loss avoidance
plot_loss_avoidance_interaction_stake_size(exp3, ps_Exp3)
% Create boxplots with individual data points for Appendix
boxplot_data_points(d, ps_Exp3, 3);

%% Further analyses for Appendix

% Bar-plot that plots each person's loss avoidance score

% Sort data into the 5 categories
for iC = 1:5
    dd{iC} = d(d(:,18) == iC,:);
end

% Group data for Loss Avoidance contrast
data_specialTwo = [dd{2}; dd{4}];
data_otherThree = [dd{1}; dd{3}; dd{5}];

for i = 1:length(ps)
    d_2_4{i} = data_specialTwo(data_specialTwo(:,3) == ps(i),:);
    d_1_3_5{i} = data_otherThree(data_otherThree(:,3) == ps(i),:);
end

for i = 1:length(ps)
    d_2_4_part_mean(i) = mean(d_2_4{i}(:,25));
    d_1_3_5_part_mean(i) = mean(d_1_3_5{i}(:,25));
end

[h,p,ci,stats] = ttest(d_2_4_part_mean, d_1_3_5_part_mean)

% Set colours for individual groups
C1 = [0 0.4470 0.7410];
C2 = [0.8500 0.3250 0.0980];
C3 = [0.4660 0.6740 0.1880];
C4 = [0.6350 0.0780 0.1840];
C5 = [0.9290 0.6940 0.1250];
C6 = [0.4940 0.1840 0.5560];
C7 = [0 0 0];
C8 = [1 1 1];

group_1_1 = repmat(C1, 6, 1);
group_1_2 = repmat(C2, 6, 1);
group_1_3 = repmat(C3, 6, 1);
group_1_4 = repmat(C4, 6, 1);

group_2_1 = repmat(C1, 5, 1);
group_2_2 = repmat(C2, 6, 1);
group_2_3 = repmat(C3, 5, 1);
group_2_4 = repmat(C4, 6, 1);
group_2_5 = repmat(C5, 6, 1);
group_2_6 = repmat(C6, 6, 1);
group_2_7 = repmat(C7, 6, 1);
group_2_8 = repmat(C8, 6, 1);

group_3_1 = repmat(C1, 6, 1);
group_3_2 = repmat(C2, 6, 1);
group_3_3 = repmat(C3, 5, 1);
group_3_4 = repmat(C4, 5, 1);
group_3_5 = repmat(C5, 4, 1);
group_3_6 = repmat(C6, 6, 1);
group_3_7 = repmat(C7, 6, 1);
group_3_8 = repmat(C8, 6, 1);

% Create the figure
figure
b = bar ((d_1_3_5_part_mean - d_2_4_part_mean) * 100);
ylim([-25 25])
ylabel('Loss avoidance')
xlabel('Experiment / group')
xticks([3 9 15 21 26 32 37 43 49 55 61 67 73 79 84 89 93 99 105 111 117])
xticklabels(['1/1'; '1/2'; '1/3'; '1/4'; '2/1'; '2/2'; '2/3'; '2/4'; '2/5'; '2/6'; '2/7'; '2/8'; '3/1'; '3/2'; '3/3'; '3/4'; '3/5'; '3/6'; '3/7'; '3/8'])
xtickangle(45)

b.FaceColor = 'flat';
b.CData(1:6,:)  = group_1_1;
b.CData(7:12,:) = group_1_2;
b.CData(13:18,:)= group_1_3;
b.CData(19:24,:)= group_1_4;
b.CData(25:29,:)= group_2_1;
b.CData(30:35,:)= group_2_2;
b.CData(36:40,:)= group_2_3;
b.CData(41:46,:)= group_2_4;
b.CData(47:52,:)= group_2_5;
b.CData(53:58,:)= group_2_6;
b.CData(59:64,:)= group_2_7;
b.CData(65:70,:)= group_2_8;
b.CData(71:76,:)= group_3_1;
b.CData(77:82,:)= group_3_2;
b.CData(83:87,:)= group_3_3;
b.CData(88:92,:)= group_3_4;
b.CData(93:96,:)= group_3_5;
b.CData(97:102,:)= group_3_6;
b.CData(103:108,:)= group_3_7;
b.CData(109:114,:)= group_3_8;


% Create the txt file to create the Raincloud plot in R
L_avoid = (d_1_3_5_part_mean - d_2_4_part_mean) * 100;
exp_N   = [ones(1,length(ps_Exp1)), ones(1,length(ps_Exp2)) + 1, ones(1,length(ps_Exp3)) + 2];
for_R = [L_avoid', exp_N'];


% Look at Loss Avoidance separately for each POM repetition

% Sort data into the 5 categories
for iC = 1:5
    dd{iC} = d(d(:,18) == iC,:);
end

% Group data for Loss Avoidance contrast
data_specialTwo = [dd{2}; dd{4}];
data_otherThree = [dd{1}; dd{3}; dd{5}];

ps = ps(ps > 100);

for i = 1:length(ps)
    d_2_4{i} = data_specialTwo(data_specialTwo(:,3) == ps(i),:);
    d_1_3_5{i} = data_otherThree(data_otherThree(:,3) == ps(i),:);
end

% Calculate mean cooperation rate separately for each repetition of the POM
for POM_trial = 1:3
    for i = 1:length(ps)
        d_2_4_part_mean{POM_trial}(i) = mean(d_2_4{i}(d_2_4{i}(:,7) == POM_trial,25));
        d_1_3_5_part_mean{POM_trial}(i) = mean(d_1_3_5{i}(d_1_3_5{i}(:,7) == POM_trial,25));
    end
end

% Calculate loss avoidance score per person
for loop = 1:3
    b{loop} = d_1_3_5_part_mean{loop} - d_2_4_part_mean{loop};
end

time = 1;
[h,p,ci,stats] = ttest(d_2_4_part_mean{time}, d_1_3_5_part_mean{time});

[p,tbl,stats] = anova1([b{1}', b{2}', b{3}']);

% Restructure for boxplot function
coops = [b{1}', b{2}', b{3}'];

% 5-boxplot + individual data points plot
bl = [0 0.2470 0.7410];
re = [0.8500 0.3250 0.0980];
%re = [0.8350 0.2780 0];
cPall = [bl; re; bl; re; bl];
numR = 3;
pLen = length(b{1});

figure
hold on
for iCom = 1:numR
    s = scatter((randi([25 75],pLen,1)/100)+(iCom-1), b{:,iCom},'filled');
     s.CData = cPall(iCom,:);
end
boxplot(coops,'Widths',.3, 'Colors', cPall)
xlim([0 3.5])
line([0 5], [0 0], 'Color', 'black')
xlabel('Trial of each payoff matrix')
ylabel('Loss avoidance')
title(['Experiments 1-3; N = ', int2str(length(b{1}))])

% Calculate correlation between own choice and other's precious choice
interaction_effect_history = sum(d(:,25) == d(:,31))/size(d, 1);

