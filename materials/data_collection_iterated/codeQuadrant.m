function [Links, Rechts, Oben, Unten] = codeQuadrant(data, trials_loop, col)

if isequal(data.values(trials_loop, col.response),1) || isequal(data.values(trials_loop, col.responseOther),1)
    Links = 1;
    Rechts = 1 - Links;
elseif isequal(data.values(trials_loop, col.response),3) || isequal(data.values(trials_loop, col.responseOther),3)
    Links = 0;
    Rechts = 1 - Links;
end
if isequal(data.values(trials_loop, col.response),2) || isequal(data.values(trials_loop, col.responseOther),2)
    Oben = 1;
    Unten = 1 - Oben;
elseif isequal(data.values(trials_loop, col.response),4) || isequal(data.values(trials_loop, col.responseOther),4)
    Oben = 0;
    Unten = 1 - Oben;
end

end