function [d, Q, C1, C2, C3, C4, C5] = format_data_Exp_5(data)

%% Clean the data file
% Delete rows from my test runs
data(1:3,:) = [];

% Delete people who didn't finish the study
data(data(:,68) ~= 1,:) = [];

%{
1:  Age
2:  Gender
3:  Category
4:  Test Q1 (correct response = 4)
5:  Test Q2 (correct response = 2)
6:  Test Q3 (correct response = 1)
7:  Test Q4 (correct response = 3)
8:  Decision Prisoner's Dilemma
9:  NaN
10: NaN
11: Expectation Prisoner's Dilemma
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

% Select relevant columns
d = NaN(size(data,1),23);
d(:,1:3) = data(:,[8 9 13]); % Age, gender, category
d(:, 11) = 100 - (data(:, 37) - 1); % Expectation other

% Because the different categories use different payoffs, we set up separate
% questions in SoSciSurvey. These now need to be collated
for loop = 1:size(d,1)
    if d(loop, 3)       == 1
        d(loop, 4:7)    = data(loop, 14:17); % Test questions
        d(loop, 8)      = data(loop, 34)    - 1; % Decision PD
        d(loop, 14:17)  = data(loop, 38:41) - 1; % Utilities
    elseif d(loop, 3)   == 2
        d(loop, 4:7)    = data(loop, 18:21);
        d(loop, 8)      = data(loop, 35)    - 1;
        d(loop, 14:17)  = data(loop, 42:45) - 1;
    elseif d(loop, 3)   == 3
        d(loop, 4:7)    = data(loop, 22:25);
        d(loop, 8)      = data(loop, 35)    - 1;
        d(loop, 14:17)  = data(loop, 46:49) - 1;
    elseif d(loop, 3)   == 4
        d(loop, 4:7)    = data(loop, 26:29);
        d(loop, 8)      = data(loop, 35)    - 1;
        d(loop, 14:17)  = data(loop, 50:53) - 1;
    elseif d(loop, 3)   == 5
        d(loop, 4:7)    = data(loop, 30:33);
        d(loop, 8)      = data(loop, 36)    - 1;
        d(loop, 14:17)  = data(loop, 54:57) - 1;
    end
end

%% Logistic regression
% Add column for loss aversion and loss avoidance, separately for the 
% Prisoner's Dilemma, Stag-Hunt, and Chicken

avoid_PD  = [0 1 0 1 0];
averse_PD = [1 2 3 4 5];

for row = 1:length(d(:,3))
    for category = 1:5
        d(d(:,3) == category,18) = avoid_PD (category);
        d(d(:,3) == category,19) = averse_PD(category);
    end
end

%% Test questions
% Q1 correct = 4
% Q2 correct = 2
% Q3 correct = 1
% Q4 correct = 3

Q.one.abs =  sum(d(:,4) == 4);
Q.one.rel = (sum(d(:,4) == 4)/length(d(:,4)))*100;
Q.two.abs =  sum(d(:,5) == 2);
Q.two.rel = (sum(d(:,5) == 2)/length(d(:,4)))*100;
Q.thr.abs =  sum(d(:,6) == 1);
Q.thr.rel = (sum(d(:,6) == 1)/length(d(:,4)))*100;
Q.fou.abs =  sum(d(:,7) == 3);
Q.fou.rel = (sum(d(:,7) == 3)/length(d(:,4)))*100;

% Count the N of correct test Qs
e = zeros(length(d(:,4)),1);
for loop = 1:size(d,1)
    if d(loop,4) == 4
        e(loop) = e(loop) + 1;
    end
    if d(loop,5) == 2
        e(loop) = e(loop) + 1;
    end
    if d(loop,6) == 1
        e(loop) = e(loop) + 1;
    end
    if d(loop,7) == 3
        e(loop) = e(loop) + 1;
    end
end

% Only include participants who got all 4 questions correct
d = d(e(:,1) == 4,:);

%% Create the 5 categories of payoff matrices
C1 = d(d(:,3) == 1,:);
C2 = d(d(:,3) == 2,:);
C3 = d(d(:,3) == 3,:);
C4 = d(d(:,3) == 4,:);
C5 = d(d(:,3) == 5,:);

end
