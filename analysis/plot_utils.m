function plot_utils(utils, N)

% Plot the step size between different payoffs for each category
figure
bar([utils.gaps_C1; utils.gaps_C2; utils.gaps_C3; utils.gaps_C4; utils.gaps_C5])
ylim([0 100])
xticklabels({'C1', 'C2', 'C3', 'C4', 'C5'})
xlabel('Category')
ylabel("Difference in utility between payoffs")
legend(["Highest-Second" "Second-third" "Third-lowest"])
title(['Experiment ', int2str(N), ': Step size between utility ratings'])

% Plot the mean utilities for each payoff in each category
% Reshape data to fit the intended plot
utilities = NaN(5,8);
utilities(1,1:4) = utils.mean_C1;
utilities(2,2:5) = utils.mean_C2;
utilities(3,3:6) = utils.mean_C3;
utilities(4,4:7) = utils.mean_C4;
utilities(5,5:8) = utils.mean_C5;
utilities = flip(utilities,2);
x = 1:8;

figure
plot(x,utilities(1,:), x,utilities(2,:), x,utilities(3,:), x,utilities(4,:), x,utilities(5,:))
ylim([0 100])
xlim([0.5 8.5])
xticklabels({'-560', '-400', '-240', '-80', '+80', '+240', '+400', '+560'})
xlabel('Payoffs')
ylabel('Explicit utility ratings (100 = very good)')
line([4.5 4.5],[0 100], 'Color', 'black')
legend(["C1" "C2" "C3" "C4" "C5"], 'Location', 'southeast')
title(['Experiment ', int2str(N), ': Explicit utility ratings'])

end
