function [payoff, data] = codePayoff(participant, data, dir_base)

% Randomly select a trial for payoff
% randomly select a block from which to choose the reward and load the
% data file
payoff.block = randi([1 5],1);
payoff.path = ['LT_P', int2str(participant.num), '_B', int2str(payoff.block)];
cd(payoff.path)
load(payoff.path)

% Randomly select a trial within this block and display it
a = size(data.values);
payoff.trial = randi([1 a(1)],1);
data.values(:,23) = 0;
data.values(payoff.trial,23) = 1;

disp(data.values(data.values(:,23) == 1,21))
cd(dir_base)

end