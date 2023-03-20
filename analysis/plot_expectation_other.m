function plot_expectation_other(C1, C2, C3, C4, C5, game, exp_N)

if matches(game, 'PD')
    game_column = 11;
    game_name = 'Prisoner''s Dilemma';
elseif matches(game, 'SH')
    game_column = 12;
    game_name = 'Stag-Hunt';
elseif matches(game, 'CH')
    game_column = 13;
    game_name = 'Chicken';
end

% Calculate cooperation rates
expectation.C1 = mean(C1(:,game_column));
expectation.C2 = mean(C2(:,game_column));
expectation.C3 = mean(C3(:,game_column));
expectation.C4 = mean(C4(:,game_column));
expectation.C5 = mean(C5(:,game_column));

% Calculate SEM
x     = 1:5;
data  = [expectation.C1 expectation.C2 expectation.C3 expectation.C4 expectation.C5];
error = [SEM_continuous(C1(:,11)) SEM_continuous(C2(:,11)) SEM_continuous(C3(:,11)) SEM_continuous(C4(:,11)) SEM_continuous(C5(:,11))]';

% Plot the figure
figure
hold on
for y = 10:10:90
    line([0,6],[y,y])
end
bar([expectation.C1; expectation.C2; expectation.C3; expectation.C4; expectation.C5]')
hold off
ylim([0 100])
xticklabels({'', sprintf('C1 (%d)', size(C1,1)), sprintf('C2 (%d)', size(C2,1)), sprintf('C3 (%d)', size(C3,1)), sprintf('C4 (%d)', size(C4,1)), sprintf('C5 (%d)', size(C5,1))})
xtickangle(45)
xlabel('Payoff matrix category (N of participants)')
ylabel('Expectation other (100 = cooperation, 0 = defection)')
hold on
er = errorbar(x,data,error);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
hold off
set(gca,'TickLength',[0,0])
title(['Experiment ', exp_N, ': ', game_name])

end
