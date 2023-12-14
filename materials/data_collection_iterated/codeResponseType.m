function data = codeResponseType(data, trials_loop, col)

% Code whether the player made a valid response on this trial
if data.values(trials_loop, col.OUich) == 1
    if isequal(data.values(trials_loop, col.response), 2) || isequal(data.values(trials_loop, col.response), 4)
        data.values(trials_loop, col.pressType) = 1; % Valid response
    elseif isequal(data.values(trials_loop, col.response), 1) || isequal(data.values(trials_loop, col.response), 3)
       data.values(trials_loop, col.pressType) = 2; % Wrong OU/LR response
    end
elseif data.values(trials_loop, col.OUich) == 0
    if isequal(data.values(trials_loop, col.response), 1) || isequal(data.values(trials_loop, col.response), 3)
        data.values(trials_loop, col.pressType) = 1; % Valid response
    elseif isequal(data.values(trials_loop, col.response), 2) || isequal(data.values(trials_loop, col.response), 4)
        data.values(trials_loop, col.pressType) = 2; % Wrong OU/LR response
    end
end

end