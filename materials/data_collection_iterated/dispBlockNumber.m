function dispBlockNumber(text, screen, participant)
%{
s1 = [text.block, num2str(1)];
s2 = [text.block, num2str(2)];
s3 = [text.block, num2str(3)];

if i == 1
    msg = s1;
elseif i == 2
    msg = s2;
elseif i ==3
    msg = s3;
end
%}

if participant.num == 0
    msg = text.training;
elseif participant.num == 1
    msg = text.ersterBlock;
elseif participant.num > 1
    msg = text.naechsterBlock;
end

instructions(text, msg, screen);

end