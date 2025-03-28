%% Simulate cooperation rates for the 5 categories with different utility curves

% This script simulates cooperation rates in the 5 categories of various 
% 2x2 games, using different utility functions. This is used to predict how
% people (or groups of people) might behave in 2x2 games when outcomes can
% be gains and/or losses

clear all
clc

cd('')

%% Define the game
% base: define the largest, second largest, etc. payoffs irrespective of which game it is
base = [7 5 3 1];
stake_size = 1;

payoffs = base * stake_size;

% Define the game ('PD' = Prisoner's Dilemma, 'SH' = Stag-Hunt, 'CH' = Chicken , 'NC' = No Conflict)
game = 'CH';

% Create the payoff matrix (POM) from the combination of payoffs and game
% POM = [DC CC DD CD] aka [T R P S]
if matches(game, 'PD')
    POM = [payoffs(1) payoffs(2) payoffs(3) payoffs(4)];
elseif matches(game, 'SH')
    POM = [payoffs(2) payoffs(1) payoffs(3) payoffs(4)];
elseif matches(game, 'CH')
    POM = [payoffs(1) payoffs(2) payoffs(4) payoffs(3)];
elseif matches(game, 'NC')
    POM = [payoffs(2) payoffs(1) payoffs(4) payoffs(3)];
end

%% Create the 5 categories of the POM with gains and losses
% NOTE: this stepsize calculation only works if the difference between 
% payoffs is a constant
stepsize = payoffs(1) - payoffs(2);

POMs{1} = POM;
for category = 2:5
    POMs{category} = POMs{category - 1} - stepsize;
end

%% Define the different utility functions
% The general idea is to introduce an asymmetry for payoffs in the gain and
% in the loss domain. The main way in which we do this is by changing the 
% slope and the intercept between gains and losses

% Calculate the expected utility of the C and the D options for the game
% For now, we either assume a 50/50 chance of what the other will do, or we
% use the expected probabilities that we recorded in Experiment 7 (when we
% asked the participants what they thought the other would do from 0 to 100)
% Include both, just to show that it doesn't make much of a difference

expectation_type = 1;

if expectation_type == 1
    % Uniform cooperation expectation from other
    coop_other = 0.5;
    p_C = [coop_other coop_other coop_other coop_other coop_other];
elseif expectation_type == 2
    % Actual expectation of cooperation from other, taken from Experiment 7
    % (Separately for each game and each category, 1 combination per person)
    if matches(game, 'PD')
        p_C = [0.58 0.52 0.54 0.40 0.50];
    elseif matches(game, 'SH')
        p_C = [0.73 0.69 0.80 0.75 0.72];
    elseif matches(game, 'CH')
        p_C = [0.59 0.61 0.59 0.41 0.50]; %
    elseif matches(game, 'NC')
        p_C = [0.50 0.50 0.50 0.50 0.50]; % We never collected data for this game
    end
end

% The basic formula of expected utility theory is
% utility_C = (R * p_C + S * (1-p_C) );
% utility_D = (T * p_C + P * (1-p_C) );

% We also run the utilities through the loss/gain filters to account for
% different utility functions

% Define slopes and intercept for the 4 models
% [slope_positive, slope_negative, intercept]
% The intercept doesn't need to be the same as stepsize, but that way it's
% proportional, independent of stake size
lin           = [1, 1, 0];
lin_gap       = [1, 1, stepsize];
lin_slope     = [1, 2, 0];
lin_slope_gap = [1, 2, stepsize];

% Calculate the expected utilities for C and D, and their differences,
% separately for the 5 categories, and for each model
util_lin           = calc_utils(POMs, p_C, lin);
util_lin_gap       = calc_utils(POMs, p_C, lin_gap);
util_lin_slope     = calc_utils(POMs, p_C, lin_slope);
util_lin_slope_gap = calc_utils(POMs, p_C, lin_slope_gap);

% Define the slope and indifference point for the sigmoid function
slope = 0.5/stake_size;
indiff = - stepsize;

% Calculate cooperation rate for each of the 5 categories, for each model
y_lin            = sigmoid(cell2mat(util_lin.diff),           indiff, slope);
y_lin_gap        = sigmoid(cell2mat(util_lin_gap.diff),       indiff, slope);
y_lin_slope      = sigmoid(cell2mat(util_lin_slope.diff),     indiff, slope);
y_lin_slope_gap  = sigmoid(cell2mat(util_lin_slope_gap.diff), indiff, slope);

%% Plot cooperation rates and corresponding utility curves
plot_utility_curves(lin, lin_gap, lin_slope, lin_slope_gap)
plot_cooperation_rates(y_lin, y_lin_gap, y_lin_slope, y_lin_slope_gap, game, expectation_type)
