function SVO_loss_avoid = SVO_loss(ps_og, excluded_ps, experiment, data_1, data_2)

if experiment == 2
    load('SVO_data_Exp_2.mat')
elseif experiment == 3
    load('SVO_data_Exp_3.mat')
    SVO_out_acker = ddd;
end

% Delete the SVO data of the excluded participants
for iPs = 1:length(ps_og)
    if sum(ps_og(iPs) == excluded_ps)
        included(iPs) = 1;
    elseif sum(ps_og(iPs) ~= excluded_ps)
        included(iPs) = 0;
    end
end

SVO = SVO_out_acker(:,1);
SVO(included == 1,:) = [];

loss = (data_2')*100 - (data_1')*100;

% Run the linear regression
SVO_loss_avoid = fitlm(SVO, loss);

% Prepare scatter plot
X = [ones(length(SVO),1) SVO];
b = X\loss;
yCalc2 = X*b;

% Plot regression
figure
scatter(SVO, loss, 'filled')
hold on
plot(SVO, yCalc2)
xlabel('Social-value orientation')
ylabel('Loss aversion')
title(['Experiment ', int2str(experiment), '; N = ', int2str(length(loss))])
grid on
ylim([-25 25])

end
