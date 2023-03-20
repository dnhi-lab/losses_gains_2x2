function [d, Q, C1, C2, C3, C4, C5] = format_data_Exp_7(data)

% Delete people who didn't finish the study
data(data(:,70) ~= 1,:) = [];

%{
1:  Age
2:  Gender
3:  Category
4:  Test Q1 (correct response = 1)
5:  Test Q2 (correct response = 2)
6:  NaN
7:  NaN
8:  Decision Prisoner's Dilemma
9:  Decision Stag-Hunt
10: Decision Chicken
11: Expectation Prisoner's Dilemma
12: Expectation Stag-Hunt
13: Expectation Chicken
14: Utility 1st highest outcome
15: Utility 2nd highest outcome
16: Utility 3rd highest outcome
17: Utility 4th highest outcome
18: Loss avoidance PD
19: Loss aversion  PD
20: Loss avoidance SH
21: Loss aversion SH
22: Loss avoidance CH
23: Loss aversion CH
%}

% Select relevant columns
d = NaN(size(data,1),23);
d(:,1:3) = data(:,[8 9 13]); % age, gender, randomisation
d(:,11)  = 100 - (data(:,34) - 1); % expectation PD '100 - ' because 100 was defection in question, but I'd like to frame it as cooperation rate
d(:,12)  = 100 - (data(:,33) - 1); % expectation SH
d(:,13)  = 100 - (data(:,35) - 1); % expectation CH

% Because the different categories use different payoffs, we set up separate
% questions in SoSciSurvey. These now need to be collated
for loop = 1:size(d,1)
    if d(loop, 3)       == 1
        d(loop, 4:5)    = data(loop, 14:15);        % Test questions
        d(loop, 8:10)   = data(loop, 24:26)  - 1;   % Actual decision
        d(loop, 14:17)  = data(loop, 36:39) - 1;    % Utilities
    elseif d(loop, 3)   == 2
        d(loop, 4:5)    = data(loop, 16:17);
        d(loop, 8:10)   = data(loop, 27:29)  - 1;
        d(loop, 14:17)  = data(loop, 40:43) - 1;
    elseif d(loop, 3)   == 3
        d(loop, 4:5)    = data(loop, 18:19);
        d(loop, 8:10)   = data(loop, 27:29)  - 1;
        d(loop, 14:17)  = data(loop, 44:47) - 1;
    elseif d(loop, 3)   == 4
        d(loop, 4:5)    = data(loop, 20:21);
        d(loop, 8:10)   = data(loop, 27:29)  - 1;
        d(loop, 14:17)  = data(loop, 48:51) - 1;
    elseif d(loop, 3)   == 5
        d(loop, 4:5)    = data(loop, 22:23);
        d(loop, 8:10)   = data(loop, 30:32)  - 1;
        d(loop, 14:17)  = data(loop, 52:55) - 1;
    end
end

%% Test questions

% Q1 correct = 1 (answers reversed compared to Exp6 because DD & CD are 
% swapped between Chicken and Stag-Hunt (the first game is always the one 
% with which we test their understanding))
% Q2 correct = 2

Q.one.abs =  sum(d(:,4) == 1);
Q.one.rel = (sum(d(:,4) == 1)/length(d(:,4)))*100;
Q.two.abs =  sum(d(:,5) == 2);
Q.two.rel = (sum(d(:,5) == 2)/length(d(:,4)))*100;

% Count the N of correct test Qs
e = zeros(length(d(:,4)),1);
for loop = 1:size(d,1)
    if d(loop,4) == 1
        e(loop,1) = e(loop,1) + 1;
    end
    if d(loop,5) == 2
        e(loop,1) = e(loop,1) + 1;
    end
end

% Only include participants who got all 4 questions correct
d = d(e(:,1) == 2,:);

% One participant put their year of birth as age
d(d(:,1) == 1998,1) = 24;

% One participant did not put a number as their age (instead: #######),
% which Matlab coded as a very large number
d(d(:,1) > 200,1) = NaN;

%% Create the 5 categories of payoff matrices
C1 = d(d(:,3) == 1,:);
C2 = d(d(:,3) == 2,:);
C3 = d(d(:,3) == 3,:);
C4 = d(d(:,3) == 4,:);
C5 = d(d(:,3) == 5,:);

%% Logistic regression
% Add column for loss aversion and loss avoidance, separately for the 
% Prisoner's Dilemma, Stag-Hunt, and Chicken

avoid_PD  = [0 1 0 1 0];
averse_PD = [1 2 3 4 5];
avoid_SH  = [0 1 0 -1 0];
averse_SH = [1 2 3 2 1];
avoid_CH  = [0 -1 0 1 0];
averse_CH = [3 2 1 2 3];

for row = 1:length(d(:,3))
    for category = 1:5
        d(d(:,3) == category,18) = avoid_PD (category);
        d(d(:,3) == category,19) = averse_PD(category);
        d(d(:,3) == category,20) = avoid_SH (category);
        d(d(:,3) == category,21) = averse_SH(category);
        d(d(:,3) == category,22) = avoid_CH (category);
        d(d(:,3) == category,23) = averse_CH(category);
    end
end

end
