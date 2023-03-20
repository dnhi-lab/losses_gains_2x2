function d = cohens_d_ttest_between(var1,var2)
% Adapted from https://www.socscistatistics.com/effectsize/default3.aspx

M_1  = mean(var1);
M_2  = mean(var2);
SD_1 = std (var1);
SD_2 = std (var2);

SD_pooled = sqrt((SD_1^2 + SD_2^2)/2);
d = (M_2 - M_1)/SD_pooled;

end
