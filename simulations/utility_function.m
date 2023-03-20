function y = utility_function(x, model)
% This is basically the same function as utilities_pos_neg.m but for a
% slightly different data structure

for loop = 1:length(x)
    if x(loop)<0
        y(loop) = model(2)*x(loop) - model(3);
    elseif x(loop)>=0
        y(loop) = model(1)*x(loop);
    end

end

end
