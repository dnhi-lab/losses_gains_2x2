function utils = calc_utils(C1,C2, C3, C4, C5)
% Calculate mean utilities per category for each payoff
utils.mean_C1 = [mean(C1(:,14)),  mean(C1(:,15)), mean(C1(:,16)), mean(C1(:,17))];
utils.mean_C2 = [mean(C2(:,14)),  mean(C2(:,15)), mean(C2(:,16)), mean(C2(:,17))];
utils.mean_C3 = [mean(C3(:,14)),  mean(C3(:,15)), mean(C3(:,16)), mean(C3(:,17))];
utils.mean_C4 = [mean(C4(:,14)),  mean(C4(:,15)), mean(C4(:,16)), mean(C4(:,17))];
utils.mean_C5 = [mean(C5(:,14)),  mean(C5(:,15)), mean(C5(:,16)), mean(C5(:,17))];

% Calculate mean steepness for each category but only comparisons within
% losses or gains (i.e., to calculate steepness of positive and negative
% values separately)
utils.steep_mean_C1     = mean((C1 (:,14) - C1 (:,17)) / 4);
utils.steep_mean_C2     = mean((C2 (:,14) - C2 (:,16)) / 3);
utils.steep_mean_C3_pos = mean((C3 (:,14) - C3 (:,15)) / 2);
utils.steep_mean_C3_neg = mean((C3 (:,16) - C3 (:,17)) / 2);
utils.steep_mean_C4     = mean((C4 (:,15) - C4 (:,17)) / 3);
utils.steep_mean_C5     = mean((C5 (:,14) - C5 (:,17)) / 4);

% Calculate one steepness per person for t-test
utils.steep_C1     = (C1 (:,14) - C1 (:,17)) / 4;
utils.steep_C2     = (C2 (:,14) - C2 (:,16)) / 3;
utils.steep_C3_pos = (C3 (:,14) - C3 (:,15)) / 2;
utils.steep_C3_neg = (C3 (:,16) - C3 (:,17)) / 2;
utils.steep_C4     = (C4 (:,15) - C4 (:,17)) / 3;
utils.steep_C5     = (C5 (:,14) - C5 (:,17)) / 4;

% Combine those in the gain domain and those in the loss domain separately
utils.steep_gain = [utils.steep_C3_pos; utils.steep_C2; utils.steep_C1];
utils.steep_loss = [utils.steep_C3_neg; utils.steep_C4; utils.steep_C5];

% Calculate the mean step size from one payoff to the next, separately for
% each category for figure
utils.gaps_C1 = [mean(C1 (:,14) - C1 (:,15)), mean(C1(:,15) - C1 (:,16)), mean(C1(:,16) - C1 (:,17))];
utils.gaps_C2 = [mean(C2 (:,14) - C2 (:,15)), mean(C2(:,15) - C2 (:,16)), mean(C2(:,16) - C2 (:,17))];
utils.gaps_C3 = [mean(C3 (:,14) - C3 (:,15)), mean(C3(:,15) - C3 (:,16)), mean(C3(:,16) - C3 (:,17))];
utils.gaps_C4 = [mean(C4 (:,14) - C4 (:,15)), mean(C4(:,15) - C4 (:,16)), mean(C4(:,16) - C4 (:,17))];
utils.gaps_C5 = [mean(C5 (:,14) - C5 (:,15)), mean(C5(:,15) - C5 (:,16)), mean(C5(:,16) - C5 (:,17))];

% Combine loss avoidance steps with no loss avoidance steps
utils.gaps_NolossAvoidance = [  C1(:,14) - C1(:,15); C1(:,15) - C1(:,16); C1(:,16) - C1(:,17); ...
                C2(:,14) - C2(:,15); C2(:,15) - C2(:,16); ...
                C3(:,14) - C3(:,15); C3(:,16) - C3(:,17); ...
                C4(:,15) - C4(:,16); C4(:,16) - C4(:,17); ...
                C5(:,14) - C5(:,15); C5(:,15) - C5(:,16); C5(:,16) - C5(:,17)];
utils.gaps_lossAvoidance = [C2(:,16) - C2(:,17); C3(:,15) - C3(:,16); C4(:,14) - C4(:,15)];

end
