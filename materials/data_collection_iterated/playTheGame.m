function [study, time, data] = playTheGame(text, screen, study, grid, keys, time, data, participant, multi_num, ip_addr, con, col)
rand('seed', sum(100 * clock));
trials_loop = 0;
%%
dispBlockNumber(text, screen, participant);
if multi_num == 1
    if (ip_addr == '0')
        OUich = round(rand());
        OUdu = 1-OUich;
        send = OUdu;
        pnet_putvar(con, send);
    else
        OUich = pnet_getvar(con);
        OUdu = 1-OUich;
    end
elseif multi_num == 0
    OUich = round(rand());
    OUdu = 1-OUich;
end
%% Randomise the order in which players play each POM (do this here, so that every pair gets a new order of POMs)
study = randomisePOMorder(study);
if multi_num == 1
    if (ip_addr == '0')
        send = study.POM.randomOrder;
        pnet_putvar(con, send);
    else
        [receive] = pnet_getvar(con);
        study.POM.randomOrder = receive;
    end
end

%%
for i = 1:length(study.POM.val)% playing each POM
    for trials_POM_loop = 1:study.trials % repetitions of the same POM
        trials_loop = trials_loop+1;
       
        data.values(trials_loop,col.trialOverall)   = codeTrialOverall(study, trials_loop);% Trial number overall                  || Could be done more generically
        data.values(trials_loop,col.trialBlock)     = trials_loop;                         % Trial number this block
        data.values(trials_loop,col.trialPOM)       = trials_POM_loop;                     % Trial number this POM this pairing
        data.values(trials_loop,col.block)          = study.block;                         % Block number
        data.values(trials_loop,col.ID)             = participant.num;                     % Player number
        data.values(trials_loop,col.IDother)        = participant.other;                   % Other player number
        data.values(trials_loop,col.OUich)          = OUich;                               % OUich this trial
        data.values(trials_loop,col.POM)            = codePOMNumber(study, i);             % Which POM (numbered from 1-20)        || Could be done more generically
        data.values(trials_loop,col.T)              = study.POM.randomOrder{i}(1);         % T this trial
        data.values(trials_loop,col.R)              = study.POM.randomOrder{i}(2);         % R this trial
        data.values(trials_loop,col.P)              = study.POM.randomOrder{i}(3);         % P this trial
        data.values(trials_loop,col.S)              = study.POM.randomOrder{i}(4);         % S this trial
                               
        %% Show the grid and get player's response
        dispGrid(screen, grid, OUich, text);
        dispPOM(screen, grid, study, i, OUich);
        Screen('Flip', screen.window);
        
        % At this stage I actually just need to code the number of the
        % response; After both players have each other's responses will I
        % code what this means
        [data, time] = codeResponse(keys, time, data, trials_loop, OUich, col);
        
        % Pause until 6s for the trial are over
        if time.trial.react < time.trial.limit
            pause(time.trial.limit-time.trial.react);
        end
        %% Sending players' responses
        send = data.values(trials_loop, col.response);
        
        if multi_num == 1
            if (ip_addr == '0')
            pnet_putvar(con, send);
            data.values(trials_loop, col.responseOther) = pnet_getvar(con);
            else
                data.values(trials_loop, col.responseOther) = pnet_getvar(con);
                pnet_putvar(con, send);
            end
        elseif multi_num == 0
            randChoice = randomChoice(OUdu);
            data.values(trials_loop, col.responseOther) = randChoice{1};
        end
                
        %% Calculate and display outcome
        % Code the outcome (CC, CD, DC, DD)
        data = codeOutcome(data, trials_loop, col);
        data = dispOutcome(screen, study, grid, i, OUich, text, data, trials_loop, col);        
    end
end
end