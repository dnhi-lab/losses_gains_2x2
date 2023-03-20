%% Plot the cooperation rates across multiple experiments for Fig 2

clear all
clc

cd('')

%% Iterated Prisoner's Dilemma for Experiments 1-3

load('data_LT_PD_1_2_3.mat')

% Load the data
d = data.Exp_1_2_3;

% Clean the data (exclude 6 participants and any invalid/late trials)
[d, ps, demo] = exclude_participants_iterated(d);


% Sort data into the 5 categories
for iC = 1:5
    C1_5{iC} = d(d(:,18) == iC,:);
end

% Separate each participants' data
for i = 1:length(ps)
    d_1{i}     = C1_5{1}(C1_5{1}(:,3) == ps(i),:);
    d_2{i}     = C1_5{2}(C1_5{2}(:,3) == ps(i),:);
    d_3{i}     = C1_5{3}(C1_5{3}(:,3) == ps(i),:);
    d_4{i}     = C1_5{4}(C1_5{4}(:,3) == ps(i),:);
    d_5{i}     = C1_5{5}(C1_5{5}(:,3) == ps(i),:);
end

% Calculate the mean cooperation rate per category per participant
for i = 1:length(ps)
    d_1_part_mean(i)     = mean(d_1{i}      (:,25));
    d_2_part_mean(i)     = mean(d_2{i}      (:,25));
    d_3_part_mean(i)     = mean(d_3{i}      (:,25));
    d_4_part_mean(i)     = mean(d_4{i}      (:,25));
    d_5_part_mean(i)     = mean(d_5{i}      (:,25));
end

plot_cooperation_rate(d_1_part_mean, d_2_part_mean, d_3_part_mean, d_4_part_mean, d_5_part_mean, 'PD', '1-3', 1)

%% One-shot Prisoner's Dilemma for Experiments 4-7

clear all
clc

load('PD_Ex4.mat')
% PD_Ex4 counts N of defections and total N for each category

% C1
aa{1} = NaN(PD_Ex4.C1(2),23);
aa{1}(:,8) = 0;
aa{1}(1:PD_Ex4.C1(1),8) = 1;
% C2
aa{2} = NaN(PD_Ex4.C2(2),23);
aa{2}(:,8) = 0;
aa{2}(1:PD_Ex4.C2(1),8) = 1;
% C3
aa{3} = NaN(PD_Ex4.C3(2),23);
aa{3}(:,8) = 0;
aa{3}(1:PD_Ex4.C3(1),8) = 1;
% C4
aa{4} = NaN(PD_Ex4.C4(2),23);
aa{4}(:,8) = 0;
aa{4}(1:PD_Ex4.C4(1),8) = 1;
% C5
aa{5} = NaN(PD_Ex4.C5(2),23);
aa{5}(:,8) = 0;
aa{5}(1:PD_Ex4.C5(1),8) = 1;

plot_cooperation_rate(aa{1}, aa{2}, aa{3}, aa{4}, aa{5}, 'PD', '4-7', 0)

% Exp5-7 are in regular data structure
load('data_Exp5.mat')

b{1} = [aa{1};C1];
b{2} = [aa{2};C2];
b{3} = [aa{3};C3];
b{4} = [aa{4};C4];
b{5} = [aa{5};C5];

load('data_Exp6.mat')

c{1} = [b{1};C1];
c{2} = [b{2};C2];
c{3} = [b{3};C3];
c{4} = [b{4};C4];
c{5} = [b{5};C5];

load('data_Exp7.mat')

e{1} = [c{1};C1];
e{2} = [c{2};C2];
e{3} = [c{3};C3];
e{4} = [c{4};C4];
e{5} = [c{5};C5];

plot_cooperation_rate(e{1}, e{2}, e{3}, e{4}, e{5}, 'PD', '4-7', 0)


%% Stag-Hunt for Experiments 6-7

clear all
clc

load('data_Exp6.mat')

a{1} = C1;
a{2} = C2;
a{3} = C3;
a{4} = C4;
a{5} = C5;

load('data_Exp7.mat');

C1 = [a{1}; C1];
C2 = [a{2}; C2];
C3 = [a{3}; C3];
C4 = [a{4}; C4];
C5 = [a{5}; C5];

plot_cooperation_rate(C1, C2, C3, C4, C5, 'SH', '6-7', 0)

%% Chicken for Experiment 7

clear all
clc

% Import the data
load('data_Exp7.mat');

plot_cooperation_rate(C1, C2, C3, C4, C5, 'CH', '7', 0)
