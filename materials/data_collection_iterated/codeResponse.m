function [data, time] = codeResponse(keys, time, data, trials_loop, OUich, col)
respToBeMade = true;
time.trial.start = GetSecs;

% Code 1) that someone pressed a button and 2) what button
while respToBeMade == true
    [~, ~, keyCode] = KbCheck;
    if keyCode(keys.left)
        data.values(trials_loop, col.press) = 1;
        data.values(trials_loop, col.response) = 1;
        respToBeMade = false;
    elseif keyCode(keys.upup)
        data.values(trials_loop, col.press) = 1;
        data.values(trials_loop, col.response) = 2;
        respToBeMade = false;
    elseif keyCode(keys.righ)
        data.values(trials_loop, col.press) = 1;
        data.values(trials_loop, col.response) = 3;
        respToBeMade = false;
    elseif keyCode(keys.down)
        data.values(trials_loop, col.press) = 1;
        data.values(trials_loop, col.response) = 4;
        respToBeMade = false;
    end
    
    data = codeResponseType(data, trials_loop, col); % Code whether the player made a valid response on this trial
    
    time.trial.end = GetSecs;
    time.trial.react = time.trial.end - time.trial.start;
    data.values(trials_loop, col.RT) = time.trial.react;
    
    if time.trial.react > time.trial.limit % if a participant doesn't respond on a given trial
        data.values(trials_loop, col.press) = 0;
        data.values(trials_loop, col.pressType) = 3;
        respToBeMade = false;
    end
end

if isequal(data.values(trials_loop, col.pressType), 2) || isequal(data.values(trials_loop, col.pressType), 3)
    randChoice = codeRandomChoice(OUich);
    data.values(trials_loop, col.response) = randChoice{1};
end

end