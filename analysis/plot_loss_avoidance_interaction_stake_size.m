function plot_loss_avoidance_interaction_stake_size(exp3, ps_Exp3)

% Sort data into the 5 categories
for iC = 1:5
    dd{iC} = exp3(exp3(:,18) == iC,:);
end

% Combine C(2,4) and C(1,3,5)
data_Two = [dd{2}; dd{4}];
data_Three = [dd{1}; dd{3}; dd{5}];

% Separate each participants' data
for iPs = 1:length(ps_Exp3)
    d_2_4{iPs}   = data_Two(data_Two(:,3)     == ps_Exp3(iPs),:);
    d_1_3_5{iPs} = data_Three(data_Three(:,3) == ps_Exp3(iPs),:);
end

% Calculate the mean cooperation rate per participant
stake_sizes = [0.5 1 2 4];
for iPs = 1:length(ps_Exp3)
    for iStake = 1:length(stake_sizes)
        d_2_4_part_mean  (iPs, iStake) = mean(d_2_4  {iPs}(d_2_4  {iPs}(:,16) == stake_sizes(iStake),25));
        d_1_3_5_part_mean(iPs, iStake) = mean(d_1_3_5{iPs}(d_1_3_5{iPs}(:,16) == stake_sizes(iStake),25));
    end
end

loss_avoid = d_1_3_5_part_mean - d_2_4_part_mean;
loss_avoid = loss_avoid * 100;

cPall = [[0.6 0.6 0.6]; [0.4 0.4 0.4]; [0.2 0.2 0.2]; [0 0 0]];
numR  = 4;
pLen  = length(loss_avoid);

figure
hold on
for iCom = 1:numR
    s = scatter((randi([25 75],pLen,1)/100)+(iCom-1), loss_avoid(:,iCom),'filled');
     s.CData = cPall(iCom,:);
end
boxplot(loss_avoid,'Widths',.3, 'Colors', cPall)
xlim([0 4.5])
ylim([-35 35])
line([0 5], [0 0], 'Color', 'black')
xlabel('Stake size')
xticklabels({'0.5', '1', '2', '4'})
ylabel('Loss avoidance')
title(['Experiment 3; N = ', int2str(length(ps_Exp3))])

%% Same for loss aversion and stake size
% Separate each participants' data
for iPs = 1:length(ps_Exp3)
    d_1{iPs} = dd{1}(dd{1}(:,3) == ps_Exp3(iPs),:);
    d_5{iPs} = dd{5}(dd{5}(:,3) == ps_Exp3(iPs),:);
end

% Calculate the mean cooperation rate per participant
stake_sizes = [0.5 1 2 4];
for iPs = 1:length(ps_Exp3)
    for iStake = 1:length(stake_sizes)
        d_1_part_mean(iPs, iStake) = mean(d_1{iPs}(d_1{iPs}(:,16) == stake_sizes(iStake),25));
        d_5_part_mean(iPs, iStake) = mean(d_5{iPs}(d_5{iPs}(:,16) == stake_sizes(iStake),25));
    end
end

loss_avers = d_1_part_mean - d_5_part_mean;
loss_avers = loss_avers * 100;

pLen = length(loss_avers);

figure
hold on
for iCom = 1:numR
    s = scatter((randi([25 75],pLen,1)/100)+(iCom-1), loss_avers(:,iCom),'filled');
     s.CData = cPall(iCom,:);
end
boxplot(loss_avers,'Widths',.3, 'Colors', cPall)
xlim([0 4.5])
ylim([-50 50])
line([0 5], [0 0], 'Color', 'black')
xlabel('Stake size')
xticklabels({'0.5', '1', '2', '4'})
ylabel('Loss aversion')
title(['Experiment 3; N = ', int2str(length(ps_Exp3))])

%% Same for cooperation rate across all 5 categories

for i = 1:length(ps_Exp3)
    coop{i}   = data_Two(data_Two(:,3)     == ps_Exp3(i),:);
end

% Calculate the mean cooperation rate per participant
for iPs = 1:length(ps_Exp3)
    for iStake = 1:length(stake_sizes)
        coop_part_mean  (iPs, iStake) = mean(coop  {iPs}(d_2_4  {iPs}(:,16) == stake_sizes(iStake),25));
    end
end

coop_part_mean = coop_part_mean * 100;

figure
hold on
for iCom = 1:numR
    s = scatter((randi([25 75],pLen,1)/100)+(iCom-1), coop_part_mean(:,iCom),'filled');
     s.CData = cPall(iCom,:);
end
boxplot(coop_part_mean,'Widths',.3, 'Colors', cPall)
xlim([0 4.5])
ylim([0 100])
xlabel('Stake size')
xticklabels({'0.5', '1', '2', '4'})
ylabel('Cooperation rate')
title(['Experiment 3; N = ', int2str(length(ps_Exp3))])

end
