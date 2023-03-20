function h1_2_3_stats = Exp_3_h_1_2_3_anova(exp3, ps_Exp3)
% This function is just a way to keep the main script cleaner. It runs the
% 2-way repeated measures ANOVA that we use to test the preregistered
% hypotheses H1, H2, and H3. Most of the function is formatting of the data

% Sort data into the 5 categories
for iC = 1:5
    dd{iC} = exp3(exp3(:,18) == iC,:);
end

% Combine C(2,4) and C(1,3,5)
data_Two = [dd{2}; dd{4}];
data_Three = [dd{1}; dd{3}; dd{5}];

% Separate each participants' data
for i = 1:length(ps_Exp3)
    d_2_4{i}   = data_Two(data_Two(:,3)     == ps_Exp3(i),:);
    d_1_3_5{i} = data_Three(data_Three(:,3) == ps_Exp3(i),:);
    d_1{i}     = dd{1}(dd{1}(:,3)           == ps_Exp3(i),:);
    d_5{i}     = dd{5}(dd{5}(:,3)           == ps_Exp3(i),:);
end

stake_sizes = [0.5 1 2 4];

% Calculate the mean cooperation rate per participant
for iPs = 1:length(ps_Exp3)
    for iStake = 1:length(stake_sizes)
        d_2_4_part_mean  (iPs, iStake) = mean(d_2_4  {iPs}(d_2_4  {iPs}(:,16) == stake_sizes(iStake),25));
        d_1_3_5_part_mean(iPs, iStake) = mean(d_1_3_5{iPs}(d_1_3_5{iPs}(:,16) == stake_sizes(iStake),25));
    end
end

coop_per_person = [d_2_4_part_mean'; d_1_3_5_part_mean'];
nsubj = size(coop_per_person,2);

% Append each participants' data into one vector
data_total = [];
for iPs = 1:nsubj
    data_total = [data_total; coop_per_person(:,iPs)];
end

nLevelsLossAvoidance = 2;
nLevelsStakeSize = length(stake_sizes);
Subj = repelem(ps_Exp3, nLevelsLossAvoidance*nLevelsStakeSize);

% Code stake size levels
stakes = repmat(stake_sizes, 1, nsubj*nLevelsLossAvoidance)';

LA = ones(1,nLevelsStakeSize);
noLA = zeros(1,nLevelsStakeSize);
Avoid = repmat([LA noLA], 1, nsubj)';
FACTNAMES = {'Avoidance', 'Stake size'};

% Run the actual ANOVA (using Aaron's function)
h1_2_3_stats = rm_anova2(data_total,Subj',Avoid,stakes,FACTNAMES);

end
