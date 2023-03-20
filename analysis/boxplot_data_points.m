function boxplot_data_points(d, ps_exp, exp)
% Create the box plots with individual data points that I show in the
% appendix
% Load the raw data sorted and specify with ps_exp which  participants 
% should be included, and what experiment it is

data = d(sum(d(:,3) == ps_exp,2) == 1,:);

% Sort data into the 5 categories
for iC = 1:5
    C1_5{iC} = data(data(:,18) == iC,:);
end

% Calculate average cooperation rate per participant for each of C1-5
for iC = 1:5
    for iPs = 1:length(ps_exp)
        coop{iC}(iPs) = mean(C1_5{iC}(C1_5{iC}(:,3) == ps_exp(iPs),25));
    end
end

% Restructure for boxplot function
coops = [coop{1}', coop{2}', coop{3}', coop{4}', coop{5}'];

% 5-boxplot + individual data points plot
bl = [0 0.2470 0.7410];
re = [0.8500 0.3250 0.0980];
cPall = [bl; re; bl; re; bl];
numR = 5;
pLen = length(coop{1});

figure
hold on
for iCom = 1:numR
    s = scatter((randi([25 75],pLen,1)/100)+(iCom-1), coop{:,iCom},'filled');
     s.CData = cPall(iCom,:);
end
boxplot(coops,'Widths',.3, 'Colors', cPall)
xlim([0 5.5])
xlabel('Category')
ylabel('Cooperation rate')
title(['Experiment ', int2str(exp), '; N = ', int2str(length(ps_exp))])

end
