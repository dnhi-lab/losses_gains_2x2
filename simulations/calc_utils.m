function utilities = calc_utils(POM, p_C, model)
% CALC_UTILS calculates the utilities of the C and D options for each of 
% the 5 categories, under different slopes and/or intercepts for losses
% and gains, and the difference between them

for i_POM = 1:5
    utilities.C{i_POM}      = utilities_pos_neg(POM{i_POM}(2), model(1), model(2), model(3)) * p_C(i_POM) + utilities_pos_neg(POM{i_POM}(4), model(1), model(2), model(3)) * (1-p_C(i_POM));
    utilities.D{i_POM}      = utilities_pos_neg(POM{i_POM}(1), model(1), model(2), model(3)) * p_C(i_POM) + utilities_pos_neg(POM{i_POM}(3), model(1), model(2), model(3)) * (1-p_C(i_POM));
    % Calculate the difference between the C and D option for each of the 5
    % categories
    utilities.diff{i_POM}   = utilities.C{i_POM} - utilities.D{i_POM};
end

end
