function [time, multi_num, dir_base, participant, study] = defBasics()

participant.num    = input('participant number: ');      % Participant number
study.block        = input('insert block number: ');    % Which block number?
study.combosOrder  = input('insert block type: ');      % Who plays against whom?

% folder to change
dir_base = '';
cd(dir_base)

% Create folder as LT_P?_B?, which stands for: LT study, participant ?, block ?
fpath = ['LT_P', int2str(participant.num), '_B', int2str(study.block)];
if exist(fpath,'dir') == 7
    disp('Folder already exists! Check variables again! aborting...');
    clear variables
    return;  % abort experiment, rather than overwrite existing data!!!
else
    mkdir(fpath);
end

% In 'time', we will store all time-related variables i.e., overal duration
% of the study, response time, etc.
time.clock_time_start = clock;
time.trial.limit = 6; % How any seconds participants have to respond on any given trial

multi_num = str2double(input('multiplayer? 1=y, 0=n ','s'));

end