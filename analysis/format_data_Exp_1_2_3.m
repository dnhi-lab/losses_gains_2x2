%% Script to format the data for Exp 1-3

% This script is run once to get the final structure for the data for the
% iterated experiments that I'll use for all analyses

clear all
clc

cd('C:\Users\kuper\Desktop\LT in PD\00_Losses_gains_2x2\Analysis')

data.labels = {...
% Columns structure for all 3 iterated experiments
    '01: Which experiment'...
    '02: Which group (Exp1: 1-4, Exp2: 5-12, Exp3: 13-20)'...
    '03: Participant ID'...
    '04: Other player ID'...
    '05: Trial number overall (for this participant in entire study: 1-300)'...
    '06: Trial number in this block (1-60)'...
    '07: Trial number of this POM against this player (1-5 for Exp1, 1-3 for Exp 2-3)'...
    '08: Block number (1-5)'...
    '09: Who played row, who played columns (1 = self rows, other columns; 0 = self columns, other rows)'...
    '10: T for that trial'...
    '11: R for that trial'...
    '12: P for that trial'...
    '13: S for that trial'...
    '14: 14: Which payoff matrix. Not sure I need this column, keep it NaN for now'...
    '15: 15: Which base-POM (1 = {3, 1, -1, -2}, 2 = {6, 2, -2, -6} and 3 = {11, 3, -3, -11})'...
    '16: *a (0.5, 1, 2, 4)'...
    '17: +b'...
    '18: Which category of payoff matrix (C1-5)'...
    '19: Whether the category expects loss avoidance not (C2 & C4 = 1, others = 0)'...
    '20: Whether player pressed a button that trial (1 = yes, 0 = no)'...
    '21: Type of button press (0 = none, 1 = valid, 2 = invalid)'...
    '22: Response time (in s; of valid button press if multiple buttons pressed)'...
    '23: Response for that trial (1 = left, 2 = up, 3 = right, 4 = down)'...
    '24: Other"s response for that trial'...
    '25: Cooperate (1) or defect (0) on that trial'...
    '26: Other cooperate (1) or defect (0) on that trial'...
    '27: Outcome on this trial (1 = CC, 2 = CD, 3 = DC, 4 = DD)'...
    '28: Participant points that trial'...
    '29: Other points that trial'...
    '30: Previous decision self'...
    '31: Previous decision other'...
};

% Exp 2 and 3 are automatically formatted the same way, but Exp 1 had a
% different format, so I need to restructure them separately

%% Restructure Exp 1 data

ps_Exp_1 = [1:6, 11:16, 21:26, 31:36];
block_length = 60;
blocks = 5;
trials = block_length * blocks;
ps_per_group = 6;

% Initialise the data file
data.Exp_1 = NaN(300*24, length(data.labels)); %(N trials * N participants)

% Fill in the data from existing data file
load('data_LT_PD_1.mat')

% 01: Which experiment
data.Exp_1(:, 1) = 1;
% 02: Which group (Exp1: 1-4, Exp2: 5-12, Exp3: 13-20)
for groups = 1:4
    for iRow = 1:length(data.Exp_1(:,1))
        if iRow < trials * ps_per_group * groups + 1 && iRow > trials * ps_per_group * (groups - 1)
            data.Exp_1(iRow, 2) = groups;
        end
    end
end
% 03: Participant ID
for iPs = 1:length(ps_Exp_1)
    for iTrialsPs = 1:block_length*blocks
        data.Exp_1(iTrialsPs+(block_length*blocks)*(iPs-1), 3) = ps_Exp_1(iPs);
    end
end
% 04: Other player ID
data.Exp_1(:,4) = NaN; % Didn't record this in Exp 1
% 05: Trial number overall (for this participant in entire study: 1-300)
for iPs = 1:length(ps_Exp_1)
    for iTrialsPs = 1:block_length*blocks
        data.Exp_1(iTrialsPs+(block_length*blocks)*(iPs-1), 5) = iTrialsPs;
    end
end
% 06: Trial number in this block (1-60)
data.Exp_1(:, 6) = LT_Pilot_data_raw(:, 1);
% 07: Trial number of this POM against this player (1-5 for Exp1, 1-3 for Exp 2-3)
data.Exp_1(:, 7) = LT_Pilot_data_raw(:,5);
% 08: Block number (1-5)
for iPs = 1:length(ps_Exp_1)
    for iBlock = 1:blocks
        for i_block_length = 1:block_length
            data.Exp_1(i_block_length+(block_length*(iBlock-1))+(block_length*blocks*(iPs-1)), 8) = iBlock;
        end
    end
end
% 09: Who played row, who played columns (1 = self rows, other columns; 0 = self columns, other rows)
data.Exp_1(:, 9) = LT_Pilot_data_raw(:, 6);
% 10: T for that trial
data.Exp_1(:,10) = LT_Pilot_data_raw(:,12);
% 11: R for that trial
data.Exp_1(:,11) = LT_Pilot_data_raw(:,13);
% 12: P for that trial
data.Exp_1(:,12) = LT_Pilot_data_raw(:,14);
% 13: S for that trial
data.Exp_1(:,13) = LT_Pilot_data_raw(:,15);
% 14: Which payoff matrix. Not sure I need this column, keep it NaN for now
% 15: Which base-POM (1 = {3, 1, -1, -2}, 2 = {6, 2, -2, -6} and 3 = {11, 3, -3, -11})
data.Exp_1(:,15) = 1;
% 16: *a (0.5, 1, 2, 4)
data.Exp_1(:,16) = 1;
% 17: +b
for iRow = 1:length(data.Exp_1(:,1))
    if data.Exp_1(iRow,10) == 7
        data.Exp_1(iRow,17) = 4;
    elseif data.Exp_1(iRow,10) == 6
        data.Exp_1(iRow,17) = 3;
    elseif data.Exp_1(iRow,10) == 5
        data.Exp_1(iRow,17) = 2;
    elseif data.Exp_1(iRow,10) == 4.5
        data.Exp_1(iRow,17) = 1.5;
    elseif data.Exp_1(iRow,10) == 4
        data.Exp_1(iRow,17) = 1;
    elseif data.Exp_1(iRow,10) == 3.5
        data.Exp_1(iRow,17) = 0.5;
    elseif data.Exp_1(iRow,10) == 3
        data.Exp_1(iRow,17) = 0;
    elseif data.Exp_1(iRow,10) == 2
        data.Exp_1(iRow,17) = -1;
    elseif data.Exp_1(iRow,10) == 1
        data.Exp_1(iRow,17) = -2;
    elseif data.Exp_1(iRow,10) == 0
        data.Exp_1(iRow,17) = -3;
    elseif data.Exp_1(iRow,10) == -1
        data.Exp_1(iRow,17) = -4;
    elseif data.Exp_1(iRow,10) == -2
        data.Exp_1(iRow,17) = -5;
    end
end
% 18: Which category of payoff matrix (C1-5)
for iRow = 1:length(data.Exp_1(:,1))
    if isequal(data.Exp_1(iRow,10), 7) || isequal(data.Exp_1(iRow,10), 6)
        data.Exp_1(iRow,18) = 1;
    elseif isequal(data.Exp_1(iRow,10), 5) || isequal(data.Exp_1(iRow,10), 4.5) || isequal(data.Exp_1(iRow,10), 4)
        data.Exp_1(iRow,18) = 2;
    elseif isequal(data.Exp_1(iRow,10), 3.5) || isequal(data.Exp_1(iRow,10), 3) || isequal(data.Exp_1(iRow,10), 2)
        data.Exp_1(iRow,18) = 3;
    elseif isequal(data.Exp_1(iRow,10), 1) || isequal(data.Exp_1(iRow,10), 0)
        data.Exp_1(iRow,18) = 4;
    elseif isequal(data.Exp_1(iRow,10), -1) || isequal(data.Exp_1(iRow,10), -2)
        data.Exp_1(iRow,18) = 5;
    end
end
% 19: Whether the category expects loss avoidance not (C2 & C4 = 1, others = 0)
for iRow = 1:length(data.Exp_1(:,1))
    if isequal(data.Exp_1(iRow,18), 2) || isequal(data.Exp_1(iRow,18), 4)
        data.Exp_1(iRow,19) = 1;
    elseif isequal(data.Exp_1(iRow,18), 1) || isequal(data.Exp_1(iRow,18), 3) || isequal(data.Exp_1(iRow,18), 5)
        data.Exp_1(iRow,19) = 0;
    end
end
% 20: Whether player pressed a button that trial (1 = yes, 0 = no)
data.Exp_1(:,20) = LT_Pilot_data_raw(:, 7);
% 21: Type of button press (0 = none, 1 = valid, 2 = invalid)
data.Exp_1(:,21) = LT_Pilot_data_raw(:,8);
% 22: Response time (in s; of valid button press if multiple buttons pressed)
data.Exp_1(:,22) = LT_Pilot_data_raw(:,9);
% 23: Response for that trial (1 = left, 2 = up, 3 = right, 4 = down)
data.Exp_1(:,23) = LT_Pilot_data_raw(:,10);
% 24: Other's response for that trial (1 = left, 2 = up, 3 = right, 4 = down)
data.Exp_1(:,24) = LT_Pilot_data_raw(:,11);
% 25: Self cooperate (1) or defect (0) on that trial
for iRow = 1:length(data.Exp_1(:,1))
    if isequal(data.Exp_1(iRow,23), 1) || isequal(data.Exp_1(iRow,23), 2)
        data.Exp_1(iRow,25) = 1; % cooperate
    elseif isequal(data.Exp_1(iRow,23), 3) || isequal(data.Exp_1(iRow,23), 4)
        data.Exp_1(iRow,25) = 0; % defect
    end
end
% 26: Other cooperate (1) or defect (0) on that trial
for iRow = 1:length(data.Exp_1(:,1))
    if isequal(data.Exp_1(iRow,24), 1) || isequal(data.Exp_1(iRow,24), 2)
        data.Exp_1(iRow,26) = 1; % cooperate
    elseif isequal(data.Exp_1(iRow,24), 3) || isequal(data.Exp_1(iRow,24), 4)
        data.Exp_1(iRow,26) = 0; % defect
    end
end
% 27: Outcome on this trial (1 = CC, 2 = CD, 3 = DC, 4 = DD)
for iRow = 1:length(data.Exp_1(:,1))
    if isequal(data.Exp_1(iRow,25), 1) && isequal(data.Exp_1(iRow,26), 1)
        data.Exp_1(iRow,27) = 1; % CC
    elseif isequal(data.Exp_1(iRow,25), 1) && isequal(data.Exp_1(iRow,26), 0)
        data.Exp_1(iRow,27) = 2; % CD
    elseif isequal(data.Exp_1(iRow,25), 0) && isequal(data.Exp_1(iRow,26), 1)
        data.Exp_1(iRow,27) = 3; % DC
    elseif isequal(data.Exp_1(iRow,25), 0) && isequal(data.Exp_1(iRow,26), 0)
        data.Exp_1(iRow,27) = 4; % DD
    end
end
% 28: Participant points that trial
data.Exp_1(:,28) = LT_Pilot_data_raw(:,16);
% 29: Other points that trial
data.Exp_1(:,29) = LT_Pilot_data_raw(:,17);
% 30: Previous decision self
for iRow = 2:length(data.Exp_1(:,1))
    data.Exp_1(iRow,30) = data.Exp_1(iRow - 1,25);
    if mod(iRow - 1, 300) == 0
        data.Exp_1(iRow,30) = NaN;
    end
end
% 31: Previous decision other
for iRow = 2:length(data.Exp_1(:,1))
    data.Exp_1(iRow,31) = data.Exp_1(iRow - 1,26);
    if mod(iRow - 1, 300) == 0
        data.Exp_1(iRow,31) = NaN;
    end
end

%% Restructure Exp 2-3 data

% Initialise the data file
data.Exp_2_3 = NaN(300*96, length(data.labels)); %(N trials * N participants)

% Fill in the data from existing data file
load('data_LT_PD_2_3.mat')

% 01: Which experiment
data.Exp_2_3(1:length(data.Exp_2_3)/2, 1) = 2;
data.Exp_2_3(length(data.Exp_2_3)/2+1:length(data.Exp_2_3), 1) = 3;
% 02: Which group (Exp1: 1-4, Exp2: 5-12, Exp3: 13-20)
for groups = 5:20
    for iRow = 1:length(data.Exp_2_3(:,1))
        if iRow < trials * ps_per_group * (groups - 4) + 1 && iRow > trials * ps_per_group * (groups - 5)
            data.Exp_2_3(iRow, 2) = groups;
        end
    end
end
% 03: Participant ID
data.Exp_2_3(:, 3) = LT_1_2_combined(:,5);
% 04: Other player ID
ps_2 = [111:116; 121:126; 131:136; 141:146; 151:156; 161:166; 171:176; 181:186];
ps_3 = [211:216; 221:226; 231:236; 241:246; 251:256; 261:266; 271:276; 281:286];

for iRow = 1:length(data.Exp_2_3(:,1))
    for iGroups = 1:8
        if sum(data.Exp_2_3(iRow,3) == ps_2(iGroups,:))
            data.Exp_2_3(iRow,4) = 100 + iGroups*10 + LT_1_2_combined(iRow,6);
        elseif sum(data.Exp_2_3(iRow,3) == ps_3(iGroups,:))
            data.Exp_2_3(iRow,4) = 200 + iGroups*10 + LT_1_2_combined(iRow,6);
        end
    end
end
% 05: Trial number overall (for this participant in entire study: 1-300)
data.Exp_2_3(:, 5) = LT_1_2_combined(:,1);
% 06: Trial number in this block (1-60)
data.Exp_2_3(:, 6) = LT_1_2_combined(:,2);
% 07: Trial number of this POM against this player (1-5 for Exp1, 1-3 for Exp 2-3)
data.Exp_2_3(:, 7) = LT_1_2_combined(:,3);
% 08: Block number (1-5)
data.Exp_2_3(:, 8) = LT_1_2_combined(:,4);
% 09: Who played row, who played columns (1 = self rows, other columns; 0 = self columns, other rows)
data.Exp_2_3(:,9) = LT_1_2_combined(:,7);
% 10: T for that trial
data.Exp_2_3(:,10) = LT_1_2_combined(:,9);
% 11: R for that trial
data.Exp_2_3(:,11) = LT_1_2_combined(:,10);
% 12: P for that trial
data.Exp_2_3(:,12) = LT_1_2_combined(:,11);
% 13: S for that trial
data.Exp_2_3(:,13) = LT_1_2_combined(:,12);
% 14: Which payoff matrix. Not sure I need this column, keep it NaN for now
% 15: Which base-POM (1 = {3, 1, -1, -2}, 2 = {6, 2, -2, -6} and 3 = {11, 3, -3, -11})
listA = -3:2:15;
listB = [-6 -4 2 4 10 12 18 20 26 28];
for iRow = 1:length(data.Exp_2_3(:,1))
    if data.Exp_2_3(iRow,1) == 2
        if sum(data.Exp_2_3(iRow,10) == listA)
            data.Exp_2_3(iRow,15) = 2;
        elseif sum(data.Exp_2_3(iRow,10) == listB)
            data.Exp_2_3(iRow,15) = 3;
        end
    elseif data.Exp_2_3(iRow,1) == 3
        data.Exp_2_3(iRow,15) = 2;
    end 
end
% 16: *a (0.5, 1, 2, 4)
listA = -1:2:7;
listB = -2:4:14;
listC = -4:8:28;
listD = -8:16:56;
for iRow = 1:length(data.Exp_2_3(:,1))
    if data.Exp_2_3(iRow,1) == 2
        data.Exp_2_3(iRow,16) = 1;
    elseif data.Exp_2_3(iRow,1) == 3
        if sum(data.Exp_2_3(iRow,10) == listA)
            data.Exp_2_3(iRow,16) = 0.5;
        elseif sum(data.Exp_2_3(iRow,10) == listB)
            data.Exp_2_3(iRow,16) = 1;
        elseif sum(data.Exp_2_3(iRow,10) == listC)
            data.Exp_2_3(iRow,16) = 2;
        elseif sum(data.Exp_2_3(iRow,10) == listD)
            data.Exp_2_3(iRow,16) = 4;
        end
    end 
end
% 17: +b
listA = [7 14 28 56];
listB = [5 10 20 40];
listC = [3 6 12 24];
listD = [1 2 4 8];
listE = [-1 -2 -4 -8];
for iRow = 1:length(data.Exp_2_3(:,1))
    if data.Exp_2_3(iRow,1) == 2
        if data.Exp_2_3(iRow,10) == 15
            data.Exp_2_3(iRow,17) = 9;
        elseif data.Exp_2_3(iRow,10) == 13
            data.Exp_2_3(iRow,17) = 7;
        elseif data.Exp_2_3(iRow,10) == 28
            data.Exp_2_3(iRow,17) = 17;
        elseif data.Exp_2_3(iRow,10) == 26
            data.Exp_2_3(iRow,17) = 15;
        elseif data.Exp_2_3(iRow,10) == 11
            data.Exp_2_3(iRow,17) = 5;
        elseif data.Exp_2_3(iRow,10) == 9
            data.Exp_2_3(iRow,17) = 3;
        elseif data.Exp_2_3(iRow,10) == 20
            data.Exp_2_3(iRow,17) = 9;
        elseif data.Exp_2_3(iRow,10) == 18
            data.Exp_2_3(iRow,17) = 7;
        elseif data.Exp_2_3(iRow,10) == 7
            data.Exp_2_3(iRow,17) = 1;
        elseif data.Exp_2_3(iRow,10) == 5
            data.Exp_2_3(iRow,17) = -1;
        elseif data.Exp_2_3(iRow,10) == 12
            data.Exp_2_3(iRow,17) = 1;
        elseif data.Exp_2_3(iRow,10) == 10
            data.Exp_2_3(iRow,17) = -1;
        elseif data.Exp_2_3(iRow,10) == 3
            data.Exp_2_3(iRow,17) = -3;
        elseif data.Exp_2_3(iRow,10) == 1
            data.Exp_2_3(iRow,17) = -5;
        elseif data.Exp_2_3(iRow,10) == 4
            data.Exp_2_3(iRow,17) = -7;
        elseif data.Exp_2_3(iRow,10) == 2
            data.Exp_2_3(iRow,17) = -9;
        elseif data.Exp_2_3(iRow,10) == -1
            data.Exp_2_3(iRow,17) = -7;
        elseif data.Exp_2_3(iRow,10) == -3
            data.Exp_2_3(iRow,17) = -9;
        elseif data.Exp_2_3(iRow,10) == -4
            data.Exp_2_3(iRow,17) = -15;
        elseif data.Exp_2_3(iRow,10) == -6
            data.Exp_2_3(iRow,17) = -17;
        end
    elseif data.Exp_2_3(iRow,1) == 3
        if sum(data.Exp_2_3(iRow,10) == listA)
            data.Exp_2_3(iRow,17) = 8;
        elseif sum(data.Exp_2_3(iRow,10) == listB)
            data.Exp_2_3(iRow,17) = 4;
        elseif sum(data.Exp_2_3(iRow,10) == listC)
            data.Exp_2_3(iRow,17) = 0;
        elseif sum(data.Exp_2_3(iRow,10) == listD)
            data.Exp_2_3(iRow,17) = -4;
        elseif sum(data.Exp_2_3(iRow,10) == listE)
            data.Exp_2_3(iRow,17) = -8;
        end
    end 
end
% 18: Which category of payoff matrix (C1-5)
listA = [13 15 26 28];
listB = [9 11 18 20];
listC = [5 7 10 12];
listD = [1 2 3 4];
listE = [-1 -3 -4 -6];
listF = [7 14 28 56];
listG = [5 10 20 40];
listH = [3 6 12 24];
listI = [1 2 4 8];
listJ = [-1 -2 -4 -8];
for iRow = 1:length(data.Exp_2_3(:,1))
    if data.Exp_2_3(iRow,1) == 2
        if sum(data.Exp_2_3(iRow,10) == listA)
            data.Exp_2_3(iRow,18) = 1;
        elseif sum(data.Exp_2_3(iRow,10) == listB)
            data.Exp_2_3(iRow,18) = 2;
        elseif sum(data.Exp_2_3(iRow,10) == listC)
            data.Exp_2_3(iRow,18) = 3;
        elseif sum(data.Exp_2_3(iRow,10) == listD)
            data.Exp_2_3(iRow,18) = 4;
        elseif sum(data.Exp_2_3(iRow,10) == listE)
            data.Exp_2_3(iRow,18) = 5;
        end
    elseif data.Exp_2_3(iRow,1) == 3
        if sum(data.Exp_2_3(iRow,10) == listF)
            data.Exp_2_3(iRow,18) = 1;
        elseif sum(data.Exp_2_3(iRow,10) == listG)
            data.Exp_2_3(iRow,18) = 2;
        elseif sum(data.Exp_2_3(iRow,10) == listH)
            data.Exp_2_3(iRow,18) = 3;
        elseif sum(data.Exp_2_3(iRow,10) == listI)
            data.Exp_2_3(iRow,18) = 4;
        elseif sum(data.Exp_2_3(iRow,10) == listJ)
            data.Exp_2_3(iRow,18) = 5;
        end
    end 
end
% 19: Whether the category expects loss avoidance not (C2 & C4 = 1, others = 0)
for iRow = 1:length(data.Exp_2_3(:,1))
    if isequal(data.Exp_2_3(iRow,18), 2) || isequal(data.Exp_2_3(iRow,18), 4)
        data.Exp_2_3(iRow,19) = 1;
    elseif isequal(data.Exp_2_3(iRow,18), 1) || isequal(data.Exp_2_3(iRow,18), 3) || isequal(data.Exp_2_3(iRow,18), 5)
        data.Exp_2_3(iRow,19) = 0;
    end
end
% 20: Whether player pressed a button that trial (1 = yes, 0 = no)
data.Exp_2_3(:,20) = LT_1_2_combined(:,13);
% 21: Type of button press (0 = none, 1 = valid, 2 = invalid)
data.Exp_2_3(:,21) = LT_1_2_combined(:,14);
data.Exp_2_3(data.Exp_2_3(:,21) == 3, 21) = 0; % none was = 3, but I recoded it here
% 22: Response time (in s; of valid button press if multiple buttons pressed)
data.Exp_2_3(:,22) = LT_1_2_combined(:,15);
% 23: Response for that trial (1 = left, 2 = up, 3 = right, 4 = down)
data.Exp_2_3(:,23) = LT_1_2_combined(:,16);
% 24: Other's response for that trial (1 = left, 2 = up, 3 = right, 4 = down)
data.Exp_2_3(:,24) = LT_1_2_combined(:,18);
% 25: Self cooperate (1) or defect (0) on that trial
data.Exp_2_3(:,25) = LT_1_2_combined(:,17);
% 26: Other cooperate (1) or defect (0) on that trial
data.Exp_2_3(:,26) = LT_1_2_combined(:,19);
% 27: Outcome on this trial (1 = CC, 2 = CD, 3 = DC, 4 = DD)
data.Exp_2_3(:,27) = LT_1_2_combined(:,20);
% 28: Participant points that trial
data.Exp_2_3(:,28) = LT_1_2_combined(:,21);
% 29: Other points that trial
data.Exp_2_3(:,29) = LT_1_2_combined(:,22);
% 30: Previous decision self
for iRow = 2:length(data.Exp_2_3(:,1))
    data.Exp_2_3(iRow,30) = data.Exp_2_3(iRow - 1,25);
    if mod(iRow - 1, 300) == 0
        data.Exp_2_3(iRow,30) = NaN;
    end
end
% 31: Previous decision other
for iRow = 2:length(data.Exp_2_3(:,1))
    data.Exp_2_3(iRow,31) = data.Exp_2_3(iRow - 1,26);
    if mod(iRow - 1, 300) == 0
        data.Exp_2_3(iRow,31) = NaN;
    end
end

%% Append the two datasets into one
data.Exp_1_2_3 = [data.Exp_1; data.Exp_2_3];

%% Save data
save('data_LT_PD_1_2_3.mat', 'data')
