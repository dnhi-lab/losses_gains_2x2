function [d, ps, demo] = exclude_participants_iterated(d)
%{
From the Preregistrations

Exp1 had no preregistration. I'm using the same criteria as for Exp2
- Exclude trials with invalid response
- Exclude trials with late/no response
- Exclude participants with more than 10% of invalid and/or late responses

Exp2 (https://osf.io/dzkqg)
- Exclude trials with invalid response
- Exclude trials with late/no response
- Exclude participants with more than 10% of invalid and/or late responses
Not preregistered:
- Also exclude 116 who told us after the experiment that they  thought the 
experiment was an 'Idiotentest' and that they didn't  understand the 
experiment after all [this participant would have been excluded anyway due 
to >10% invalid/late reponses]
- Also exclude 135 who had already taken part in Exp1 as 23. This was not
preregistered, but we added this criterion to the preregistration of Exp3

Exp3 (https://osf.io/z4geq)
- Exclude trials with invalid response
- Exclude trials with late/no response
- Exclude participants with more than 10% of invalid and/or late responses
- Exclude participants who claim not to have understood experiment 
(assessed in post-experiment questionnaire)
- Exclude participants who correctly identified the hypothesis
(assessed in post-experiment questionnaire)
- Exclude participants who correctly identified who they played against
(assessed in post-experiment questionnaire)
- Exclude participants who took part in Experiments 1 or 2 of this study
(assessed in post-experiment questionnaire)
    - 231 already took part as 13
    - 255 already took part as 32
    - 246 already took part as 151

%}

% The list of participant IDs
ps = [1:6, 11:16, 21:26, 31:36, 111:116, 121:126, 131:136, 141:146, 151:156, 161:166, 171:176, 181:186, 211:216, 221:226, 231:236, 241:246, 251:256, 261:266, 271:276, 281:286];

% Load demographics data
demo = xlsread('demographics_Exp_1_2_3');

%% Exclude participants with more than 10% invalid/late responses

% Initiate the counter of invalid responses per participant
d_ps = zeros(length(ps),1);
% Go through each row. If for any given participant their response is not
% valid, add 1 to their counter of invalid responses
for iRows  = 1:length(d)
    for iPs = 1:length(ps)
        if d(iRows, 3) == ps(iPs) && d(iRows, 21) ~= 1
            d_ps(iPs) = d_ps(iPs) + 1;
        end
    end
end

% Identify those with more than 10% invalid (in all 3 experiments: 
% 300 trials per participant, so up to 30 invalid trials are allowed)
invalid = d_ps > 30;
exclude = ps(invalid == 1);

% Exclude participants' data if they had more than 10% invalid responses
% from the dataset and from the list of participant IDs
for i_excl = 1:length(exclude)
    d(d(:,3) == exclude(i_excl),:) = [];
    demo(ps  == exclude(i_excl),:) = [];
    ps  (ps  == exclude(i_excl))   = [];
end

%% % Exclude participants based on people having taken part more than once
% In each case, we deleted the second participation and kept the first
exclude_manually = [135, 231, 255, 246];

for i_excl = 1:length(exclude_manually)
    d(d(:,3) == exclude_manually(i_excl),:) = [];
    demo(ps  == exclude_manually(i_excl),:) = [];
    ps  (ps  == exclude_manually(i_excl))   = [];
end

%% Exclude any invalid/late trials
% Exclude any non-valid responses
d = d(d(:,21) == 1,:);

end
