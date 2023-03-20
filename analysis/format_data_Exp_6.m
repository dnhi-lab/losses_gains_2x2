function [d, Q, C1, C2, C3, C4, C5] = format_data_Exp_6(data)

% Delete people who didn't finish the study
data(data(:,64) ~= 1,:) = [];

%{
1:  Age
2:  Gender
3:  Category
4:  Test Q1 (correct response = 2)
5:  Test Q2 (correct response = 1)
6:  NaN
7:  NaN
8:  Decision Prisoner's Dilemma
9:  Decision Stag-Hunt
10: NaN
11: Expectation Prisoner's Dilemma
12: Expectation Stag-Hunt
13: NaN
14: Utility 1st highest outcome
15: Utility 2nd highest outcome
16: Utility 3rd highest outcome
17: Utility 4th highest outcome
18: Loss avoidance PD
19: Loss aversion  PD
20: Loss avoidance SH
21: Loss avoidance SH
22: NaN
23: NaN
%}

% Select relevant columns
d = NaN(size(data,1),23);
d(:,1:3) = data(:,[8 9 13]); % age, gender, category
d(:,11:12) = 100 - (data(:,[31 30]) - 1); % expectation PD (11) and SH (12) (were originally coded the wrong way round)

% Because the different categories use different payoffs, we set up separate
% questions in SoSciSurvey. These now need to be collated
for loop = 1:size(d,1)
    if d(loop, 3)       == 1
        d(loop, 4:5)    = data(loop, 14:15);        % Test questions
        d(loop, 8:9)    = data(loop, 24:25) - 1;    % Actual decision
        d(loop, 14:17)  = data(loop, 32:35) - 1;    % Utilities
    elseif d(loop, 3)   == 2
        d(loop, 4:5)    = data(loop, 16:17);
        d(loop, 8:9)    = data(loop, 26:27) - 1;
        d(loop, 14:17)  = data(loop, 36:39) - 1;
    elseif d(loop, 3)   == 3
        d(loop, 4:5)    = data(loop, 18:19);
        d(loop, 8:9)    = data(loop, 26:27) - 1;
        d(loop, 14:17)  = data(loop, 40:43) - 1;
    elseif d(loop, 3)   == 4
        d(loop, 4:5)    = data(loop, 20:21);
        d(loop, 8:9)    = data(loop, 26:27) - 1;
        d(loop, 14:17)  = data(loop, 44:47) - 1;
    elseif d(loop, 3)   == 5
        d(loop, 4:5)    = data(loop, 22:23);
        d(loop, 8:9)    = data(loop, 28:29) - 1;
        d(loop, 14:17)  = data(loop, 48:51) - 1;
    end
end

%% Test questions

% Q1 correct = 2
% Q2 correct = 1

Q.one.abs =  sum(d(:,4) == 2);
Q.one.rel = (sum(d(:,4) == 2)/length(d(:,4)))*100;
Q.two.abs =  sum(d(:,5) == 1);
Q.two.rel = (sum(d(:,5) == 1)/length(d(:,4)))*100;

% Count the N of correct test Qs
e = zeros(length(d(:,4)),1);
for loop = 1:size(d,1)
    if d(loop,4) == 2
        e(loop,1) = e(loop,1) + 1;
    end
    if d(loop,5) == 1
        e(loop,1) = e(loop,1) + 1;
    end
end

% Only include participants who got all 4 questions correct
d = d(e(:,1) == 2,:);

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

for row = 1:length(d(:,3))
    for category = 1:5
        d(d(:,3) == category,18) = avoid_PD (category);
        d(d(:,3) == category,19) = averse_PD(category);
        d(d(:,3) == category,20) = avoid_SH (category);
        d(d(:,3) == category,21) = averse_SH(category);
    end
end

end
