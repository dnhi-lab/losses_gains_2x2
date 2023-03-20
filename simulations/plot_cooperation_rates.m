function plot_cooperation_rates(m1, m2, m3, m4, game, exp_type)

if exp_type == 1
    name = [game, '; uniform expectation (50/50)'];
elseif exp_type == 2
    name = [game, '; actual expectations (from Exp. 7)'];
end

%{
% PLot all 4 utiliy curves for Appendix
figure
subplot(2,2,1)
b1 = bar(m1);
xticklabels({'C1', 'C2', 'C3', 'C4', 'C5'})
ylim([0 1])
ylabel('Cooperation rate')
%title('Slope-pos: 1; slope-neg: 1; gap: 0')
title('Neither')
subplot(2,2,2)
b2 = bar(m2);
xticklabels({'C1', 'C2', 'C3', 'C4', 'C5'})
ylim([0 1])
ylabel('Cooperation rate')
%title('Slope-pos: 1; slope-neg: 1; gap: -2')
title('Loss avoidance')
subplot(2,2,3)
b3 = bar(m3);
xticklabels({'C1', 'C2', 'C3', 'C4', 'C5'})
ylim([0 1])
ylabel('Cooperation rate')
%title('Slope-pos: 1; slope-neg: 2; gap: 0')
title('Loss aversion')
subplot(2,2,4)
b4 = bar(m4);
xticklabels({'C1', 'C2', 'C3', 'C4', 'C5'})
ylim([0 1])
ylabel('Cooperation rate')
%title('Slope-pos: 1; slope-neg: 2; gap:-2')
title('Both')
sgtitle(name)
%}

if matches(game, 'PD')
    colour = [44 123 182]/256;
elseif matches(game, 'SH')
    colour = [253 174 97]/256;
elseif matches(game, 'CH')
    colour = [215 25 28]/256;
end

% Plot only loss avoidance and loss aversion for Fig 2 in main text
figure
subplot(2,1,1)
b2 = bar(m2, 'FaceColor', colour);
box off
xticklabels({'C1', 'C2', 'C3', 'C4', 'C5'})
ylim([0 1])
% ylabel('Cooperation rate')
title('Loss avoidance', 'FontSize', 14)
subplot(2,1,2)
b3 = bar(m3, 'FaceColor', colour);
box off
xticklabels({'C1', 'C2', 'C3', 'C4', 'C5'})
ylim([0 1])
% ylabel('Cooperation rate')
title('Loss aversion', 'FontSize', 14)
%sgtitle('Simulations', 'FontSize', 22)


end
