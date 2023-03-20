function y = utilities_pos_neg(x, slope_pos,slope_neg, intercept)
% Calculate the utilities separately for losses and gains

if x < 0
    y = (x*slope_neg) - intercept;
elseif x >=0
    y = (x*slope_pos);
end

end
