function plot_cooperation_rate(C1, C2, C3, C4, C5, game, exp_N, iterated)

if iterated == 0
    if matches(game, 'PD')
        game_column = 8;
        game_name = 'Prisoner''s Dilemma';
    elseif matches(game, 'SH')
        game_column = 9;
        game_name = 'Stag-Hunt';
    elseif matches(game, 'CH')
        game_column = 10;
        game_name = 'Chicken';
    end

    % Calculate cooperation rates
    cooperation_rate.C1 = 100 - (sum(C1(:,game_column)) / size(C1,1)) * 100;
    cooperation_rate.C2 = 100 - (sum(C2(:,game_column)) / size(C2,1)) * 100;
    cooperation_rate.C3 = 100 - (sum(C3(:,game_column)) / size(C3,1)) * 100;
    cooperation_rate.C4 = 100 - (sum(C4(:,game_column)) / size(C4,1)) * 100;
    cooperation_rate.C5 = 100 - (sum(C5(:,game_column)) / size(C5,1)) * 100;

    % Calculate SEM for binary data
    x = 1:5;
    data = [cooperation_rate.C1 cooperation_rate.C2 cooperation_rate.C3 cooperation_rate.C4 cooperation_rate.C5];
    N = [size(C1,1) size(C2,1) size(C3,1) size(C4,1) size(C5,1)];
    error = [SEM_binary(N(1)) SEM_binary(N(2)) SEM_binary(N(3)) SEM_binary(N(4)) SEM_binary(N(5))]';

elseif iterated == 1
    game_name = 'Prisoner''s Dilemma';
    
    % Calculate cooperation rates
    cooperation_rate.C1 = mean(C1)*100;
    cooperation_rate.C2 = mean(C2)*100;
    cooperation_rate.C3 = mean(C3)*100;
    cooperation_rate.C4 = mean(C4)*100;
    cooperation_rate.C5 = mean(C5)*100;
    
    % Calculate SEM for continuous data
    x = 1:5;
    data = [cooperation_rate.C1 cooperation_rate.C2 cooperation_rate.C3 cooperation_rate.C4 cooperation_rate.C5];
    error = [SEM_continuous(C1*100) SEM_continuous(C2*100) SEM_continuous(C3*100) SEM_continuous(C4*100) SEM_continuous(C5*100)]';
    
end

if matches(game, 'PD')
    colour = [44 123 182]/256;
elseif matches(game, 'SH')
    colour = [253 174 97]/256;
elseif matches(game, 'CH')
    colour = [215 25 28]/256;
end

% Plot the figure
figure
hold on
for y = 10:10:90
    line([0,6],[y,y], 'Color', 'black')
end
bar([cooperation_rate.C1, cooperation_rate.C2, cooperation_rate.C3, cooperation_rate.C4, cooperation_rate.C5], 'FaceColor', colour)
hold off
if iterated == 0
    ylim([0 100])
    yticks([[],[],20,[],[],50,[],[],80,[],[]])
elseif iterated == 1
    ylim([35 65])
    yticks([40:10:60])
end
if iterated == 0
    xticklabels({'', sprintf('C1 (%d)', size(C1,1)), sprintf('C2 (%d)', size(C2,1)), sprintf('C3 (%d)', size(C3,1)), sprintf('C4 (%d)', size(C4,1)), sprintf('C5 (%d)', size(C5,1))})
elseif iterated == 1
    xticklabels({'', sprintf('C1 (%d)', length(C1)), sprintf('C2 (%d)', length(C2)), sprintf('C3 (%d)', length(C3)), sprintf('C4 (%d)', length(C4)), sprintf('C5 (%d)', length(C5))})
end
xtickangle(45)
hold on
er = errorbar(x,data,error);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
hold off
set(gca,'TickLength',[0,0])
ylabel('Cooperation rate (+SEM)')
xlabel('Payoff matrix category (N of participants)')
%title(['Experiment ', exp_N, ': ', game_name])
title(['Experiments ', exp_N, ' (iterated)'], 'FontSize', 15)

end
