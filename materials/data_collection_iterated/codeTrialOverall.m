function trialOverall = codeTrialOverall(study, trials_loop)

if study.block == 1
     trialOverall = trials_loop;
elseif study.block == 2
    trialOverall = trials_loop + 60;
elseif study.block == 3
    trialOverall = trials_loop + 120;
elseif study.block == 4
    trialOverall = trials_loop + 180;
elseif study.block == 5
    trialOverall = trials_loop + 240;
elseif study.block == 0
    trialOverall = trials_loop;
end

end
