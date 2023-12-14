function randChoice = randomChoice(OUich)

optionsOU = {2 4};
optionsLR = {1 3};
r = randi([1 2], 1);

if OUich == 1
    randChoice = optionsOU(r);
elseif OUich == 0
    randChoice = optionsLR(r);
end

end