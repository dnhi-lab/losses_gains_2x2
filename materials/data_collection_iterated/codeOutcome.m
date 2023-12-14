function data = codeOutcome(data, trials_loop, col)

% Code whether participant cooperated or defected
if isequal(data.values(trials_loop, col.response), 1) || isequal(data.values(trials_loop, col.response), 2)
    data.values(trials_loop, col.CorD) = 1; % cooperate
elseif isequal(data.values(trials_loop, col.response), 3) || isequal(data.values(trials_loop, col.response), 4)
    data.values(trials_loop, col.CorD) = 0; % defect
end
% Code whether other cooperated or defected
if isequal(data.values(trials_loop, col.responseOther), 1) || isequal(data.values(trials_loop, col.responseOther), 2)
    data.values(trials_loop, col.CorDOther) = 1; % cooperate
elseif isequal(data.values(trials_loop, col.responseOther), 3) || isequal(data.values(trials_loop, col.responseOther), 4)
    data.values(trials_loop, col.CorDOther) = 0; % defect
end

% Code the outcome of the trial
if isequal(data.values(trials_loop, col.CorD), 1) && isequal(data.values(trials_loop, col.CorDOther), 1)
    data.values(trials_loop, col.outcome) = 1; % CC
    data.values(trials_loop, col.points) = data.values(trials_loop, col.R);
    data.values(trials_loop, col.pointsOther) = data.values(trials_loop, col.R);
elseif isequal(data.values(trials_loop, col.CorD), 1) && isequal(data.values(trials_loop, col.CorDOther), 0)
    data.values(trials_loop, col.outcome) = 2; % CD
    data.values(trials_loop, col.points) = data.values(trials_loop, col.S);
    data.values(trials_loop, col.pointsOther) = data.values(trials_loop, col.T);
elseif isequal(data.values(trials_loop, col.CorD), 0) && isequal(data.values(trials_loop, col.CorDOther), 1)
    data.values(trials_loop, col.outcome) = 3; % DC
    data.values(trials_loop, col.points) = data.values(trials_loop, col.T);
    data.values(trials_loop, col.pointsOther) = data.values(trials_loop, col.S);
elseif isequal(data.values(trials_loop, col.CorD), 0) && isequal(data.values(trials_loop, col.CorDOther), 0)
    data.values(trials_loop, col.outcome) = 4; % DD
    data.values(trials_loop, col.points) = data.values(trials_loop, col.P);
    data.values(trials_loop, col.pointsOther) = data.values(trials_loop, col.P);
end

end