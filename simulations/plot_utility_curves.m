function plot_utility_curves(model1, model2, model3, model4)
% Plot the utilities for the 4 different models

% Define the range and precision of the x-axis
limit = 5;
resolution = 0.000001;
x = -limit:resolution:limit;


% Plot all utility curves used (for the Appendix)
%{
figure
subplot(2,2,1)
y = utility_function(x, model1);
plot(x,y)
line([-5 5], [0 0], 'Color', 'black', 'Linewidth', 1.5)
line([0 0], [-15 15], 'Color', 'black', 'Linewidth', 1.5)
ylim([-15 15])
ylabel('Utility')
title('Neither')
subplot(2,2,2)
y = utility_function(x, model2);
plot(x,y)
line([-5 5], [0 0], 'Color', 'black', 'Linewidth', 1.5)
line([0 0], [-15 15], 'Color', 'black', 'Linewidth', 1.5)
ylim([-15 15])
ylabel('Utility')
title('Loss avoidance (intercept)')
subplot(2,2,3)
y = utility_function(x, model3);
plot(x,y)
line([-5 5], [0 0], 'Color', 'black', 'Linewidth', 1.5)
line([0 0], [-15 15], 'Color', 'black', 'Linewidth', 1.5)
ylim([-15 15])
ylabel('Utility')
title('Loss aversion (different slopes)')
subplot(2,2,4)
y = utility_function(x, model4);
plot(x,y)
line([-5 5], [0 0], 'Color', 'black', 'Linewidth', 1.5)
line([0 0], [-15 15], 'Color', 'black', 'Linewidth', 1.5)
ylim([-15 15])
ylabel('Utility')
title('Both')
sgtitle('Utility curves')
%}


% Plot loss aovoidance and loss aversion for Figure 2 of the main text
figure
%subplot(2,1,1)
y = utility_function(x, model2);
plot(x,y, 'linewidth', 2.5)
line([-5 5], [0 0], 'Color', 'black', 'Linewidth', 1.5)
line([0 0], [-10 10], 'Color', 'black', 'Linewidth', 1.5)
ylim([-10 10])
xticks([])
yticks([])
xlabel('Payoff')
ylabel('Utility')
title('Loss avoidance (intercept)')
%subplot(2,1,2)
figure
y = utility_function(x, model3);
plot(x,y, 'linewidth', 2.5)
line([-5 5], [0 0], 'Color', 'black', 'Linewidth', 1.5)
line([0 0], [-10 10], 'Color', 'black', 'Linewidth', 1.5)
ylim([-10 10])
xticks([])
yticks([])
xlabel('Payoff')
ylabel('Utility')
title('Loss aversion (different slopes)')
%sgtitle('Utility curves')



end
