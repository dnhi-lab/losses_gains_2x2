% Script for running the LA study
clear variables
rand('seed', sum(100 * clock));
% Set the basic information for the study
[time, multi_num, dir_base, participant, study] = defBasics();
% Study-specific settings
study = defStudy(multi_num, study);
% Set the multiplayer settings
[ip_addr, con, participant] = multiplayer(study, multi_num, participant);

%% % Settings for the instructions
text = defText();
screen = defScreen();
keys = defKeyIDs();

% Settings for the grid
grid = defGrid(screen);
[data, col] = defData(study);

%% % Play the game
[study, time, data] = playTheGame(text, screen, study, grid, keys, time, data, participant, multi_num, ip_addr, con, col);
% Disconnect from the network
if multi_num == 1, pnet('closeall'), end

%% % Code and save the data
sca;

% Change this to save the file as P?_B?
fpath = ['LT_P', int2str(participant.num), '_B', int2str(study.block)];
cd(fpath)
save (fpath)
cd(dir_base)

% Randomly select 1 trial from 1 block for actual payoff
if study.block == 5
    [payoff, data] = codePayoff(participant, data, dir_base);
end
